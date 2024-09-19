local hit_effects = require '__base__.prototypes.entity.hit-effects'
local sounds = require '__base__.prototypes.entity.sounds'

data:extend({
  -- Tips & Tricks
  {
    type = 'tips-and-tricks-item',
    name = 'll-shielding-wall',
    tag = '[entity=ll-shielding-wall]',
    category = 'lunar-landings',
    indent = 1,
    order = 'f',
    --trigger = {type = 'build-entity', entity = 'spidertron', match_type_only = true},
  },
  -- Wall
  {
    type = 'wall',
    name = 'll-shielding-wall',
    icon = '__space-exploration-graphics__/graphics/icons/spaceship-wall.png',
    icon_size = 64,
    icon_mipmaps = 1,
    flags = {'placeable-neutral', 'player-creation'},
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.wall(),
    minable = {mining_time = 0.2, result = 'stone-wall'},
    placeable_by = {item = 'stone-wall', count = 1},
    fast_replaceable_group = 'll-wall',
    max_health = 350,
    repair_speed_modifier = 2,
    corpse = 'wall-remnants',
    dying_explosion = 'wall-explosion',
    repair_sound = sounds.manual_repair,
    mined_sound = sounds.deconstruct_bricks(0.8),
    open_sound = sounds.machine_open,
    close_sound = sounds.machine_close,
    vehicle_impact_sound = sounds.car_stone_impact,
    connected_gate_visualization =
    {
      filename = '__core__/graphics/arrows/underground-lines.png',
      priority = 'high',
      width = 64,
      height = 64,
      scale = 0.5
    },
    resistances =
    {
      {
        type = 'physical',
        decrease = 3,
        percent = 20
      },
      {
        type = 'impact',
        decrease = 45,
        percent = 60
      },
      {
        type = 'explosion',
        decrease = 10,
        percent = 30
      },
      {
        type = 'fire',
        percent = 100
      },
      {
        type = 'acid',
        percent = 80
      },
      {
        type = 'laser',
        percent = 70
      }
    },
    visual_merge_group = 0, -- different walls will visually connect to each other if their merge group is same (defaults to 0)
    pictures =
    {
      single =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-single.png',
            priority = 'extra-high',
            width = 32,
            height = 46,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, -6),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-single.png',
              priority = 'extra-high',
              width = 64,
              height = 86,
              variation_count = 2,
              line_length = 2,
              shift = util.by_pixel(0, -5),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-single-shadow.png',
            priority = 'extra-high',
            width = 50,
            height = 32,
            repeat_count = 2,
            shift = util.by_pixel(10, 16),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-single-shadow.png',
              priority = 'extra-high',
              width = 98,
              height = 60,
              repeat_count = 2,
              shift = util.by_pixel(10, 17),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      straight_vertical =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-vertical.png',
            priority = 'extra-high',
            width = 32,
            height = 68,
            variation_count = 5,
            line_length = 5,
            shift = util.by_pixel(0, 8),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-vertical.png',
              priority = 'extra-high',
              width = 64,
              height = 134,
              variation_count = 5,
              line_length = 5,
              shift = util.by_pixel(0, 8),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-vertical-shadow.png',
            priority = 'extra-high',
            width = 50,
            height = 58,
            repeat_count = 5,
            shift = util.by_pixel(10, 28),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-vertical-shadow.png',
              priority = 'extra-high',
              width = 98,
              height = 110,
              repeat_count = 5,
              shift = util.by_pixel(10, 29),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      straight_horizontal =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-horizontal.png',
            priority = 'extra-high',
            width = 32,
            height = 50,
            variation_count = 6,
            line_length = 6,
            shift = util.by_pixel(0, -4),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-horizontal.png',
              priority = 'extra-high',
              width = 64,
              height = 92,
              variation_count = 6,
              line_length = 6,
              shift = util.by_pixel(0, -2),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-horizontal-shadow.png',
            priority = 'extra-high',
            width = 62,
            height = 36,
            repeat_count = 6,
            shift = util.by_pixel(14, 14),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-horizontal-shadow.png',
              priority = 'extra-high',
              width = 124,
              height = 68,
              repeat_count = 6,
              shift = util.by_pixel(14, 15),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      corner_right_down =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-corner-right.png',
            priority = 'extra-high',
            width = 32,
            height = 64,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, 6),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-corner-right.png',
              priority = 'extra-high',
              width = 64,
              height = 128,
              variation_count = 2,
              line_length = 2,
              shift = util.by_pixel(0, 7),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-corner-right-shadow.png',
            priority = 'extra-high',
            width = 62,
            height = 60,
            repeat_count = 2,
            shift = util.by_pixel(14, 28),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-corner-right-shadow.png',
              priority = 'extra-high',
              width = 124,
              height = 120,
              repeat_count = 2,
              shift = util.by_pixel(17, 28),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      corner_left_down =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-corner-left.png',
            priority = 'extra-high',
            width = 32,
            height = 68,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, 6),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-corner-left.png',
              priority = 'extra-high',
              width = 64,
              height = 134,
              variation_count = 2,
              line_length = 2,
              shift = util.by_pixel(0, 7),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-corner-left-shadow.png',
            priority = 'extra-high',
            width = 54,
            height = 60,
            repeat_count = 2,
            shift = util.by_pixel(8, 28),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-corner-left-shadow.png',
              priority = 'extra-high',
              width = 102,
              height = 120,
              repeat_count = 2,
              shift = util.by_pixel(9, 28),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      t_up =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-t.png',
            priority = 'extra-high',
            width = 32,
            height = 68,
            variation_count = 4,
            line_length = 4,
            shift = util.by_pixel(0, 6),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-t.png',
              priority = 'extra-high',
              width = 64,
              height = 134,
              variation_count = 4,
              line_length = 4,
              shift = util.by_pixel(0, 7),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-t-shadow.png',
            priority = 'extra-high',
            width = 62,
            height = 60,
            repeat_count = 4,
            shift = util.by_pixel(14, 28),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-t-shadow.png',
              priority = 'extra-high',
              width = 124,
              height = 120,
              repeat_count = 4,
              shift = util.by_pixel(14, 28),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      ending_right =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-ending-right.png',
            priority = 'extra-high',
            width = 32,
            height = 48,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, -4),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-ending-right.png',
              priority = 'extra-high',
              width = 64,
              height = 92,
              variation_count = 2,
              line_length = 2,
              shift = util.by_pixel(0, -3),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-ending-right-shadow.png',
            priority = 'extra-high',
            width = 62,
            height = 36,
            repeat_count = 2,
            shift = util.by_pixel(14, 14),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-ending-right-shadow.png',
              priority = 'extra-high',
              width = 124,
              height = 68,
              repeat_count = 2,
              shift = util.by_pixel(17, 15),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      ending_left =
      {
        layers =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-ending-left.png',
            priority = 'extra-high',
            width = 32,
            height = 48,
            variation_count = 2,
            line_length = 2,
            shift = util.by_pixel(0, -4),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-ending-left.png',
              priority = 'extra-high',
              width = 64,
              height = 92,
              variation_count = 2,
              line_length = 2,
              shift = util.by_pixel(0, -3),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-ending-left-shadow.png',
            priority = 'extra-high',
            width = 54,
            height = 36,
            repeat_count = 2,
            shift = util.by_pixel(8, 14),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-ending-left-shadow.png',
              priority = 'extra-high',
              width = 102,
              height = 68,
              repeat_count = 2,
              shift = util.by_pixel(9, 15),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      },
      filling =
      {
        filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-filling.png',
        priority = 'extra-high',
        width = 24,
        height = 30,
        variation_count = 8,
        line_length = 8,
        shift = util.by_pixel(0, -2),
        hr_version =
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-filling.png',
          priority = 'extra-high',
          width = 48,
          height = 56,
          variation_count = 8,
          line_length = 8,
          shift = util.by_pixel(0, -1),
          scale = 0.5
        }
      },
      gate_connection_patch =
      {
        sheets =
        {
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-gate.png',
            priority = 'extra-high',
            width = 42,
            height = 56,
            shift = util.by_pixel(0, -8),
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-gate.png',
              priority = 'extra-high',
              width = 82,
              height = 108,
              shift = util.by_pixel(0, -7),
              scale = 0.5
            }
          },
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-gate-shadow.png',
            priority = 'extra-high',
            width = 66,
            height = 40,
            shift = util.by_pixel(14, 18),
            draw_as_shadow = true,
            hr_version =
            {
              filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-gate-shadow.png',
              priority = 'extra-high',
              width = 130,
              height = 78,
              shift = util.by_pixel(14, 18),
              draw_as_shadow = true,
              scale = 0.5
            }
          }
        }
      }
    },
    wall_diode_green =
    {
      sheet =
      {
        filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-diode-green.png',
        priority = 'extra-high',
        width = 38,
        height = 24,
        draw_as_glow = true,
        --frames = 4, -- this is optional, it will default to 4 for Sprite4Way
        shift = util.by_pixel(-2, -24),
        hr_version =
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-diode-green.png',
          priority = 'extra-high',
          width = 72,
          height = 44,
          draw_as_glow = true,
          --frames = 4,
          shift = util.by_pixel(-1, -23),
          scale = 0.5
        }
      }
    },
    wall_diode_green_light_top =
    {
      minimum_darkness = 0.3,
      color = {g=1},
      shift = util.by_pixel(0, -30),
      size = 1,
      intensity = 0.2
    },
    wall_diode_green_light_right =
    {
      minimum_darkness = 0.3,
      color = {g=1},
      shift = util.by_pixel(12, -23),
      size = 1,
      intensity = 0.2
    },
    wall_diode_green_light_bottom =
    {
      minimum_darkness = 0.3,
      color = {g=1},
      shift = util.by_pixel(0, -17),
      size = 1,
      intensity = 0.2
    },
    wall_diode_green_light_left =
    {
      minimum_darkness = 0.3,
      color = {g=1},
      shift = util.by_pixel(-12, -23),
      size = 1,
      intensity = 0.2
    },
    wall_diode_red =
    {
      sheet =
      {
        filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/wall-diode-red.png',
        priority = 'extra-high',
        width = 38,
        height = 24,
        draw_as_glow = true,
        --frames = 4, -- this is optional, it will default to 4 for Sprite4Way
        shift = util.by_pixel(-2, -24),
        hr_version =
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-wall/hr-wall-diode-red.png',
          priority = 'extra-high',
          width = 72,
          height = 44,
          draw_as_glow = true,
          --frames = 4,
          shift = util.by_pixel(-1, -23),
          scale = 0.5
        }
      }
    },
    wall_diode_red_light_top =
    {
      minimum_darkness = 0.3,
      color = {r=1},
      shift = util.by_pixel(0, -30),
      size = 1,
      intensity = 0.2
    },
    wall_diode_red_light_right =
    {
      minimum_darkness = 0.3,
      color = {r=1},
      shift = util.by_pixel(12, -23),
      size = 1,
      intensity = 0.2
    },
    wall_diode_red_light_bottom =
    {
      minimum_darkness = 0.3,
      color = {r=1},
      shift = util.by_pixel(0, -17),
      size = 1,
      intensity = 0.2
    },
    wall_diode_red_light_left =
    {
      minimum_darkness = 0.3,
      color = {r=1},
      shift = util.by_pixel(-12, -23),
      size = 1,
      intensity = 0.2
    },
    circuit_wire_connection_point = circuit_connector_definitions['gate'].points,
    circuit_connector_sprites = circuit_connector_definitions['gate'].sprites,
    circuit_wire_max_distance = default_circuit_wire_max_distance,
    default_output_signal = {type = 'virtual', name = 'signal-G'},
    surface_conditions = { nauvis = false, luna = true },
  },
  -- Gate
  {
    type = 'gate',
    name = 'll-shielding-gate',
    icon = '__space-exploration-graphics__/graphics/icons/spaceship-gate.png',
    icon_size = 64,
    icon_mipmaps = 1,
    flags = {'placeable-neutral','placeable-player', 'player-creation'},
    fast_replaceable_group = 'll-wall',
    minable = {mining_time = 0.1, result = 'gate'},
    placeable_by = {item = 'gate', count = 1},
    max_health = 350,
    corpse = 'gate-remnants',
    dying_explosion = 'gate-explosion',
    collision_box = {{-0.29, -0.29}, {0.29, 0.29}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    damaged_trigger_effect = hit_effects.entity(),
    opening_speed = 0.0666666,
    activation_distance = 3,
    timeout_to_close = 5,
    fadeout_interval = 15,
    resistances =
    {
      {
        type = 'physical',
        decrease = 3,
        percent = 20
      },
      {
        type = 'impact',
        decrease = 45,
        percent = 60
      },
      {
        type = 'explosion',
        decrease = 10,
        percent = 30
      },
      {
        type = 'fire',
        percent = 100
      },
      {
        type = 'acid',
        percent = 80
      },
      {
        type = 'laser',
        percent = 70
      }
    },
    vertical_animation =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-vertical.png',
          line_length = 8,
          width = 38,
          height = 62,
          frame_count = 16,
          shift = util.by_pixel(0, -14),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-vertical.png',
            line_length = 8,
            width = 78,
            height = 120,
            frame_count = 16,
            shift = util.by_pixel(-1, -13),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-vertical-shadow.png',
          line_length = 8,
          width = 40,
          height = 54,
          frame_count = 16,
          shift = util.by_pixel(10, 8),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-vertical-shadow.png',
            line_length = 8,
            width = 82,
            height = 104,
            frame_count = 16,
            shift = util.by_pixel(9, 9),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    horizontal_animation =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-horizontal.png',
          line_length = 8,
          width = 34,
          height = 48,
          frame_count = 16,
          shift = util.by_pixel(0, -4),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-horizontal.png',
            line_length = 8,
            width = 66,
            height = 90,
            frame_count = 16,
            shift = util.by_pixel(0, -3),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-horizontal-shadow.png',
          line_length = 8,
          width = 62,
          height = 30,
          frame_count = 16,
          shift = util.by_pixel(12, 10),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-horizontal-shadow.png',
            line_length = 8,
            width = 122,
            height = 60,
            frame_count = 16,
            shift = util.by_pixel(12, 10),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    horizontal_rail_animation_left =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-horizontal-left.png',
          line_length = 8,
          width = 34,
          height = 40,
          frame_count = 16,
          shift = util.by_pixel(0, -8),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-horizontal-left.png',
            line_length = 8,
            width = 66,
            height = 74,
            frame_count = 16,
            shift = util.by_pixel(0, -7),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-horizontal-shadow-left.png',
          line_length = 8,
          width = 62,
          height = 30,
          frame_count = 16,
          shift = util.by_pixel(12, 10),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-horizontal-shadow-left.png',
            line_length = 8,
            width = 122,
            height = 60,
            frame_count = 16,
            shift = util.by_pixel(12, 10),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    horizontal_rail_animation_right =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-horizontal-right.png',
          line_length = 8,
          width = 34,
          height = 40,
          frame_count = 16,
          shift = util.by_pixel(0, -8),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-horizontal-right.png',
            line_length = 8,
            width = 66,
            height = 74,
            frame_count = 16,
            shift = util.by_pixel(0, -7),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-horizontal-shadow-right.png',
          line_length = 8,
          width = 62,
          height = 30,
          frame_count = 16,
          shift = util.by_pixel(12, 10),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-horizontal-shadow-right.png',
            line_length = 8,
            width = 122,
            height = 58,
            frame_count = 16,
            shift = util.by_pixel(12, 11),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    vertical_rail_animation_left =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-vertical-left.png',
          line_length = 8,
          width = 22,
          height = 62,
          frame_count = 16,
          shift = util.by_pixel(0, -14),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-vertical-left.png',
            line_length = 8,
            width = 42,
            height = 118,
            frame_count = 16,
            shift = util.by_pixel(0, -13),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-vertical-shadow-left.png',
          line_length = 8,
          width = 44,
          height = 54,
          frame_count = 16,
          shift = util.by_pixel(8, 8),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-vertical-shadow-left.png',
            line_length = 8,
            width = 82,
            height = 104,
            frame_count = 16,
            shift = util.by_pixel(9, 9),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    vertical_rail_animation_right =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-vertical-right.png',
          line_length = 8,
          width = 22,
          height = 62,
          frame_count = 16,
          shift = util.by_pixel(0, -14),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-vertical-right.png',
            line_length = 8,
            width = 42,
            height = 118,
            frame_count = 16,
            shift = util.by_pixel(0, -13),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-vertical-shadow-right.png',
          line_length = 8,
          width = 44,
          height = 54,
          frame_count = 16,
          shift = util.by_pixel(8, 8),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-vertical-shadow-right.png',
            line_length = 8,
            width = 82,
            height = 104,
            frame_count = 16,
            shift = util.by_pixel(9, 9),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    vertical_rail_base =
    {
      filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-base-vertical.png',
      line_length = 8,
      width = 68,
      height = 66,
      frame_count = 16,
      shift = util.by_pixel(0, 0),
      hr_version =
      {
        filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-base-vertical.png',
        line_length = 8,
        width = 138,
        height = 130,
        frame_count = 16,
        shift = util.by_pixel(-1, 0),
        scale = 0.5
      }
    },
    horizontal_rail_base =
    {
      filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-rail-base-horizontal.png',
      line_length = 8,
      width = 66,
      height = 54,
      frame_count = 16,
      shift = util.by_pixel(0, 2),
      hr_version =
      {
        filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-rail-base-horizontal.png',
        line_length = 8,
        width = 130,
        height = 104,
        frame_count = 16,
        shift = util.by_pixel(0, 3),
        scale = 0.5
      }
    },
    wall_patch =
    {
      layers =
      {
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-wall-patch.png',
          line_length = 8,
          width = 34,
          height = 48,
          frame_count = 16,
          shift = util.by_pixel(0, 12),
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-wall-patch.png',
            line_length = 8,
            width = 70,
            height = 94,
            frame_count = 16,
            shift = util.by_pixel(-1, 13),
            scale = 0.5
          }
        },
        {
          filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//gate-wall-patch-shadow.png',
          line_length = 8,
          width = 44,
          height = 38,
          frame_count = 16,
          shift = util.by_pixel(8, 32),
          draw_as_shadow = true,
          hr_version =
          {
            filename = '__space-exploration-graphics__/graphics/entity/spaceship-gate//hr-gate-wall-patch-shadow.png',
            line_length = 8,
            width = 82,
            height = 72,
            frame_count = 16,
            shift = util.by_pixel(9, 33),
            draw_as_shadow = true,
            scale = 0.5
          }
        }
      }
    },
    vehicle_impact_sound = sounds.generic_impact,
    open_sound = sounds.gate_open,
    close_sound = sounds.gate_close,
    surface_conditions = { nauvis = false, luna = true },
  },
})
