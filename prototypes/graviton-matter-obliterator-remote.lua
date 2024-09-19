local remote = {
  bombardment = 'll-gmo-artillery-bombardment-remote',
  smart       = 'll-gmo-artillery-smart-remote',
  exploration = 'll-gmo-artillery-exploration-remote',
}

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
    flags = {'mod-openable'},
    stack_size = 1,
    stackable = false,
    selection_color = {r = 1, g = 0.28, b = 0, a = 1},
    alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
    selection_mode = {'enemy'},
    alt_selection_mode = {'enemy'},
    selection_cursor_box_type = 'entity',
    alt_selection_cursor_box_type = 'entity'
  },
  -- Recicpe
  {
    type = 'recipe',
    name = remote.bombardment,
    enabled = false,
    ingredients = {
      {'artillery-targeting-remote', 5},
      {'satellite', 1}
    },
    result = remote.bombardment
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
    effects = { { type = 'unlock-recipe', recipe = remote.bombardment } },
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
    flags = {'mod-openable'},
    stack_size = 1,
    stackable = false,
    selection_color = {r = 1, g = 0.28, b = 0, a = 1},
    alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
    selection_mode = {'enemy'},
    alt_selection_mode = {'enemy'},
    selection_cursor_box_type = 'entity',
    alt_selection_cursor_box_type = 'entity'
  },
  -- Recipe
  {
    type = 'recipe',
    name = remote.smart,
    enabled = false,
    ingredients = {
      {remote.bombardment, 3}
    },
    result = remote.smart
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
    effects = { { type = 'unlock-recipe', recipe = remote.smart } },
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
    flags = {},
    stack_size = 1,
    stackable = false,
    selection_color = {r = 1, g = 0.28, b = 0, a = 1},
    alt_selection_color = {r = 0, g = 0, b = 1, a = 1},
    selection_mode = {'same-force'},
    alt_selection_mode = {'enemy'},
    selection_cursor_box_type = 'entity',
    alt_selection_cursor_box_type = 'entity',
    entity_filters = {'artillery-turret', 'artillery-wagon'}
  },
  -- Recipe
  {
    type = 'recipe',
    name = remote.exploration,
    enabled = false,
    ingredients = {
      {remote.smart, 2}
    },
    result = remote.exploration
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
    effects = { { type = 'unlock-recipe', recipe = remote.exploration } },
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