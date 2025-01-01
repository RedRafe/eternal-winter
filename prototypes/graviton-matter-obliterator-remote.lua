local remote = {
  bombardment = 'll-gmo-artillery-bombardment-remote',
  smart       = 'll-gmo-artillery-smart-remote',
  exploration = 'll-gmo-artillery-exploration-remote',
}

local selection_color = {r = 1, g = 0.28, b = 0, a = 1}
local alt_selection_color = {r = 0, g = 0, b = 1, a = 1}

local enemy_mode = function(color)
  return {
    border_color = color,
    cursor_box_type = 'multiplayer-entity',
    mode = {
      'enemy'
    },
  }
end

local exploration_mode = function(mode, color)
  return {
    border_color = color,
    cursor_box_type = 'multiplayer-entity',
    mode = mode,
    entity_filter_mode = 'whitelist',
    entity_type_filters = {
      'artillery-turret',
      'artillery-wagon',
    },
  }
end

data:extend({
  -- [[ Bombardment ]]
  -- Item
  {
    type = 'selection-tool',
    name = remote.bombardment,
    subgroup = 'defensive-structure',
    order = 'b[turret]-d[artillery-turret]-d',
    icons = {
      {
        icon = '__eternal-winter__/graphics/icons/artillery-bombardment-remote.png',
        icon_size = 32
      },
    },
    flags = { 'mod-openable', 'only-in-cursor', 'not-stackable', 'spawnable' },
    stack_size = 1,
    select = enemy_mode(selection_color),
    alt_select = enemy_mode(alt_selection_color),
    reverse_select = enemy_mode(selection_color),
    alt_reverse_select = enemy_mode(alt_selection_color),
  },
  -- Shortcut
  {
    type = 'shortcut',
    name = 'give-'..remote.bombardment,
    action = 'spawn-item',
    technology_to_unlock = remote.bombardment,
    item_to_spawn = remote.bombardment,
    icon = '__eternal-winter__/graphics/icons/artillery-bombardment-remote.png',
    icon_size = 32,
    small_icon = '__eternal-winter__/graphics/icons/artillery-bombardment-remote.png',
    small_icon_size = 32,
  },
  -- Technology
  {
    name = remote.bombardment,
    type = 'technology',
    icons = {
      {
        icon = '__space-exploration-graphics__/graphics/technology/delivery-cannon.png',
        icon_size = 128,
      },
      {
        icon = '__eternal-winter__/graphics/icons/artillery-bombardment-remote.png',
        icon_size = 32,
        scale = 1,
        shift = {49, 49},
      },
    },
    effects = { },
    order = 'e-h',
    prerequisites = { 'll-graviton-matter-obliterator' },
    unit = {
      count = 500,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'production-science-pack', 1 },
        { 'utility-science-pack', 1 },
        { 'll-space-science-pack', 1 },
        { 'll-quantum-science-pack', 1 },
      },
      time = 60,
    },
  },
  -- [[ Smart ]]
  -- Item
  {
    type = 'selection-tool',
    name = remote.smart,
    subgroup = 'defensive-structure',
    order = 'b[turret]-d[artillery-turret]-e',
    icons = {
      {
        icon = '__eternal-winter__/graphics/icons/artillery-smart-remote.png',
        icon_size = 32
      }
    },
    flags = { 'mod-openable', 'only-in-cursor', 'not-stackable', 'spawnable' },
    stack_size = 1,
    select = enemy_mode(selection_color),
    alt_select = enemy_mode(alt_selection_color),
    reverse_select = enemy_mode(selection_color),
    alt_reverse_select = enemy_mode(alt_selection_color),
  },
  -- Shortcut
  {
    type = 'shortcut',
    name = 'give-'..remote.smart,
    action = 'spawn-item',
    technology_to_unlock = remote.smart,
    item_to_spawn = remote.smart,
    icon = '__eternal-winter__/graphics/icons/artillery-smart-remote.png',
    icon_size = 32,
    small_icon = '__eternal-winter__/graphics/icons/artillery-smart-remote.png',
    small_icon_size = 32,
  },
  -- Technology
  {
    name = remote.smart,
    type = 'technology',
    icons = {
      {
        icon = '__space-exploration-graphics__/graphics/technology/delivery-cannon.png',
        icon_size = 128,
      },
      {
        icon = '__eternal-winter__/graphics/icons/artillery-smart-remote.png',
        icon_size = 32,
        scale = 1,
        shift = {49, 49},
      },
    },
    effects = { },
    order = 'e-h',
    prerequisites = { remote.bombardment },
    unit = {
      count = 600,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'production-science-pack', 1 },
        { 'utility-science-pack', 1 },
        { 'll-space-science-pack', 1 },
        { 'll-quantum-science-pack', 1 },
      },
      time = 60,
    },
  },
  -- [[ Exploration ]]
  -- Item
  {
    type = 'selection-tool',
    name = remote.exploration,
    subgroup = 'defensive-structure',
    order = 'b[turret]-d[artillery-turret]-f',
    icons = {
      {
        icon = '__eternal-winter__/graphics/icons/artillery-exploration-remote.png',
        icon_size = 32
      }
    },
    flags = { 'mod-openable', 'only-in-cursor', 'not-stackable', 'spawnable' },
    stack_size = 1,
    select = exploration_mode({'same-force'}, selection_color),
    alt_select = exploration_mode({'enemy'}, alt_selection_color),
    reverse_select = exploration_mode({'same-force'}, selection_color),
    alt_reverse_select = exploration_mode({'enemy'}, alt_selection_color),
  },
  -- Shortcut
  {
    type = 'shortcut',
    name = 'give-'..remote.exploration,
    action = 'spawn-item',
    technology_to_unlock = remote.exploration,
    item_to_spawn = remote.exploration,
    icon = '__eternal-winter__/graphics/icons/artillery-exploration-remote.png',
    icon_size = 32,
    small_icon = '__eternal-winter__/graphics/icons/artillery-exploration-remote.png',
    small_icon_size = 32,
  },
  -- Technology
  {
    name = remote.exploration,
    type = 'technology',
    enabled = false,
    hidden = true, -- TODO: implement exploration mode
    icons = {
      {
        icon = '__space-exploration-graphics__/graphics/technology/delivery-cannon.png',
        icon_size = 128,
      },
      {
        icon = '__eternal-winter__/graphics/icons/artillery-exploration-remote.png',
        icon_size = 32,
        scale = 1,
        shift = {49, 49},
      },
    },
    effects = { },
    order = 'e-i',
    prerequisites = { remote.smart },
    unit = {
      count = 800,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'production-science-pack', 1 },
        { 'utility-science-pack', 1 },
        { 'll-space-science-pack', 1 },
        { 'll-quantum-science-pack', 1 },
      },
      time = 60,
    },
  },
})