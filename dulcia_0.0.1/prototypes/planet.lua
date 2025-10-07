local asteroid_util = require("__space-age__/prototypes/planet/asteroid-spawn-definitions")
local dulcia_map_gen = require("prototypes/mapgen")
local PlanetsLib = _G.PlanetsLib
if not PlanetsLib then
  require("__PlanetsLib__/api")
  PlanetsLib = _G.PlanetsLib
end

-- Get map generation settings for Dulcia
local dulcia_map_settings = dulcia_map_gen.dulcia()

-- Add surface properties to map gen settings
dulcia_map_settings.property_expression_names["day-night-cycle"] = 5 * 60
dulcia_map_settings.property_expression_names["magnetic-field"] = 40
dulcia_map_settings.property_expression_names["solar-power"] = 200
dulcia_map_settings.property_expression_names.pressure = 1500
dulcia_map_settings.property_expression_names.gravity = 15

PlanetsLib:extend({
  {
    type = "planet",
    name = "dulcia",
    icon = "__space-age__/graphics/icons/gleba.png",
    icon_size = 64,
    starmap_icon = "__space-age__/graphics/icons/gleba.png",
    starmap_icon_size = 64,
    gravity_pull = 5,
    orbit = {
      parent = {
        type = "space-location",
        name = "star"
      },
      distance = 11,
      orientation = 0.35,
    },
    magnitude = 0.9,
    order = "b[dulcia]",
    subgroup = "planets",
    map_gen_settings = dulcia_map_settings,
    surface_properties = {
      ["day-night-cycle"] = 5 * 60,
      ["magnetic-field"] = 40,
      ["solar-power"] = 200,
      pressure = 1500,
      gravity = 15,
    },
    draw_orbit = true,
  }
})

data:extend({
  {
    type = "space-connection",
    name = "nauvis-dulcia",
    subgroup = "planet-connections",
    from = "nauvis",
    to = "dulcia",
    order = "b",
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  },
  {
    type = "space-connection",
    name = "vulcanus-dulcia",
    subgroup = "planet-connections",
    from = "vulcanus",
    to = "dulcia",
    order = "c",
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_vulcanus)
  },
  {
    type = "space-connection",
    name = "gleba-dulcia",
    subgroup = "planet-connections",
    from = "gleba",
    to = "dulcia",
    order = "d",
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.gleba_aquilo)
  },
  {
    type = "space-connection",
    name = "fulgora-dulcia",
    subgroup = "planet-connections",
    from = "fulgora",
    to = "dulcia",
    order = "e",
    length = 15000,
    asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.fulgora_aquilo)
  }
})
