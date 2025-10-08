local util = require("util")
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_sounds = require("__base__/prototypes/tile/tile-sounds")
local tile_pollution = require("__base__/prototypes/tile/tile-pollution-values")

dulcia_tile_offset = 100

local pink_light = {255, 200, 220}
local pink_medium = {255, 160, 190}
local pink_dark = {240, 120, 160}
local chocolate_brown = {101, 67, 33}
local chocolate_light = {139, 90, 43}
local chocolate_shallow = {160, 107, 53}

local function to_tint(rgb, alpha)
  if not rgb then return nil end
  return {
    r = (rgb[1] or rgb.r or 0) / 255,
    g = (rgb[2] or rgb.g or 0) / 255,
    b = (rgb[3] or rgb.b or 0) / 255,
    a = alpha or 1
  }
end

local function tint_sprite(sprite, tint)
  if not sprite or not tint or type(sprite) ~= "table" then return end

  if sprite.filename or sprite.image or sprite.picture then
    sprite.tint = tint
  end

  if sprite.hr_version then
    tint_sprite(sprite.hr_version, tint)
  end

  if sprite.layers then
    for _, layer in pairs(sprite.layers) do
      tint_sprite(layer, tint)
    end
  end

  if sprite.sheets then
    for _, sheet in pairs(sprite.sheets) do
      tint_sprite(sheet, tint)
    end
  end

  for key, value in pairs(sprite) do
    if key ~= "hr_version" and key ~= "layers" and key ~= "sheets" and type(value) == "table" then
      tint_sprite(value, tint)
    end
  end
end

local function tint_water_tile(tile, tint)
  if not tile or not tint then return end
  tint_sprite(tile.variants, tint)

  if tile.transitions then
    for _, transition in pairs(tile.transitions) do
      tint_sprite(transition, tint)
    end
  end

  if tile.transitions_between_transitions then
    for _, transition in pairs(tile.transitions_between_transitions) do
      tint_sprite(transition, tint)
    end
  end
end

table.insert(water_tile_type_names, "dulcia-water")
table.insert(water_tile_type_names, "dulcia-deepwater")
table.insert(water_tile_type_names, "dulcia-water-shallow")

local base_deepwater = data.raw.tile["deepwater"]
local base_water = data.raw.tile["water"]
local base_shallow = data.raw.tile["water-shallow"] or data.raw.tile["water"]

local water_effect = util.table.deepcopy(data.raw["tile-effect"]["water"])
water_effect.name = "dulcia-water-effect"
water_effect.water.specular_lightness = {0.65, 0.52, 0.45}
water_effect.water.foam_color = {205, 170, 130}
water_effect.water.foam_color_multiplier = 2.15

local dulcia_deepwater = util.table.deepcopy(base_deepwater)
dulcia_deepwater.name = "dulcia-deepwater"
dulcia_deepwater.order = "a[water]-b[dulcia-deepwater]"
dulcia_deepwater.subgroup = "dulcia-tiles"
dulcia_deepwater.autoplace = { probability_expression = "dulcia_deepwater_probability" }
dulcia_deepwater.effect = "dulcia-water-effect"
dulcia_deepwater.effect_color = chocolate_brown
dulcia_deepwater.effect_color_secondary = {80, 53, 26}
dulcia_deepwater.layer = dulcia_tile_offset + 1
dulcia_deepwater.map_color = chocolate_brown
dulcia_deepwater.allowed_neighbors = { "dulcia-water" }

local dulcia_water = util.table.deepcopy(base_water)
dulcia_water.name = "dulcia-water"
dulcia_water.order = "a[water]-a[dulcia-water]"
dulcia_water.subgroup = "dulcia-tiles"
dulcia_water.autoplace = { probability_expression = "dulcia_water_probability" }
dulcia_water.effect = "dulcia-water-effect"
dulcia_water.effect_color = chocolate_light
dulcia_water.effect_color_secondary = chocolate_brown
dulcia_water.layer = dulcia_tile_offset + 2
dulcia_water.map_color = chocolate_light
dulcia_water.allowed_neighbors = { "dulcia-deepwater", "dulcia-water-shallow" }

