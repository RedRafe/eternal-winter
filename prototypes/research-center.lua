local ew_util = require '__eternal-winter__.prototypes.ew-util'
local hit_effects = require '__base__.prototypes.entity.hit-effects'
local sounds = require '__base__.prototypes.entity.sounds'
local research_center_animation_speed = 0.05
-- TODO: maybe split each recipe research into its own technology and each level into ints own blocked technology

data:extend({
  -- Recipe cat.
  {
    name = 'll-research',
    type = 'recipe-category'
  },
  -- [[ Research recipes ]]
  -- Moon rock
  {
    name = 'll-moon-rock-research',
    type = 'recipe',
    icons = {
      { icon = '__LunarLandings__/graphics/icons/moon-rock.png', icon_size = 64, icon_mipmaps = 4 },
      {
        icon = '__core__/graphics/icons/search-white.png',
        icon_size = 32,
        icon_mipmaps = 1,
        scale = 0.5,
        shift = { 8, 8 },
      },
    },
    category = 'll-research',
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = { { type = 'item', name = 'll-moon-rock', amount = 10 } },
    results = {},
    icon = '__LunarLandings__/graphics/icons/moon-rock.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'll-raw-material-moon',
    order = 'a[moon-rock]-j',
    hidden = false,
    hide_from_player_crafting = true,
  },
  -- Rich moon rock
  {
    name = 'll-rich-moon-rock-research',
    type = 'recipe',
    icons = {
      { icon = '__LunarLandings__/graphics/icons/moon-rock.png', icon_size = 64, icon_mipmaps = 4 },
      {
        icon = '__core__/graphics/icons/search-white.png',
        icon_size = 32,
        icon_mipmaps = 1,
        scale = 0.5,
        shift = { 8, 8 },
      },
    },
    category = 'll-research',
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = { { type = 'item', name = 'll-rich-moon-rock', amount = 10 } },
    results = {},
    icon = '__LunarLandings__/graphics/icons/moon-rock.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'll-raw-material-moon',
    order = 'a[moon-rock]-k',
    hidden = false,
    hide_from_player_crafting = true,
  },
  -- Ice
  {
    name = 'll-ice-research',
    type = 'recipe',
    icons = {
      { icon = '__space-exploration-graphics__/graphics/icons/water-ice.png', icon_size = 64, icon_mipmaps = 4 },
      {
        icon = '__core__/graphics/icons/search-white.png',
        icon_size = 32,
        icon_mipmaps = 1,
        scale = 0.5,
        shift = { 8, 8 },
      },
    },
    category = 'll-research',
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = { { type = 'item', name = 'll-ice', amount = 2 } },
    results = {},
    icon = '__space-exploration-graphics__/graphics/icons/water-ice.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'll-raw-material-moon',
    order = 'a[moon-rock]-l',
    hidden = false,
    hide_from_player_crafting = true,
  },
  -- Astrocrystal
  {
    name = 'll-astrocrystals-research',
    type = 'recipe',
    icons = {
      { icon = '__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png', icon_size = 64, icon_mipmaps = 4 },
      {
        icon = '__core__/graphics/icons/search-white.png',
        icon_size = 32,
        icon_mipmaps = 1,
        scale = 0.5,
        shift = { 8, 8 },
      },
    },
    category = 'll-research',
    enabled = false,
    allow_decomposition = false,
    energy_required = 5,
    ingredients = { { type = 'item', name = 'll-astrocrystals', amount = 2 } },
    results = {},
    icon = '__LunarLandings__/graphics/item/raw-imersite/raw-imersite.png',
    icon_size = 64,
    icon_mipmaps = 4,
    subgroup = 'll-raw-material-moon',
    order = 'a[moon-rock]-l',
    hidden = false,
    hide_from_player_crafting = true,
  },
  -- Entity
  {
    type = 'assembling-machine',
    name = 'll-research-center',
    icon = '__space-exploration-graphics__/graphics/icons/supercomputer-4.png',
    icon_size = 64,
    flags = { 'placeable-neutral', 'placeable-player', 'player-creation' },
    minable = { hardness = 0.2, mining_time = 0.5, result = 'll-research-center' },
    max_health = 500,
    corpse = 'big-remnants',
    dying_explosion = 'medium-explosion',
    resistances = {},
    damaged_trigger_effect = hit_effects.entity(),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = { filename = '__base__/sound/car-metal-impact.ogg', volume = 0.65 },
    working_sound = {
      sound = { filename = '__base__/sound/lab.ogg', volume = 0.7 },
      audible_distance_modifier = 0.7,
      fade_in_ticks = 4,
      fade_out_ticks = 20,
    },
    collision_box = { { -2.2, -2.2 }, { 2.2, 2.2 } },
    selection_box = { { -2.5, -2.5 }, { 2.5, 2.5 } },
    drawing_box = { { -2.5, -4.0 }, { 2.5, 2.5 } },
    animation = {
      layers = {
        {
          filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/sr/supercomputer-4.png',
          priority = 'high',
          width = 320 / 2,
          height = 384 / 2,
          frame_count = 1,
          shift = util.by_pixel(-0, -16),
          animation_speed = research_center_animation_speed,
          hr_version = {
            filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/hr/supercomputer-4.png',
            priority = 'high',
            width = 320,
            height = 384,
            frame_count = 1,
            shift = util.by_pixel(-0, -16),
            animation_speed = research_center_animation_speed,
            scale = 0.5,
          },
        },
        {
          draw_as_shadow = true,
          filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/sr/supercomputer-shadow.png',
          priority = 'high',
          width = 264 / 2,
          height = 234 / 2,
          frame_count = 1,
          line_length = 1,
          shift = util.by_pixel(75, 23),
          animation_speed = research_center_animation_speed,
          hr_version = {
            draw_as_shadow = true,
            filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/hr/supercomputer-shadow.png',
            priority = 'high',
            width = 264,
            height = 234,
            frame_count = 1,
            line_length = 1,
            shift = util.by_pixel(75, 23),
            animation_speed = research_center_animation_speed,
            scale = 0.5,
          },
        },
      },
    },
    working_visualisations = {
      {
        effect = 'uranium-glow', -- changes alpha based on energy source light intensity
        light = { intensity = 0.8, size = 16, shift = { 0.0, 0.0 }, color = { r = 0.3, g = 0.1, b = 1 } },
      },
      {
        animation = {
          filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/sr/supercomputer-4-working.png',
          priority = 'high',
          width = 504 / 4 / 2,
          height = 1064 / 4 / 2,
          line_length = 4,
          frame_count = 16,
          shift = util.by_pixel(-0, -22),
          animation_speed = research_center_animation_speed,
          blend_mode = 'additive',
          draw_as_glow = true,
          max_advance = 1,
          hr_version = {
            filename = '__space-exploration-graphics-5__/graphics/entity/supercomputer/hr/supercomputer-4-working.png',
            priority = 'high',
            width = 504 / 4,
            height = 1064 / 4,
            line_length = 4,
            frame_count = 16,
            shift = util.by_pixel(-0, -22),
            animation_speed = research_center_animation_speed,
            blend_mode = 'additive',
            draw_as_glow = true,
            max_advance = 1,
            scale = 0.5,
          },
        },
      },
    },
    crafting_categories = { 'll-research' },
    source_inventory_size = 1,
    result_inventory_size = 0,
    crafting_speed = 1,
    energy_source = { type = 'electric', usage_priority = 'secondary-input', emissions_per_minute = 0 },
    energy_usage = '16000kW',
    module_specification = { module_slots = 3 },
    allowed_effects = { 'consumption', 'speed', 'pollution' },
    created_effect = {
      type = 'direct',
      action_delivery = {
        type = 'instant',
        source_effects = { { type = 'script', effect_id = 'll-research-center-created' } },
      },
    },
    surface_conditions = { nauvis = false, luna = { plain = true, lowland = false, mountain = true, foundation = true } },
  },
  -- Item
  {
    name = 'll-research-center',
    type = 'item',
    icon = '__space-exploration-graphics__/graphics/icons/supercomputer-4.png',
    icon_size = 64,
    subgroup = 'production-machine',
    order = 'g[lab]-2',
    place_result = 'll-research-center',
    stack_size = 10,
  },
  -- Recipe
  {
    type = 'recipe',
    name = 'll-research-center',
    enabled = false,
    energy_required = 15,
    ingredients = {
      { 'advanced-circuit', 200 },
      { 'steel-plate', 40 },
      { 'copper-cable', 10 },
      { 'll-silicon', 20 }
    },
    result = 'll-research-center',
  },
  -- Technology
  {
    name = 'll-research-center',
    type = 'technology',
    effects = {
      { type = 'unlock-recipe', recipe = 'll-research-center' },
      { type = 'unlock-recipe', recipe = 'll-moon-rock-research' },
      { type = 'unlock-recipe', recipe = 'll-rich-moon-rock-research' },
      { type = 'unlock-recipe', recipe = 'll-ice-research' },
      { type = 'unlock-recipe', recipe = 'll-astrocrystals-research' },
    },
    icon = '__space-exploration-graphics__/graphics/technology/supercomputer-4.png',
    icon_size = 128,
    order = 'e-g',
    prerequisites = { 'll-space-science-pack' },
    unit = {
      count = 350,
      ingredients = {
        { 'automation-science-pack', 1 },
        { 'logistic-science-pack', 1 },
        { 'chemical-science-pack', 1 },
        { 'production-science-pack', 1 },
        { 'utility-science-pack', 1 },
        { 'll-space-science-pack', 1 },
      },
      time = 60,
    },
  },
})

for i = 1, 5 do
  local recipe = table.deepcopy(data.raw.recipe['ll-moon-rock-processing-with-oxygen'])
  recipe.name = recipe.name .. '-' .. tostring(i)
  recipe.localised_name = {'recipe-name.ll-moon-rock-processing-with-oxygen-tiered', i}
  recipe.order = recipe.order .. '-[' .. tostring(i) .. ']'
  recipe.results = {
    { type = 'item', name = 'll-silica', amount = 5 },
    { type = 'item', name = 'stone', amount = 5 },
    { type = 'fluid', name = 'll-oxygen', amount = 100 + (i * 40), fluidbox_index = 1 },
  }
  data:extend({ recipe })
  ew_util.allow_productivity(recipe.name)
end
