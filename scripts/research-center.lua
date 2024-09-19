local Buckets = require '__LunarLandings__.scripts.buckets'
local gui = require '__LunarLandings__.scripts.gui-lite'

---@type ScriptLib
local ResearchCenter = {}

local RC_LEVELS = { 500, 2500, 10000, 50000, 200000 }

local function new_force()
  return { crafts = 0, target = RC_LEVELS[1], level = 0 }
end

local function build_gui(player)
  local anchor = {gui = defines.relative_gui_type.assembling_machine_gui, position = defines.relative_gui_position.right, name = 'll-research-center'}

  return gui.add(player.gui.relative, {
    {
      type = 'frame',
      name = 'll-research-center-relative-frame',
      direction = 'vertical',
      anchor = anchor,
      style_mods = {width = 240},
      children = {
        {type = 'label', style = 'frame_title', caption = {'gui-research-center.title'}, ignored_by_interaction = true},
        {type = 'flow', direction = 'vertical', style = 'inset_frame_container_vertical_flow', children = {
          {type = 'frame', direction = 'vertical', style = 'inside_shallow_frame_with_padding', children = {
              {type = 'label', name = 'll-research-center-textfield', text = ''},
              {type = 'progressbar', name = 'll-research-center-progressbar', value = 0}
            }
          },
        }},
      }
    }
  })
end

gui.add_handlers(ResearchCenter,
  function(event, handler)
    local player = game.get_player(event.player_index)
    local entity = player.opened
    if not entity or not entity.valid then return end
    local entity_data = Buckets.get(global.research_centers, entity.unit_number)
    handler(player, event.element, entity, entity_data)
  end
)

local function update_gui(player)
  local main_frame = player.gui.relative['ll-research-center-relative-frame']
  if not main_frame then
    return
  end
  
  local elems = main_frame.children[2].children[1].children
  local data = global.research_center_forces[player.force.index]
  local lvl = data.level

  local textfield = elems[1]
  local color = (lvl == 0 and 'red') or (lvl == #RC_LEVELS and 'green') or 'blue'
  textfield.caption = {'gui-research-center.level', color, lvl, #RC_LEVELS}

  local progressbar = elems[2]
  progressbar.value = lvl == #RC_LEVELS and 1 or math.min(1, data.crafts / data.target)
end

local function on_gui_opened(event)
  local entity = event.entity
  if not entity or not entity.valid then return end
  if entity.name ~= 'll-research-center' then return end
  local player = game.get_player(event.player_index)

  if not player.gui.relative['ll-research-center-relative-frame'] then
    global.research_center_guis[player.index] = build_gui(player)
  end
  update_gui(player)
end


local function update_entity(entity)
  if not (entity and entity.valid) then
    return
  end

  local force_id = entity.force.index
  global.research_center_forces[force_id] = global.research_center_forces[force_id] or new_force()
  local data = global.research_center_forces[force_id]

  data.crafts = data.crafts + (entity.products_finished or 0)
  entity.products_finished = 0

  -- Upgrade technology level
  if data.level < #RC_LEVELS and data.crafts >= data.target then
    data.level = data.level + 1
    data.target = RC_LEVELS[data.level + 1]
    for _, p in pairs(entity.force.connected_players) do
      if player and player.valid then
        player.print({'gui-research-center.toast', data.level})
      end
    end
    entity.force.play_sound{path = 'utility/new_objective', volume_modifier = 0.8}
  end

  -- Disable & remove completed researches to not loop their research servers anymore or use them as void resource
  if data.level == #RC_LEVELS then
    entity.active = false
    Buckets.remove(global.research_centers, entity.unit_number)
  end
end

local function on_script_trigger_effect(event)
  if event.effect_id ~= 'll-research-center-created' then return end

  local entity = event.target_entity  
  Buckets.add(global.research_centers, entity.unit_number, { entity = entity })
  script.register_on_entity_destroyed(entity)
  update_entity(entity)
end

local function on_entity_destroyed(event)
  local entity_data = Buckets.get(global.research_centers, event.unit_number)
  if not entity_data then return end

  if entity_data then
    update_entity(entity_data.entity)
    Buckets.remove(global.research_centers, event.unit_number)
  end
end

local function on_tick(event)
  for unit_number, rc_data in pairs(Buckets.get_bucket(global.research_centers, event.tick)) do
    local entity = rc_data.entity
    if entity.valid then
      update_entity(entity)
    else
      Buckets.remove(global.research_centers, unit_number)
    end
  end

  if event.tick % 60 == 1 then
    for _, player in pairs(game.connected_players) do
      update_gui(player)
    end
  end
end

ResearchCenter.events = {
  [defines.events.on_tick] = on_tick,
  [defines.events.on_gui_opened] = on_gui_opened,
  [defines.events.on_script_trigger_effect] = on_script_trigger_effect,
  [defines.events.on_entity_destroyed] = on_entity_destroyed,
}

function ResearchCenter.on_init()
  global.research_centers = global.research_centers or Buckets.new()
  global.research_center_forces = global.research_center_forces or {}
  global.research_center_guis = global.research_center_guis or {}
end

function ResearchCenter.on_configuration_changed()
  global.research_centers = global.research_centers or Buckets.new()
  global.research_center_forces = global.research_center_forces or {}
  global.research_center_guis = global.research_center_guis or {}
end

return ResearchCenter