local dulcia_shallow = util.table.deepcopy(base_shallow)
dulcia_shallow.name = "dulcia-water-shallow"
dulcia_shallow.order = "a[water]-c[dulcia-water-shallow]"
dulcia_shallow.subgroup = "dulcia-tiles"
dulcia_shallow.autoplace = { probability_expression = "dulcia_water_shallow_probability" }
dulcia_shallow.effect = "dulcia-water-effect"
dulcia_shallow.effect_color = chocolate_shallow
dulcia_shallow.effect_color_secondary = chocolate_light
dulcia_shallow.layer = dulcia_tile_offset + 3
dulcia_shallow.map_color = chocolate_shallow
dulcia_shallow.allowed_neighbors = { "dulcia-water", "dulcia-candy-light", "dulcia-candy-medium", "dulcia-candy-dark" }

tint_water_tile(dulcia_deepwater, to_tint(chocolate_brown))
tint_water_tile(dulcia_water, to_tint(chocolate_light))
tint_water_tile(dulcia_shallow, to_tint(chocolate_shallow))

data:extend({
  water_effect,
  dulcia_deepwater,
  dulcia_water,
  dulcia_shallow,
  {
    type = "tile",
    name = "dulcia-candy-light",
    order = "b[dulcia]-a[candy-light]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "dulcia_candy_light_probability" },
    layer = dulcia_tile_offset + 10,
    variants = tile_variations_template_with_transitions(
      "__base__/graphics/terrain/grass-1.png",
      {
        max_size = 4,
        [1] = {weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045}},
        [2] = {probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}},
        [4] = {probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}}
      }
    ),
    walking_sound = tile_sounds.grass,
    map_color = pink_light,
    absorptions_per_second = {pollution = 0.00005},
    vehicle_friction_modifier = 1.6
  },
  {
    type = "tile",
    name = "dulcia-candy-medium",
    order = "b[dulcia]-b[candy-medium]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "dulcia_candy_medium_probability" },
    layer = dulcia_tile_offset + 11,
    variants = tile_variations_template_with_transitions(
      "__base__/graphics/terrain/grass-2.png",
      {
        max_size = 4,
        [1] = {weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045}},
        [2] = {probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}},
        [4] = {probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}}
      }
    ),
    walking_sound = tile_sounds.grass,
    map_color = pink_medium,
    absorptions_per_second = {pollution = 0.00005},
    vehicle_friction_modifier = 1.6
  },
  {
    type = "tile",
    name = "dulcia-candy-dark",
    order = "b[dulcia]-c[candy-dark]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "dulcia_candy_dark_probability" },
    layer = dulcia_tile_offset + 12,
    variants = tile_variations_template_with_transitions(
      "__base__/graphics/terrain/grass-3.png",
      {
        max_size = 4,
        [1] = {weights = {0.085, 0.085, 0.085, 0.085, 0.087, 0.085, 0.065, 0.085, 0.045, 0.045, 0.045, 0.045, 0.005, 0.025, 0.045, 0.045}},
        [2] = {probability = 1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}},
        [4] = {probability = 0.1, weights = {0.018, 0.020, 0.015, 0.025, 0.015, 0.020, 0.025, 0.015, 0.025, 0.025, 0.010, 0.025, 0.020, 0.025, 0.025, 0.010}}
      }
    ),
    walking_sound = tile_sounds.grass,
    map_color = pink_dark,
    absorptions_per_second = {pollution = 0.00005},
    vehicle_friction_modifier = 1.6
  }
})

data:extend({
  {
    type = "item-subgroup",
    name = "dulcia-tiles",
    group = "tiles",
    order = "d[dulcia]"
  }
})
