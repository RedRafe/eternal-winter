local ew_util = require '__eternal-winter__.prototypes.ew-util'
local hit_effects = require '__base__.prototypes.entity.hit-effects'
local sounds = require '__base__.prototypes.entity.sounds'
local se_path = '__space-exploration-graphics__/graphics/icons/'
local heat_exchanger = table.deepcopy(data.raw.boiler['heat-exchanger'])
local th_animation_speed = 1 / 40

data:extend({
  -- Recipe cat.
  { name = 'll-terraform', type = 'recipe-category' },
  -- Processing
  {
    type = 'recipe',
    name = 'll-burn-wood',
    icons = {
      { icon = '__base__/graphics/icons/wood.png', icon_size = 64, icon_mipmaps = 4 },
      { icon = '__base__/graphics/icons/coal.png', icon_size = 64, icon_mipmaps = 4, scale = 0.33, shift = { -8, 8 } },
      { icon = se_path .. 'transition-arrow.png', icon_size = 64, icon_mipmaps = 1, scale = 0.5 },
    },
    category = 'll-terraform',
    subgroup = 'fluid-recipes',
    energy_required = 60,
    enabled = false,
    ingredients = {
      { 'wood', 40 },
      { type = 'fluid', name = 'll-oxygen', amount = 100 }
    },
    results = {
      { type = 'item', name = 'coal', amount = 200 },
      { type = 'fluid', name = 'steam', amount = 100, temperature = 315 },
    },
    allow_decomposition = false,
    always_show_made_in = true,
    enabled = false,
    hidden = false,
    hide_from_player_crafting = true,
  },
  -- Item
  {
    name = 'll-terraform-hub',
    type = 'item',
    icon = se_path .. 'growth-facility.png',
    icon_size = 64,
    subgroup = 'production-machine',
    order = 'g[lab]-2',
    place_result = 'll-terraform-hub',
    stack_size = 10,
  },
  -- Recipe
  {
    type = 'recipe',
    name = 'll-terraform-hub',
    category = 'crafting-with-fluid',
    enabled = false,
    energy_required = 40,
    ingredients = {
      { 'concrete', 100 },
      { 'steel-plate', 50 },
      { 'advanced-circuit', 100 },
      { 'landfill', 100 },
      { type = 'fluid', name = 'water', amount = 800 },
    },
    result = 'll-terraform-hub',
  },
  -- Entity
  {
    type = 'assembling-machine',
    name = 'll-terraform-hub',
    icon = se_path .. 'growth-facility.png',
    icon_size = 64,
    flags = { 'placeable-neutral', 'placeable-player', 'player-creation' },
    minable = { mining_time = 0.2, result = 'll-terraform-hub' },
    max_health = 1500,
    corpse = 'big-remnants',
    dying_explosion = 'medium-explosion',
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = { { -4.3, -4.3 }, { 4.3, 4.3 } },
    selection_box = { { -4.5, -4.5 }, { 4.5, 4.5 } },
    drawing_box = { { -4.5, -4.9 }, { 4.5, 4.5 } },
    resistances = { { type = 'impact', percent = 10 } },
    fluid_boxes = {
      {
        production_type = 'input',
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = { { type = 'input', position = { -5, 0 } } },
        secondary_draw_orders = { north = -1 },
      },
      {
        production_type = 'input',
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = -1,
        pipe_connections = { { type = 'input', position = { 0, -5 } } },
        secondary_draw_orders = { north = -1 },
      },
      {
        production_type = 'output',
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = 'output', position = { 0, 5 } } },
        secondary_draw_orders = { north = -1 },
      },
      {
        production_type = 'output',
        pipe_covers = pipecoverspictures(),
        base_area = 10,
        base_level = 1,
        pipe_connections = { { type = 'output', position = { 5, 0 } } },
        secondary_draw_orders = { north = -1 },
      },
      off_when_no_fluid_recipe = false,
    },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = { filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = { filename = '__base__/sound/idle1.ogg', volume = 0.6 },
      sound = { { filename = '__base__/sound/chemical-plant.ogg', volume = 0.8 } },
    },
    animation = {
      layers = {
        {
          filename = '__space-exploration-graphics-3__/graphics/entity/growth-facility/sr/growth-facility.png',
          priority = 'high',
          width = 4032 / 7 / 2,
          height = 3360 / 5 / 2,
          frame_count = 32,
          line_length = 7,
          shift = util.by_pixel(0, -24),
          animation_speed = th_animation_speed,
          hr_version = {
            filename = '__space-exploration-graphics-3__/graphics/entity/growth-facility/hr/growth-facility.png',
            priority = 'high',
            width = 4032 / 7,
            height = 3360 / 5,
            frame_count = 32,
            line_length = 7,
            shift = util.by_pixel(0, -24),
            animation_speed = th_animation_speed,
            scale = 0.5,
          },
        },
        {
          draw_as_shadow = true,
          filename = '__space-exploration-graphics-3__/graphics/entity/growth-facility/sr/growth-facility-shadow.png',
          priority = 'high',
          width = 618 / 2,
          height = 570 / 2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 32,
          shift = util.by_pixel(8, 2),
          animation_speed = th_animation_speed,
          hr_version = {
            draw_as_shadow = true,
            filename = '__space-exploration-graphics-3__/graphics/entity/growth-facility/hr/growth-facility-shadow.png',
            priority = 'high',
            width = 618,
            height = 570,
            frame_count = 1,
            line_length = 1,
            repeat_count = 32,
            shift = util.by_pixel(8, 2),
            animation_speed = th_animation_speed,
            scale = 0.5,
          },
        },
      },
    },
    crafting_categories = { 'll-terraform' },
    crafting_speed = 1,
    energy_source = {
      type = 'heat',
      max_temperature = 1000,
      specific_heat = '1MJ',
      max_transfer = '2GW',
      min_working_temperature = 315,
      minimum_glow_temperature = 350,
      connections = {
        { position = { -2, -4 }, direction = defines.direction.north },
        { position = {  2, -4 }, direction = defines.direction.north },
        { position = { -2,  4 }, direction = defines.direction.south },
        { position = {  2,  4 }, direction = defines.direction.south },
        { position = { -4, -2 }, direction = defines.direction.west },
        { position = { -4,  2 }, direction = defines.direction.west },
        { position = {  4, -2 }, direction = defines.direction.east },
        { position = {  4,  2 }, direction = defines.direction.east },
      },
      pipe_covers = heat_exchanger.energy_source.pipe_covers,
      heat_pipe_covers = heat_exchanger.energy_source.heat_pipe_covers,
      heat_picture = heat_exchanger.energy_source.heat_picture,
    },
    energy_usage = '120kW',
    module_specification = { module_slots = 2 },
    allowed_effects = { 'consumption', 'speed', 'pollution' },
    working_visualisations = {
      {
        effect = 'uranium-glow', -- changes alpha based on energy source light intensity
        light = { intensity = 0.5, size = 24, shift = { 0.0, 0.0 }, color = { r = 0.7, g = 0.8, b = 1 } },
      },
    },
    surface_conditions = { nauvis = false, luna = { plain = true, lowland = false, mountain = true, foundation = true } },
  },
  -- Technology
  {
    name = 'll-terraform-hub',
    type = 'technology',
    effects = {
      { type = 'unlock-recipe', recipe = 'll-terraform-hub' },
      { type = 'unlock-recipe', recipe = 'll-burn-wood' },
    },
    icon = '__space-exploration-graphics__/graphics/technology/growth-facility.png',
    icon_size = 128,
    order = 'e-g',
    prerequisites = { 'll-arc-furnace' },
    unit = {
      count = 350,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'production-science-pack', 1 },
      },
      time = 60,
    },
  },
})

