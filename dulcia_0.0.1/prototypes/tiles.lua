local util = require("util")
local tile_collision_masks = require("__base__/prototypes/tile/tile-collision-masks")
local tile_sounds = require("__base__/prototypes/tile/tile-sounds")

require("__base__/prototypes/tile/tiles")
local tiles_template = _G.tile_variations_template_with_transitions

local dulcia_tile_offset = 100

local pink_medium = {255, 160, 190}
local chocolate_brown = {101, 67, 33}
local chocolate_light = {139, 90, 43}

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

local water_tile_type_names = rawget(_G, "water_tile_type_names") or {}
_G.water_tile_type_names = water_tile_type_names

table.insert(water_tile_type_names, "dulcia-water")

local data_global = rawget(_G, "data") or error("global data table unavailable")
local data_raw = data_global.raw
local data_tiles = data_raw.tile
local base_water = data_tiles["water"]
local water_effect = util.table.deepcopy(data_raw["tile-effect"]["water"])
water_effect.name = "dulcia-water-effect"
water_effect.water.specular_lightness = {0.65, 0.52, 0.45}
water_effect.water.foam_color = {205, 170, 130}
water_effect.water.foam_color_multiplier = 2.15

local dulcia_water = util.table.deepcopy(base_water)
dulcia_water.name = "dulcia-water"
dulcia_water.order = "a[water]-a[dulcia-water]"
dulcia_water.subgroup = "dulcia-tiles"
dulcia_water.autoplace = { probability_expression = "dulcia_water_probability" }
dulcia_water.effect = "dulcia-water-effect"
dulcia_water.effect_color = chocolate_brown
dulcia_water.effect_color_secondary = chocolate_light
dulcia_water.layer = dulcia_tile_offset + 1
dulcia_water.map_color = chocolate_brown
dulcia_water.allowed_neighbors = { "dulcia-water" }

tint_water_tile(dulcia_water, to_tint(chocolate_light))

data:extend({
  water_effect,
  dulcia_water,
  {
    type = "tile",
    name = "dulcia-candy-medium",
    order = "b[dulcia]-a[candy]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.ground(),
    autoplace = { probability_expression = "dulcia_candy_medium_probability" },
    layer = dulcia_tile_offset + 10,
    variants = tiles_template(
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
