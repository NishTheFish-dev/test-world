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
      0.5 + 0.5 * sin((x * 0.4 + y * 0.25) / 70)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_deepwater_probability",
    expression = "clamp((-5 - dulcia_elevation) / 15, 0, 1)"
  },
  {
    type = "noise-expression",
    name = "dulcia_water_probability",
    expression = [[
      max(0,
        clamp((0 - dulcia_elevation) / 10, 0, 1) - dulcia_deepwater_probability
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_water_shallow_probability",
    expression = [[
      max(0,
        clamp((8 - dulcia_elevation) / 8, 0, 1) -
        dulcia_water_probability - dulcia_deepwater_probability
      )
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_dark_probability",
    expression = [[
      clamp((18 - dulcia_elevation) / 18, 0, 1) * (0.55 + 0.45 * dulcia_stripe_pattern)
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_medium_probability",
    expression = [[
      max(0,
        clamp((dulcia_elevation - 4) / 20, 0, 1) -
        clamp((dulcia_elevation - 36) / 20, 0, 1)
      ) * (0.65 + 0.35 * (1 - dulcia_stripe_pattern))
    ]]
  },
  {
    type = "noise-expression",
    name = "dulcia_candy_light_probability",
    expression = "clamp((dulcia_elevation - 32) / 18, 0, 1)"
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
      ["enemy-base"] = {},
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
