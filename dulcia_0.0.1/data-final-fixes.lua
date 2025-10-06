local PlanetsLib = _G.PlanetsLib
if not PlanetsLib then
  require("__PlanetsLib__/api")
  PlanetsLib = _G.PlanetsLib
end

-- Add confectionery science pack to labs
if data.raw["lab"]["lab"] then
  table.insert(data.raw["lab"]["lab"].inputs, "confectionery-science-pack")
  -- Sort science packs for proper display order
  data.raw["lab"]["lab"].inputs = PlanetsLib.sort_science_pack_names(data.raw["lab"]["lab"].inputs)
end

if data.raw["lab"]["biolab"] then
  table.insert(data.raw["lab"]["biolab"].inputs, "confectionery-science-pack")
  -- Sort science packs for proper display order
  data.raw["lab"]["biolab"].inputs = PlanetsLib.sort_science_pack_names(data.raw["lab"]["biolab"].inputs)
end