ew_util.allow_productivity('ll-burn-wood')

local effects = data.raw.technology['ll-terraform-hub'].effects

local function tree_item(name)
  return {
    name = name,
    type = 'item',
    icon = '__base__/graphics/icons/' .. name .. '.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'other',
    order = 'a[' .. name .. ']',
    stack_size = 100,
    place_result = name,
    surface_conditions = { nauvis = true, luna = false },
  }
end

local function tree_recipe(name)
  return {
    type = 'recipe',
    name = name,
    icon = '__base__/graphics/icons/' .. name .. '.png',
    icon_size = 64,
    icon_mipmaps = 4,
    category = 'll-terraform',
    energy_required = 60,
    enabled = false,
    ingredients = { { 'wood', 40 }, { type = 'fluid', name = 'water', amount = 400 } },
    results = {
      { type = 'fluid', name = 'water', amount = 350 },
      { type = 'fluid', name = 'll-oxygen', amount = 50 },
      { name, 1 },
    },
    main_product = name,
    allow_decomposition = false,
    always_show_made_in = true,
    enabled = false,
    hidden = false,
    hide_from_player_crafting = true,
  }
end

for _, name in pairs({
  'tree-01',
  'tree-02',
  'tree-03',
  'tree-04',
  'tree-05',
  'tree-06',
  'tree-07',
  'tree-08',
  'tree-09',
  'tree-02-red',
  'tree-06-brown',
  'tree-08-brown',
  'tree-08-red',
  'tree-09-brown',
  'tree-09-red',
}) do
  data:extend({ tree_item(name), tree_recipe(name) })
  effects[#effects + 1] = { type = 'unlock-recipe', recipe = name }
end
