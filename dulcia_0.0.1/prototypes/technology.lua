local PlanetsLib = _G.PlanetsLib
if not PlanetsLib then
  require("__PlanetsLib__/api")
  PlanetsLib = _G.PlanetsLib
end

data:extend({
  {
    type = "technology",
    name = "dulcia-discovery",
    icons = PlanetsLib.technology_icon_planet("__space-age__/graphics/icons/gleba.png", 64),
    effects = {
      {type = "unlock-recipe", recipe = "dulcium-plate"},
      {type = "unlock-recipe", recipe = "saccharite-crystal"},
      {type = "unlock-recipe", recipe = "sugar-processor"},
      {type = "unlock-recipe", recipe = "candy-hammer"},
      {type = "unlock-recipe", recipe = "candy-dissolver"},
      {type = "unlock-recipe", recipe = "white-rock-candy"},
      {type = "unlock-recipe", recipe = "crushed-white-candy"},
      {type = "unlock-recipe", recipe = "dissolve-white-candy"},
      {type = "unlock-recipe", recipe = "candy-solvent"},
    },
    prerequisites = {"space-science-pack"},
    unit = {
      count = 500,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    },
    order = "e-a"
  },
  {
    type = "technology",
    name = "crystalline-manufacturing",
    icon = "__base__/graphics/technology/low-density-structure.png",
    icon_size = 256,
    effects = {
      {type = "unlock-recipe", recipe = "peppermint-disc"},
      {type = "unlock-recipe", recipe = "chocolate-chip"},
      {type = "unlock-recipe", recipe = "wafer-frame"},
      {type = "unlock-recipe", recipe = "sugar-glass-platform"},
      {type = "unlock-recipe", recipe = "crystalline-solar-panel"},
      {type = "unlock-recipe", recipe = "crystal-accumulator"},
      {type = "unlock-recipe", recipe = "confectionery-science-pack"},
    },
    prerequisites = {"dulcia-discovery"},
    unit = {
      count = 1000,
      ingredients = {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"space-science-pack", 1},
        {"confectionery-science-pack", 1}
      },
      time = 60
    },
    order = "e-b"
  }
  
})
