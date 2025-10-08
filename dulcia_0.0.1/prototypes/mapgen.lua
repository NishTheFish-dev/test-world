local planet_map_gen = {}

data:extend({
  {
    type = "noise-expression",
    name = "dulcia_elevation_base",
    expression = [[
      multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 1000,
        octaves = 5,
        persistence = 0.5,
        input_scale = 1/400
      }
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_elevation_bands",
    expression = [[
      12 * sin((x + y * 0.3) / 90)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_elevation",
    expression = [[
      dulcia_elevation_base * 80 + dulcia_elevation_bands
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_stripe_pattern",
    expression = [[
      clamp(0.5 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 4100,
        octaves = 4,
        persistence = 0.55,
        input_scale = 1/220,
        output_scale = 0.6
      }, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_macro",
    expression = [[
      clamp(0.5 + multioctave_noise{
        x = x,
        y = y,
        seed0 = map_seed,
        seed1 = 4200,
        octaves = 3,
        persistence = 0.45,
        input_scale = 1/520,
        output_scale = 0.55
      }, 0, 1)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_blend",
    expression = [[
      clamp(0.35 + 0.5 * dulcia_stripe_pattern + 0.4 * dulcia_candy_macro + 0.15 * (dulcia_moisture - 0.5), 0, 1)
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
    name = "dulcia_deepwater_raw",
    expression = [[
      clamp((-14 - dulcia_water_elevation) / 10 + 0.08 * dulcia_water_detail, 0, 1)
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
    name = "dulcia_shallow_raw",
    expression = [[
      clamp((2 - dulcia_water_elevation) / 10 + 0.06 * dulcia_water_detail, 0, 1)
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
    name = "dulcia_deepwater_probability",
    expression = [[
      max(0, dulcia_water_total_bias * dulcia_deepwater_raw)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_probability",
    expression = [[
      max(0,
        dulcia_water_total_bias * max(0, dulcia_water_raw - dulcia_deepwater_probability)
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_shallow_probability",
    expression = [[
      max(0,
        dulcia_water_total_bias * max(0,
          dulcia_shallow_raw - dulcia_water_probability - dulcia_deepwater_probability
        )
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_dark_probability",
    expression = [[
      max(0,
        clamp((14 - dulcia_elevation) / 18, 0, 1)
        * (0.45 + 0.55 * (1 - dulcia_candy_blend))
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_medium_probability",
    expression = [[
      max(0,
        (0.5 + 0.5 * dulcia_candy_blend)
        * clamp((dulcia_elevation - 6) / 22, 0, 1)
        * clamp((32 - dulcia_elevation) / 26, 0, 1)
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_light_probability",
    expression = [[
      max(0,
        clamp((dulcia_elevation - 26) / 20, 0, 1)
        * (0.45 + 0.55 * dulcia_candy_blend)
      )
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
      ["tile:dulcia-deepwater:probability"] = "dulcia_deepwater_probability",
      ["tile:dulcia-water:probability"] = "dulcia_water_probability",
      ["tile:dulcia-water-shallow:probability"] = "dulcia_water_shallow_probability",
      ["tile:dulcia-candy-dark:probability"] = "dulcia_candy_dark_probability",
      ["tile:dulcia-candy-medium:probability"] = "dulcia_candy_medium_probability",
      ["tile:dulcia-candy-light:probability"] = "dulcia_candy_light_probability"
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
          ["dulcia-candy-light"] = {},
          ["dulcia-candy-medium"] = {},
          ["dulcia-candy-dark"] = {},
          ["dulcia-water"] = {},
          ["dulcia-deepwater"] = {},
          ["dulcia-water-shallow"] = {}
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
