local Buckets = require '__LunarLandings__.scripts.buckets'
local Queue = require '__eternal-winter__.scripts.queue'

local sqrt_2 = 1.41421
local sqrt_3 = 1.73205
local radius = 52
local diameter = 2 * radius
local cooldown = 60 * 20
local flare = 'll-artillery-flare'

local remote = {
  bombardment = 'll-gmo-artillery-bombardment-remote',
  smart       = 'll-gmo-artillery-smart-remote',
  exploration = 'll-gmo-artillery-exploration-remote',
}

local function new_force()
  return { shells = 0 }
end

local function position_to_chunk(position)
	return {
		x = math.floor(position.x / 32),
		y = math.floor(position.y / 32)
	}
end

-- Aidiakapi#2177
-- https://gist.github.com/Aidiakapi/a1b4e603c37f1121686d372e542d4339
local function chunk_to_chunkid(chunk_x, chunk_y)
	if chunk_x < 0 then
		chunk_x = 0x10000 + chunk_x
	end

	if chunk_y < 0 then
		chunk_y = 0x10000 + chunk_y
	end

	return bit32.bor(chunk_x, bit32.lshift(chunk_y, 16))
end

-- Aidiakapi#2177
-- https://gist.github.com/Aidiakapi/a1b4e603c37f1121686d372e542d4339
local function chunkid_to_chunk(chunkid)
	local chunk_x = bit32.band(chunkid, 0xffff)
	local chunk_y = bit32.rshift(chunkid, 16)

	if chunk_x >= 0x8000 then
		chunk_x = chunk_x - 0x10000
	end

	if chunk_y >= 0x8000 then
		chunk_y = chunk_y - 0x10000
	end

	return chunk_x, chunk_y
end

-- EnigmaticAussie#9641
local function chunkid_to_chunk_position(chunkid)
	local chunk_x, chunk_y = chunkid_to_chunk(chunkid)
	chunk_x = chunk_x * 32 + 16
	chunk_y = chunk_y * 32 + 16
	return chunk_x, chunk_y
end

local function on_bombardment_remote(event)
  local player = game.get_player(event.player_index or '')
  if not (player and player.valid) then
    return
  end

  local surface = player.surface
  local force = player.force
  local lt, rb = event.area.left_top, event.area.right_bottom
  local x_offset = math.floor(((rb.x - lt.x) % diameter) / 2)
  local y_offset = math.floor(((rb.y - lt.y) % diameter) / 2)

  global.gmo_targets[force.index] = global.gmo_targets[force.index] or Queue.new()

  for x = lt.x + x_offset, rb.x, diameter do
    for y = lt.y + y_offset, rb.y, diameter do
      local placeholder = surface.create_entity{
        name = flare,
        position = {x, y},
        force = force,
        movement = {0, 0},
        height = 0,
        vertical_speed = 0,
        frame_speed = 0,
        raise_built = true,
      }
      if placeholder and placeholder.valid then
        Queue.push(global.gmo_targets[force.index], {
          position = placeholder.position,
          surface = placeholder.surface.index,
          tick = game.tick,
          flare = placeholder,
        })
      end
    end
  end
end

