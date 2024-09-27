local Buckets = require '__LunarLandings__.scripts.buckets'

local flame_lifetime = 120
local shielding_radius = 6
local coverage = 0.85
local whitelist = {
  ['ll-shielding-wall'] = 'll-shielding-wall',
  ['ll-shielding-gate'] = 'll-shielding-gate',
  ['stone-wall'] = 'll-shielding-wall',
  ['gate'] = 'll-shielding-gate',
}

---@type ScriptLib
local Shielding = {}

local function shielding_shape(area)
  local lt, rb = area.left_top, area.right_bottom
  return
  -- area
    {
      left_top = {
        x = lt.x - shielding_radius,
        y = lt.y - shielding_radius,
      },
      right_bottom = {
        x = rb.x + shielding_radius,
        y = rb.y + shielding_radius,
      }
    },
    -- perimeter
    2 * ((rb.x - lt.x) + (rb.y - lt.y))
end

local function replace_entity(old)
  local name = whitelist[old.name]
  local position = old.position
  local surface = old.surface
  local direction = old.direction
  local force = old.force
  local player = old.last_user
  local damage = old.prototype.max_health - old.health

  old.destroy()
  local new = surface.create_entity{
    name = name,
    position = position,
    direction = direction,
    force = force,
    player = player,
    create_build_effect_smoke = false,
    raise_built = false,
  }

  if not (new and new.valid) then
    return
  end

  if damage > 0 then
    new.damage(damage, game.forces.neutral)
  end
end

local function validate_entity(entity)
  local area, perimeter = shielding_shape(entity.selection_box)
  local count = entity.surface.count_entities_filtered{
    area = area,
    name = 'll-shielding-wall',
    force = entity.force
  } + math.floor(0.25 * entity.surface.count_entities_filtered{
    area = area,
    name = 'll-shielding-gate',
    force = entity.force
  })
  return count >= math.ceil(perimeter * coverage)
end

local function on_entity_built(event)
  local entity = event.created_entity or event.entity or event.destination
  local surface = entity.surface

  if not (entity and entity.valid) then
    return
  end

  if not (surface and surface.name == 'luna') then
    return
  end

  if whitelist[entity.name] then
    local player = game.get_player(event.player_index or '')
    if player and player.valid then
      player.create_local_flying_text{ text = {'gui-shielding.on_built'}, position = entity.position }
    end
    replace_entity(entity)
    return
  end

  if entity.type == 'assembling-machine' or entity.type == 'furnace' then
    if not validate_entity(entity) then
      local player = game.get_player(event.player_index or '')
      if player and player.valid then
        player.create_local_flying_text{ text = {'gui-shielding.exposed_machine', 'entity-name.'..entity.name}, position = entity.position }
      end
      Buckets.add(global.radiation_targets, entity.unit_number, {
        entity = entity,
        tick = game.tick,
      })
    end
  end
end

local function on_entity_destroyed(event)
  local entity = event.entity
  local surface = entity.surface

  if not (surface and surface.name == 'luna') then
    return
  end

  if not whitelist[entity.name] then
    return
  end

  local player = game.get_player(event.player_index or '')
  if player and player.valid then
    player.create_local_flying_text{ text = {'gui-shielding.on_destroy'}, position = entity.position }
  end

  -- validate all machines in radius
  for _, machine in pairs(surface.find_entities_filtered{
    position = entity.position,
    radius = shielding_radius,
    type = {'assembling-machine', 'furnace'},
    force = entity.force,
  }) do
    local id = machine.unit_number
    if not Buckets.get(global.radiation_targets, id) then
      if not validate_entity(machine) then
        Buckets.add(global.radiation_targets, id, {
          entity = machine,
          tick = game.tick,
        })
      end
    end
  end
end

local function on_tick(event)
  local tick = event.tick
  for unit_number, rt_data in pairs(Buckets.get_bucket(global.radiation_targets, event.tick)) do
    local entity = rt_data.entity
    if entity.valid and not validate_entity(entity) then
      if tick >= (rt_data.tick + flame_lifetime) then
        entity.surface.create_entity{ name = 'fire-flame', position = entity.position, force = 'neutral' } 
        rt_data.tick = event.tick
      end
    else
      Buckets.remove(global.radiation_targets, unit_number)
    end
  end
end

Shielding.events = {
  [defines.events.on_tick] = on_tick,
  -- Build
  [defines.events.on_built_entity] = on_entity_built,
  [defines.events.on_entity_cloned] = on_entity_built,
  [defines.events.on_robot_built_entity] = on_entity_built,
  [defines.events.script_raised_built] = on_entity_built,
  [defines.events.script_raised_revive] = on_entity_built,
  -- Destroy
  [defines.events.on_entity_died] = on_entity_destroyed,
  [defines.events.script_raised_destroy] = on_entity_destroyed,
  [defines.events.on_player_mined_entity] = on_entity_destroyed,
  [defines.events.on_robot_mined_entity] = on_entity_destroyed,
}

function Shielding.on_init()
  global.radiation_targets = global.radiation_targets or Buckets.new(flame_lifetime)
end

function Shielding.on_configuration_changed()
  global.radiation_targets = global.radiation_targets or Buckets.new(flame_lifetime)
end

return Shielding
