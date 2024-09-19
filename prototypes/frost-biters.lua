if not mods['Cold_biters'] then return end

local decals = function() return {
  { decorative = 'lava-decal-blue',  spawn_min = 0, spawn_max = 2, spawn_min_radius = 1, spawn_max_radius = 2 },
  { decorative = 'wetland-decal',    spawn_min = 1, spawn_max = 1, spawn_min_radius = 1, spawn_max_radius = 2 },
  { decorative = 'puddle-decal',     spawn_min = 1, spawn_max = 2, spawn_min_radius = 0, spawn_max_radius = 1 },
  { decorative = 'sand-decal-white', spawn_min = 2, spawn_max = 4, spawn_min_radius = 1, spawn_max_radius = 2 },
}	end

-- Spawners
for _, name in pairs({
  'cb-cold-spawner',
}) do
  local spawner = data.raw['unit-spawner'][name]
  spawner.autoplace.default_enabled = true
  spawner.autoplace.tile_restriction = {'ll-luna-plain'}
  spawner.spawn_decoration = decals()
end

-- Worms
for _, name in pairs({
  'small-cold-worm-turret',
  'medium-cold-worm-turret',
  'big-cold-worm-turret',
  'behemoth-cold-worm-turret',
  'leviathan-cold-worm-turret',
  'mother-cold-worm-turret',
}) do
  local worm = data.raw.turret[name]
  worm.autoplace.default_enabled = true
  worm.autoplace.tile_restriction = {'ll-luna-plain'}
  worm.spawn_decoration = decals()
end