local function on_smart_remote(event)
  local player = game.get_player(event.player_index or '')
  if not (player and player.valid) then
    return
  end

  local surface = player.surface
  local force = player.force
  local lt, rb = event.area.left_top, event.area.right_bottom

  global.gmo_targets[force.index] = global.gmo_targets[force.index] or Queue.new()

  if lt.x == rb.x or lt.y == rb.y then
    return
  end

  local r_2 = radius*radius
  local points_hit = {}
  local military_targets = surface.find_entities_filtered{
    area = event.area,
    force = 'enemy',
    type = {'unit-spawner', 'turret'}, -- 'simple-entity-with-force', 'radar', 'player-port' for MP forces
  }
  -- Add targets
  local is_chunk_charted = force.is_chunk_charted
  for _, entity in pairs(military_targets) do
    local position = entity.position

    if not is_chunk_charted(surface, position_to_chunk(position)) then
      goto SKIP
    end
    
    for _, v in pairs(points_hit) do
      local x_dist = position.x - v.x
      local y_dist = position.y - v.y
      if x_dist*x_dist + y_dist*y_dist <= r_2 then
        goto SKIP
      end
    end

    local placeholder = surface.create_entity{
      name = flare,
      position = position,
      force = force,
      movement = {0, 0},
      height = 0,
      vertical_speed = 0,
      frame_speed = 0,
      raise_built = true,
    }
    if placeholder and placeholder.valid then
      points_hit[#points_hit+1] = placeholder.position
      Queue.push(global.gmo_targets[force.index], {
        position = placeholder.position,
        surface = placeholder.surface.index,
        tick = game.tick,
        flare = placeholder,
      })
    end

    ::SKIP::
  end

  -- Reveal hidden chunks (is it even needed??)
  local lt_chunk, rb_chunk = position_to_chunk(lt), position_to_chunk(rb)
  for x = lt_chunk.x, rb_chunk.x do
    for y = lt_chunk.y, rb_chunk.y do
      if not is_chunk_charted(surface, {x, y}) then
        surface.create_entity{
          name = 'artillery-flare',
          position = {(x * 32) + 16, (y * 32) + 16},
          force = force,
          movement = {0, 0},
          height = 0,
          vertical_speed = 0,
          frame_speed = 0,
        }
      end
    end
  end
end

local function on_exploration_remote(event)
  if true then
    return -- currently disabled
  end

  local player = game.get_player(event.player_index or '')
  if not (player and player.valid) then
    return
  end

  local surface = player.surface
  local force = player.force
  local lf, rb = event.area.left_top, event.area.right_bottom

  global.gmo_chunks[force.index] = global.gmo_chunks[force.index] or {}

  local artilleries = surface.find_entities_filtered{
    area = event.area,
    force = force,
    type = {'artillery-turret', 'artillery-wagon'},
  }

  -- compute arty range
  local range = game.item_prototypes['artillery-wagon-cannon'].attack_parameters.range * (1 + force.artillery_range_modifier) * 2.5 - (2 * 32 / 3)

  for _, entity in pairs(artilleries) do
    local arty_chunk_position = position_to_chunk(entity.position)
    local arty_chunk_id = chunk_to_chunkid(arty_chunk_position.x, arty_chunk_position.y)

    if not global.gmo_chunks[force.index][arty_chunk_id] then
      global.gmo_chunks[force.index][arty_chunk_id] = {
        force = force,
        surface = surface,
        range = range,
        i = 1,
      }
    end
  end
end

local function atomic_explosion(surface, force, position)
  
end

local function strike(target, force)
  local surface = game.get_surface(target.surface or '')
  local position = target.position
  local flare = target.flare
  if not position or not (surface and surface.valid) or not (force and force.valid) then
    return false
  end

  if flare and flare.valid then
    flare.destroy()
  end

  local target_entity = nil
  local r = 1
  while not target_entity and r <= radius do
    local targets = surface.find_entities_filtered{
      position = position,
      radius = r,
      force = force,
      invert = true,
      limit = 1,
    }
    target_entity = targets and targets[1]
    r = r + 1
  end

  if not (target_entity and target_entity.valid) then
    return false
  end

  if not (target_entity.health and target_entity.health > 0) then
    return false
  end

  local targets = surface.find_entities_filtered{
    position = position,
    radius = radius,
    force = force,
    invert = true,
  }

  force.chart(surface, {
    left_top = { x = position.x - radius, y = position.y - radius },
    right_bottom = { x = position.x + radius, y = position.y + radius }
  })

  surface.create_entity{
    name = 'atomic-rocket',
    position = target_entity.position,
    target = target_entity,
    source = target_entity,
    force = force,
    speed = 1,
    max_range = diameter,
  }

  for _, entity in pairs(targets) do
    entity.die(force)
  end

  return true
end

local function update_entity(entity)
  if not (entity and entity.valid) then
    return
  end

  local force_id = entity.force.index
  global.gmo_forces[force_id] = global.gmo_forces[force_id] or new_force()
  local data = global.gmo_forces[force_id]

  data.shells = data.shells + (entity.products_finished or 0)
  entity.products_finished = 0
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= "ll-graviton-matter-obliterator-created" then return end

  local entity = event.target_entity  
  Buckets.add(global.gmos, entity.unit_number, { entity = entity })
  script.register_on_entity_destroyed(entity)
  update_entity(entity)
end

local function on_entity_destroyed(event)
  local entity_data = Buckets.get(global.gmos, event.unit_number)
  if not entity_data then return end

  if entity_data then
    update_entity(entity_data.entity)
    Buckets.remove(global.gmos, event.unit_number)
  end
end

local remote_actions = {
  [remote.bombardment] = on_bombardment_remote,
  [remote.smart]       = on_smart_remote,
  [remote.exploration] = on_exploration_remote,
}

local function on_player_selected_area(event)
  local action = remote_actions[event.item]
  if action then action(event) end
end

local function on_player_alt_selected_area(event)
  if not (event.item == remote.bombardment or event.item == remote.smart) then
    return
  end

  local player = game.get_player(event.player_index or '')
  if not (player and player.valid) then
    return
  end

  local surface = player.surface
  local force = player.force

  global.gmo_targets[force.index] = global.gmo_targets[force.index] or Queue.new()

  local flares = surface.find_entities_filtered{
    area = event.area,
    name = flare,
    force = force,
  }

  for _, entity in pairs(flares) do
    local pos_e = entity.position
    for k, v in Queue.pairs(global.gmo_targets[force.index]) do
      local pos_q = v.position
      -- same position and same force
      if pos_e.x == pos_q.x and pos_e.y == pos_q.y and entity.force.index == v.force.index then
        Queue.fast_remove(global.gmo_targets[force.index], k)
        entity.destroy()
        break
      end
    end
  end
end

local function on_tick(event)
  -- Check GMOs
  for unit_number, rc_data in pairs(Buckets.get_bucket(global.gmos, event.tick)) do
    local entity = rc_data.entity
    if entity.valid then
      update_entity(entity)
    else
      Buckets.remove(global.gmos, unit_number)
    end
  end

  -- Consume targets queue 1/tick/force
  for _, force in pairs(game.forces) do
    if global.gmo_targets[force.index] and global.gmo_forces[force.index] then
      local data = global.gmo_forces[force.index]
      local target = Queue.pop(global.gmo_targets[force.index])
      if data.shells > 0 and target then
        if target.tick + cooldown < game.tick then
          local success = strike(target, force) and 1 or 0
          data.shells = data.shells - success
        else
          Queue.push(global.gmo_targets[force.index], target)
        end
      end
    end
  end
end

---@type ScriptLib
local GMO = {}

GMO.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_player_selected_area] = on_player_selected_area,
  [defines.events.on_player_alt_selected_area] = on_player_alt_selected_area,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_entity_destroyed] = on_entity_destroyed,
}

function GMO.on_init()
  global.gmos = global.gmos or Buckets.new()
  global.gmo_forces = global.gmo_forces or {}
  global.gmo_targets = global.gmo_targets or {}
  global.gmo_chunks = global.gmo_chunks or {}
end

function GMO.on_configuration_changed()
  global.gmos = global.gmos or Buckets.new()
  global.gmo_forces = global.gmo_forces or {}
  global.gmo_targets = global.gmo_targets or {}
  global.gmo_chunks = global.gmo_chunks or {}
end

return GMO
