local copy = require('util').table.deepcopy

local cold_entities = {
  'cb-cold-spawner',
  'small-cold-worm-turret',
  'medium-cold-worm-turret',
  'big-cold-worm-turret',
  'behemoth-cold-worm-turret',
  'leviathan-cold-worm-turret',
  'mother-cold-worm-turret',
}

local cold_decals = {
  'lava-decal-blue',
  'wetland-decal',
  'puddle-decal',
  'sand-decal-white',
}

return {
  on_init = function()
    if not script.active_mods['Cold_biters'] then return end

    local luna = game.get_surface('luna')
    local mgs = luna.map_gen_settings

    mgs.starting_area = 1
    mgs.peaceful_mode = false
    
    local default = { frequency = 0.2, size = 1, richness = 1 }
    local nauvis = mgs.autoplace_controls['enemy-base'] or default
    mgs.autoplace_controls['enemy-base'] = {
      frequency = math.max(nauvis.frequency, default.frequency),
      size      = math.max(nauvis.size,      default.size),
      richness  = math.max(nauvis.richness,  default.richness),
    }

    for _, name in pairs(cold_entities) do
      mgs.autoplace_settings.entity.settings[name] = { frequency = 1, size = 1, richness = 1 }
    end

    for _, name in pairs(cold_decals) do
      mgs.autoplace_settings.decorative.settings[name] = { frequency = 1, size = 1, richness = 1 }
    end

    game.surfaces.luna.map_gen_settings = copy(mgs)
    log('Luna\'s mgs updated')
  end
}
