local ew_util = require '__eternal-winter__.prototypes.ew-util'
local se_path = '__space-exploration-graphics__/graphics/icons/'

data:extend({
  -- Fluid
  {
    type = 'fluid',
    name = 'll-helium',
    default_temperature = -269,
    max_temperature = 1000,
    gas_temperature = -268,
    heat_capacity = '0.25KJ',
    icon = se_path .. 'fluid/ion-stream.png',
    icon_size = 64,
    icon_mipmaps = 1,
    base_color = { r = 173, g = 216, b = 230 },
    flow_color = { r = 173, g = 216, b = 230 },
    order = 'g[gas]-b[coolant-3]',
    auto_barrel = false,
  },
  -- Recipe
  {
    name = 'll-helium',
    type = 'recipe',
    category = 'oil-processing',
    enabled = false,
    energy_required = 5,
    ingredients = {
      { type = 'fluid', name = 'steam', amount = 50, fluidbox_index = 1 },
      { type = 'fluid', name = 'crude-oil', amount = 100, fluidbox_index = 2 },
      { type = 'item', name = 'll-rich-moon-rock', amount = 5 },
    },
    results = {
      { type = 'fluid', name = 'll-helium', amount = 5, temperature = -183, fluidbox_index = 1 },
      { type = 'fluid', name = 'light-oil', amount = 25, fluidbox_index = 2 },
    },
    main_product = 'll-helium',
    subgroup = 'fluid-recipes',
    order = 'a[oil-processing]-d[ll-helium]',
    allow_decomposition = false,
    always_show_made_in = true,
    enabled = false,
    hidden = false,
    hide_from_player_crafting = false,
  },
  {
    name = 'll-helium-cooling',
    type = 'recipe',
    category = 'chemistry',
    energy_required = 10,
    ingredients = {
      { type = 'item', name = 'll-ice', amount = 2 },
      { type = 'fluid', name = 'll-helium', amount = 100, maximum_temperature = -183 },
    },
    results = {
      { type = 'fluid', name = 'll-helium', amount = 100, temperature = -268 },
      { type = 'fluid', name = 'water', amount = 100 },
    },
    icons = {
      { icon = se_path .. 'water-ice.png', icon_size = 64, icon_mipmaps = 1, shift = { 4, -4 } },
      { icon = se_path .. 'fluid/ion-stream.png', icon_size = 64, icon_mipmaps = 1, scale = 0.45, shift = { -4, 4 } },
      { icon = se_path .. 'transition-arrow.png', icon_size = 64, icon_mipmaps = 1, scale = 0.5 },
    },
    crafting_machine_tint = {
      primary    = { r = 224, g = 255, b = 255 },
      secondary  = { r = 224, g = 255, b = 255 },
      tertiary   = { r = 224, g = 255, b = 255 },
      quaternary = { r = 224, g = 255, b = 255 },
    },
    subgroup = 'fluid-recipes',
    order = 'b[fluid-chemistry]-c[light-oil-cracking]',
    allow_decomposition = false,
    always_show_made_in = true,
    enabled = false,
    hidden = false,
    hide_from_player_crafting = false,
  },
  {
    name = 'll-helium',
    type = 'technology',
    effects = {
      { type = 'unlock-recipe', recipe = 'll-helium' },
      { type = 'unlock-recipe', recipe = 'll-helium-cooling' },
    },
    icon = '__space-exploration-graphics__/graphics/technology/cryonite-processing.png',
    icon_size = 128,
    order = 'e-g',
    prerequisites = { 'll-rich-moon-rock-processing' },
    unit = {
      count = 400,
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

ew_util.allow_productivity('ll-helium')
