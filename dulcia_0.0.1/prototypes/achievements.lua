local PlanetsLib = _G.PlanetsLib
if not PlanetsLib then
  require("__PlanetsLib__/api")
  PlanetsLib = _G.PlanetsLib
end

-- Create visit achievement for Dulcia
local dulcia_planet = data.raw.planet["dulcia"]
if dulcia_planet then
  data:extend({
    PlanetsLib.visit_planet_achievement(
      dulcia_planet,
      "__space-age__/graphics/icons/gleba.png",
      64
    )
  })
end
