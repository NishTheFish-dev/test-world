local resource_autoplace = require("resource-autoplace")
local util = require("util")

local crude_oil = data.raw.resource["crude-oil"]

local mint_oil_stages = table.deepcopy(crude_oil.stages)
local mint_oil_autoplace = table.deepcopy(crude_oil.autoplace)

local mint_tint = {r = 0.4, g = 0.9, b = 0.6}

local function apply_tint(layer)
  if not layer then return end
  layer.tint = mint_tint
  if layer.hr_version then
    layer.hr_version.tint = mint_tint
  end
  if layer.layers then
    for _, sublayer in pairs(layer.layers) do
      apply_tint(sublayer)
    end
  end
end

apply_tint(mint_oil_stages.sheet)

mint_oil_autoplace.control = "mint-oil"
mint_oil_autoplace.order = "b-mint"

data:extend({
  {
    type = "resource",
    name = "dulcium-ore",
    icon = "__base__/graphics/icons/iron-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order = "a-b-dulcium",
    minable = {
      mining_time = 1,
      result = "dulcium-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "dulcium-ore",
      order = "b",
      base_density = 10,
      has_starting_area_placement = true,
      regular_rq_factor = 1.2,
      starting_rq_factor = 0.8,
      candidate_spot_count = 22
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages = {
      sheet = {
        filename = "__base__/graphics/entity/iron-ore/iron-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    map_color = {r = 0.6, g = 0.4, b = 0.2},
    mining_visualisation_tint = {r = 0.6, g = 0.4, b = 0.2},
  },
  {
    type = "resource",
    name = "saccharite-ore",
    icon = "__base__/graphics/icons/copper-ore.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    order = "a-b-saccharite",
    minable = {
      mining_time = 1,
      result = "saccharite-ore"
    },
    collision_box = {{-0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "saccharite-ore",
      order = "c",
      base_density = 8,
      has_starting_area_placement = true,
      regular_rq_factor = 1.2,
      starting_rq_factor = 0.8,
      candidate_spot_count = 22
    },
    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages = {
      sheet = {
        filename = "__base__/graphics/entity/copper-ore/copper-ore.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
    map_color = {r = 0.9, g = 0.9, b = 0.9},
    mining_visualisation_tint = {r = 0.9, g = 0.9, b = 0.9},
  },
  {
    type = "resource",
    name = "mint-oil",
    icon = "__base__/graphics/icons/crude-oil-resource.png",
    icon_size = 64,
    flags = {"placeable-neutral"},
    category = "basic-fluid",
    subgroup = "mineable-fluids",
    order = "a-b-mint",
    infinite = true,
    minimum = crude_oil.minimum,
    normal = crude_oil.normal,
    infinite_depletion_amount = crude_oil.infinite_depletion_amount,
    minable = {
      mining_time = 1,
      results = {
        {
          type = "fluid",
          name = "mint-oil",
          amount_min = 5,
          amount_max = 10,
          probability = 1
        }
      }
    },
    walking_sound = crude_oil.walking_sound,
    driving_sound = crude_oil.driving_sound,
    collision_box = table.deepcopy(crude_oil.collision_box),
    selection_box = table.deepcopy(crude_oil.selection_box),
    resource_patch_search_radius = crude_oil.resource_patch_search_radius,
    tree_removal_probability = crude_oil.tree_removal_probability,
    tree_removal_max_distance = crude_oil.tree_removal_max_distance,
    autoplace = mint_oil_autoplace,
    stage_counts = table.deepcopy(crude_oil.stage_counts),
    stages = mint_oil_stages,
    map_color = {r = 0.2, g = 0.8, b = 0.4},
    map_grid = false
  }
})

data:extend({
  {
    type = "autoplace-control",
    name = "dulcium-ore",
    icon = "__base__/graphics/icons/iron-ore.png",
    icon_size = 64,
    order = "b-dulcium",
    richness = true,
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "saccharite-ore",
    icon = "__base__/graphics/icons/copper-ore.png",
    icon_size = 64,
    order = "b-saccharite",
    richness = true,
    category = "resource"
  },
  {
    type = "autoplace-control",
    name = "mint-oil",
    icon = "__base__/graphics/icons/crude-oil.png",
    icon_size = 64,
    order = "b-mint",
    richness = true,
    category = "resource"
  }
})
