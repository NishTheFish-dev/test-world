local planet_map_gen = {}

data:extend({
  {
    type = "noise-expression",
    name = "dulcia_elevation",
    expression = [[
      12 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 1200,
        octaves = 3,
        persistence = 0.4,
        input_scale = 1/1500,
        output_scale = 10
      }
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_detail",
    expression = [[
      multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 5100,
        octaves = 2,
        persistence = 0.55,
        input_scale = 1/480,
        output_scale = 2
      }
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_macro",
    expression = [[
      multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 5200,
        octaves = 3,
        persistence = 0.58,
        input_scale = 1/1600,
        output_scale = 9
      }
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_bridge_billows",
    expression = [[
      clamp(0.45 + 0.35 * multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 5300,
        octaves = 3,
        persistence = 0.42,
        input_scale = 1/260,
        output_scale = 1.2
      }, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_plates",
    expression = [[
      clamp(0.35 + 0.25 * dulcia_bridge_billows + 0.15 * dulcia_water_macro, 0.28, 0.78)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_elevation",
    expression = [[
      dulcia_elevation - (3 + 0.8 * dulcia_water_macro - 2.6 * dulcia_water_plates)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_raw",
    expression = [[
      clamp((-6 - dulcia_water_elevation) / 7 + 0.12 * dulcia_water_detail, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_total_bias",
    expression = [[
      0.5
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_probability",
    expression = [[
      max(0,
        dulcia_water_total_bias * dulcia_water_raw
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_medium_probability",
    expression = "1"
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
