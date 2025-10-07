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

table.insert(water_tile_type_names, "dulcia-water")
table.insert(water_tile_type_names, "dulcia-deepwater")
table.insert(water_tile_type_names, "dulcia-water-shallow")

local base_deepwater = data.raw.tile["deepwater"]
local base_water = data.raw.tile["water"]
local base_shallow = data.raw.tile["water-shallow"] or data.raw.tile["water"]

data:extend({
  {
    type = "tile",
    name = "dulcia-deepwater",
    order = "a[water]-b[dulcia-deepwater]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.water(),
    fluid = "water",
    autoplace = { probability_expression = "dulcia_deepwater_probability" },
    effect = "water",
    effect_color = chocolate_brown,
    effect_color_secondary = {80, 53, 26},
    layer_group = "water",
    layer = dulcia_tile_offset + 1,
    variants = util.table.deepcopy(base_deepwater.variants),
    transitions = base_deepwater.transitions and util.table.deepcopy(base_deepwater.transitions),
    transitions_between_transitions = base_deepwater.transitions_between_transitions and util.table.deepcopy(base_deepwater.transitions_between_transitions),
    allowed_neighbors = { "dulcia-water" },
    map_color = chocolate_brown,
    absorptions_per_second = util.table.deepcopy(tile_pollution.water),
    trigger_effect = base_deepwater.trigger_effect,
    walking_speed_modifier = base_deepwater.walking_speed_modifier,
    vehicle_friction_modifier = base_deepwater.vehicle_friction_modifier,
    default_cover_tile = base_deepwater.default_cover_tile,
    ambient_sounds = base_deepwater.ambient_sounds
  },
  {
    type = "tile",
    name = "dulcia-water",
    order = "a[water]-a[dulcia-water]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.water(),
    fluid = "water",
    autoplace = { probability_expression = "dulcia_water_probability" },
    effect = "water",
    effect_color = chocolate_light,
    effect_color_secondary = chocolate_brown,
    layer_group = "water",
    layer = dulcia_tile_offset + 2,
    variants = util.table.deepcopy(base_water.variants),
    transitions = base_water.transitions and util.table.deepcopy(base_water.transitions),
    transitions_between_transitions = base_water.transitions_between_transitions and util.table.deepcopy(base_water.transitions_between_transitions),
    allowed_neighbors = { "dulcia-deepwater", "dulcia-water-shallow" },
    map_color = chocolate_light,
    absorptions_per_second = util.table.deepcopy(tile_pollution.water),
    trigger_effect = base_water.trigger_effect,
    walking_speed_modifier = base_water.walking_speed_modifier,
    vehicle_friction_modifier = base_water.vehicle_friction_modifier,
    default_cover_tile = base_water.default_cover_tile,
    ambient_sounds = base_water.ambient_sounds
  },
  {
    type = "tile",
    name = "dulcia-water-shallow",
    order = "a[water]-c[dulcia-water-shallow]",
    subgroup = "dulcia-tiles",
    collision_mask = tile_collision_masks.shallow_water(),
    fluid = "water",
    autoplace = { probability_expression = "dulcia_water_shallow_probability" },
    effect = "water",
    effect_color = {160, 107, 53},
    effect_color_secondary = chocolate_light,
    layer_group = "water",
    layer = dulcia_tile_offset + 3,
    variants = util.table.deepcopy(base_shallow.variants),
    transitions = base_shallow.transitions and util.table.deepcopy(base_shallow.transitions),
    transitions_between_transitions = base_shallow.transitions_between_transitions and util.table.deepcopy(base_shallow.transitions_between_transitions),
    allowed_neighbors = { "dulcia-water", "dulcia-candy-light", "dulcia-candy-medium", "dulcia-candy-dark" },
    map_color = {160, 107, 53},
    absorptions_per_second = util.table.deepcopy(tile_pollution.water),
    trigger_effect = base_shallow.trigger_effect,
    walking_speed_modifier = base_shallow.walking_speed_modifier,
    vehicle_friction_modifier = base_shallow.vehicle_friction_modifier,
    default_cover_tile = base_shallow.default_cover_tile,
    ambient_sounds = base_shallow.ambient_sounds
  },
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
