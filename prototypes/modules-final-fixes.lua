if not LL_modules then
  return
end

function table_contains(tbl, x)
  for _, v in pairs(tbl) do
    if v == x then
      return true
    end
  end
  return false
end

local function insert_safe(tbl, elem)
  if not table_contains(tbl, elem) then
    table.insert(tbl, elem)
  end
end

for module_name, recipes in pairs(LL_modules) do
  local item = data.raw.module[module_name]
  if item and recipes then
    for recipe, _ in pairs(recipes) do
      insert_safe(item.limitation, recipe)
      for _, mod in pairs(data.raw.module) do
        if mod.name ~= module_name then
          if not mod.limitation then
            mod.limitation_blacklist = mod.limitation_blacklist or {}
            insert_safe(mod.limitation_blacklist, recipe)
          end
        end
      end
    end
  end
end

for _, b in pairs(data.raw.beacon) do
  util.remove_from_list(b.allowed_effects or {}, 'pollution')
end
