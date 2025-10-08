local noise = require("noise")
local tne = noise.to_noise_expression

local minimal_starting_lake_elevation_expression = noise.define_noise_function(function(_, _, _, map)
  local vx = noise.var("x")
  local vy = noise.var("y")
  local starting_lake_distance = noise.distance_from(vx, vy, noise.var("starting_lake_positions"), tne(1024))
  local minimal_starting_lake_depth = tne(6)
  local lake_noise = tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments = {
      x = vx / tne(8),
      y = vy / tne(8),
      seed0 = tne(map.seed),
      seed1 = tne(733),
      input_scale = noise.fraction(1, 8),
      output_scale = tne(1.5)
    }
  }

  return starting_lake_distance / tne(4) - minimal_starting_lake_depth + lake_noise
end)

local function finish_elevation(elevation, map)
  elevation = noise.water_level_correct(elevation, map)
  elevation = elevation / noise.var("segmentation_multiplier")
  elevation = noise.min(elevation, minimal_starting_lake_elevation_expression)
  return elevation
end

local dulcia_elevation_expression = noise.define_noise_function(function(_, _, _, map)
  local vx = noise.var("x")
  local vy = noise.var("y")
  local segmentation = noise.var("segmentation_multiplier")
  local map_seed = noise.var("map_seed")

  local macro_noise = tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments = {
      x = vx,
      y = vy,
      seed0 = tne(map_seed),
      seed1 = tne(1205),
      input_scale = segmentation / tne(180),
      output_scale = tne(40)
    }
  }

  local detail_noise = tne{
    type = "function-application",
    function_name = "factorio-basis-noise",
    arguments = {
      x = vx / tne(2),
      y = vy / tne(2),
      seed0 = tne(map_seed),
      seed1 = tne(4211),
      input_scale = segmentation / tne(80),
      output_scale = tne(10)
    }
  }

  local edge_falloff = (noise.abs(vx) + noise.abs(vy)) * noise.fraction(1, 4096) * tne(35)

  local elevated = macro_noise + detail_noise + tne(38) - edge_falloff
  return finish_elevation(elevated, map)
end)

local planet_map_gen = {}

data:extend({
  {
    type = "noise-expression",
    name = "dulcia_elevation",
    intended_property = "elevation",
    expression = dulcia_elevation_expression
  },
  {
    type = "noise-expression",
    name = "dulcia_chocolate_water",
    expression = [[
      clamp((6 - dulcia_elevation) / 28, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_probability",
    expression = [[
      dulcia_chocolate_water
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_medium_probability",
    expression = [[
      clamp(1 - dulcia_chocolate_water + 0.2, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_moisture",
    expression = [[
      clamp(0.5 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 2000,
        octaves = 4,
        persistence = 0.7,
        input_scale = 1/200
      }, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_aux",
    expression = [[
      clamp(0.5 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 3000,
        octaves = 4,
        persistence = 0.6,
        input_scale = 1/180
      }, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_temperature",
    expression = [[
      clamp(40 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 4000,
        octaves = 3,
        persistence = 0.8,
        input_scale = 1/450
      } * 25, 0, 100)
    ]]
  }
})

planet_map_gen.dulcia = function()
  return {
    aux_climate_control = true,
    moisture_climate_control = true,
    property_expression_names = {
      elevation = "dulcia_elevation",
      temperature = "dulcia_temperature",
      moisture = "dulcia_moisture",
      aux = "dulcia_aux",
      cliffiness = "cliffiness_basic",
      cliff_elevation = "cliff_elevation_from_elevation",
      ["tile:dulcia-water:probability"] = "dulcia_water_probability",
      ["tile:dulcia-candy-medium:probability"] = "dulcia_candy_medium_probability"
    },
    cliff_settings = {
      name = "cliff",
      cliff_elevation_interval = 40,
      cliff_elevation_0 = 10
    },
    autoplace_controls = {
      ["iron-ore"] = {},
      ["copper-ore"] = {},
      ["coal"] = {},
      ["stone"] = {},
      ["uranium-ore"] = {},
      ["crude-oil"] = {},
      ["trees"] = {},
      ["enemy-base"] = {frequency = "none", size = "none"},
      ["water"] = {},
      ["dulcium-ore"] = {},
      ["saccharite-ore"] = {},
      ["mint-oil"] = {}
    },
    autoplace_settings = {
      ["tile"] = {
        settings = {
          ["dulcia-candy-medium"] = {},
          ["dulcia-water"] = {}
        }
      },
      ["decorative"] = {
        settings = {}
      },
      ["entity"] = {
        settings = {
          ["dulcium-ore"] = {},
          ["saccharite-ore"] = {},
          ["mint-oil"] = {}
        }
      }
    }
  }
end

return planet_map_gen
