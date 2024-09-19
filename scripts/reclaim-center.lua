local max_return = 80
local bonus_per_level = 0.5 --0.5%
local recycle = 'll-barrel-recycling-'

---@type ScriptLib
local ReclaimCenter = {}

local function update_furnaces_recipes(furnaces, lvl)
	for _, entity in ipairs(furnaces) do
		if entity.get_recipe() ~= nil then
			if string.find(entity.get_recipe().name, '^ll%-barrel%-recycling') then
				local bonus_progress = entity.bonus_progress
				local crafting_progress = entity.crafting_progress
				local plates_to_refund = entity.get_output_inventory().get_item_count('steel-plate')

				entity.set_recipe(recycle .. lvl)

				if plates_to_refund > 0 then
					entity.get_output_inventory().insert { name = 'steel-plate', count = plates_to_refund }
				end

				entity.bonus_progress = bonus_progress
				entity.crafting_progress = crafting_progress
			end
		end
	end
end

local function on_research_finished(event)
  if not string.find(event.research.name, '^ll%-barrel%-recycling') then
    return
  end

  local force = event.research.force
  local lvl = event.research.level

  -- update force recipes
  for i = 0, max_return / bonus_per_level do
    if force.recipes[recycle .. i] then
      force.recipes[recycle .. i].enabled = (i == lvl)
    end
  end

  -- update entities recipe
  for _, surface in pairs(game.surfaces) do
    local furnaces = surface.find_entities_filtered{ force = force, name = 'll-reclaim-center' }
    update_furnaces_recipes(furnaces, force)
  end
end

ReclaimCenter.events = {
  [defines.events.on_research_finished] = on_research_finished,
}

return ReclaimCenter
