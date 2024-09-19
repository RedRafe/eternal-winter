local hit_effects = require '__base__.prototypes.entity.hit-effects'
local sounds = require '__base__.prototypes.entity.sounds'
local se_path = '__space-exploration-graphics__/graphics/icons/'
local rc_animation_speed = 0.25
local max_return = 80
local bonus_per_level = 0.5 --0.5%

data:extend({
  -- Recipe cat.
  {
    name = 'll-recycle',
    type = 'recipe-category'
  },
  -- Item
  {
    type = 'item',
    name = 'll-reclaim-center',
    icon = se_path .. 'mechanical-laboratory.png',
    icon_size = 64,
    order = 'g[recycle]',
    stack_size = 50,
    subgroup = 'production-machine',
    place_result = 'll-reclaim-center',
  },
  -- Recipe
  {
    type = 'recipe',
    name = 'll-reclaim-center',
    energy_required = 10,
    ingredients = {
      { 'assembling-machine-2', 1 },
      { 'effectivity-module', 4 },
    },
    results = {
      { 'll-reclaim-center', 1 }
    },
    icon = se_path .. 'mechanical-laboratory.png',
    icon_size = 64,
    enabled = false,
  },
  -- Entity
  {
    type = 'furnace',
    name = 'll-reclaim-center',
    icon = se_path .. 'mechanical-laboratory.png',
    icon_size = 64,
    flags = { 'placeable-neutral', 'placeable-player', 'player-creation' },
    minable = { mining_time = 0.2, result = 'll-reclaim-center' },
    max_health = 1200,
    corpse = 'big-remnants',
    dying_explosion = 'medium-explosion',
    alert_icon_shift = util.by_pixel(0, -12),
    collision_box = { { -3.3, -3.3 }, { 3.3, 3.3 } },
    selection_box = { { -3.5, -3.5 }, { 3.5, 3.5 } },
    drawing_box = { { -3.5, -3.9 }, { 3.5, 3.5 } },
    resistances = { { type = 'impact', percent = 10 } },
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = { filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65 },
    working_sound = {
      apparent_volume = 1.5,
      idle_sound = { filename = '__base__/sound/idle1.ogg', volume = 0.6 },
      sound = { { filename = '__base__/sound/burner-mining-drill.ogg', volume = 0.8 } },
    },
    animation = {
      layers = {
        {
          filename = '__space-exploration-graphics-5__/graphics/entity/mechanical-laboratory/sr/mechanical-laboratory.png',
          priority = 'high',
          width = 3840 / 8 / 2,
          height = 3584 / 8 / 2,
          frame_count = 64,
          line_length = 8,
          shift = util.by_pixel(-8, 0),
          animation_speed = rc_animation_speed,
          hr_version = {
            filename = '__space-exploration-graphics-5__/graphics/entity/mechanical-laboratory/hr/mechanical-laboratory.png',
            priority = 'high',
            width = 3840 / 8,
            height = 3584 / 8,
            frame_count = 64,
            line_length = 8,
            shift = util.by_pixel(-8, 0),
            animation_speed = rc_animation_speed,
            scale = 0.5,
          },
        },
        {
          draw_as_shadow = true,
          filename = '__space-exploration-graphics-5__/graphics/entity/mechanical-laboratory/sr/mechanical-laboratory-shadow.png',
          priority = 'high',
          width = 694 / 2,
          height = 400 / 2,
          frame_count = 1,
          line_length = 1,
          repeat_count = 64,
          shift = util.by_pixel(59, 17),
          animation_speed = rc_animation_speed,
          hr_version = {
            draw_as_shadow = true,
            filename = '__space-exploration-graphics-5__/graphics/entity/mechanical-laboratory/hr/mechanical-laboratory-shadow.png',
            priority = 'high',
            width = 694,
            height = 400,
            frame_count = 1,
            line_length = 1,
            repeat_count = 64,
            shift = util.by_pixel(59, 17),
            animation_speed = rc_animation_speed,
            scale = 0.5,
          },
        },
      },
    },
    crafting_categories = { 'll-recycle' },
    crafting_speed = 1,
    source_inventory_size = 1,
    result_inventory_size = 1,
    energy_source = { type = 'electric', usage_priority = 'secondary-input', emissions_per_minute = 4 },
    energy_usage = '200kW',
    module_specification = { module_slots = 2 },
    allowed_effects = { 'consumption', 'speed' },
    working_visualisations = {
      {
        effect = 'uranium-glow', -- changes alpha based on energy source light intensity
        light = { intensity = 0.8, size = 18, shift = { 0.0, 0.0 }, color = { r = 1, g = 0.8, b = 0.5 } },
      },
    },
    surface_conditions = { nauvis = true, luna = true },
  },
  -- Technology
  {
    type = 'technology',
    name = 'll-reclaim-center',
    effects = {
      { type = 'unlock-recipe', recipe = 'll-reclaim-center' },
      { type = 'unlock-recipe', recipe = 'll-barrel-recycling-0' }
    },
    icon = '__space-exploration-graphics__/graphics/technology/mechanical-laboratory.png',
    icon_size = 128,
    order = 'e-g',
    prerequisites = { 'll-luna-exploration' },
    unit = {
      count = 100,
      time = 60,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
      },
    },
  },
  {
    type = 'technology',
    name = 'll-barrel-recycling',
    icons = util.technology_icon_constant_productivity('__base__/graphics/technology/fluid-handling.png'),
    icon_mipmaps = 4,
    icon_size = 128,
    order = 'e-g',
    prerequisites = { 'll-reclaim-center' },
    max_level = max_return / bonus_per_level,
    unit = {
      count_formula = '10*(L^0.5 + 1)',
      time = 60,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
      },
    },
    effects = {
      {
        type = 'nothing',
        effect_description = {'technology-description.barrel-bonus'},
      }
    }
  },
})

for lvl = 0, max_return / bonus_per_level do
  data:extend({
    {
      type = 'recipe',
      name = 'll-barrel-recycling-'..lvl,
      localised_name = {'recipe-name.ll-barrel-recycling', bonus_per_level * lvl},
      category = 'll-recycle',
      energy_required = 1.2,
      ingredients = {
        { 'empty-barrel', 1 },
      },
      results = {
        { name = 'steel-plate', amount = 1, probability = bonus_per_level * lvl / 100 }
      },
      allow_decomposition = false,
      always_show_made_in = true,
      enabled = false,
      hidden = false,
      hide_from_player_crafting = false,
    }
  })
end
