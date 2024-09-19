local utils = {}

function utils.allow_productivity(recipe_name)
  for _, module in pairs(data.raw.module) do
    if module.category == 'productivity' then
      module.limitation = module.limitation or {}
      table.insert(module.limitation, recipe_name)
    end
  end
end

function utils.whitelist_recipes(module, recipes)
  LL_modules = LL_modules or {}
  LL_modules[module] = LL_modules[module] or {}
  for _, recipe in pairs(recipes) do
    LL_modules[module][recipe] = true
  end
end

return utils
