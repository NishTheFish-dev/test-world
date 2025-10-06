data:extend({
  {
    type = "recipe",
    name = "dulcium-plate",
    category = "smelting",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "dulcium-ore", amount = 1}
    },
    results = {
      {type = "item", name = "dulcium-plate", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "saccharite-crystal",
    category = "smelting",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "saccharite-ore", amount = 1}
    },
    results = {
      {type = "item", name = "saccharite-crystal", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "white-rock-candy",
    category = "sugar-processing",
    enabled = false,
    energy_required = 3,
    ingredients = {
      {type = "item", name = "dulcium-ore", amount = 2},
      {type = "item", name = "saccharite-ore", amount = 2}
    },
    results = {
      {type = "item", name = "white-rock-candy", amount = 5}
    }
  },
  {
    type = "recipe",
    name = "crushed-white-candy",
    category = "candy-crushing",
    enabled = false,
    energy_required = 2,
    ingredients = {
      {type = "item", name = "white-rock-candy", amount = 5}
    },
    results = {
      {type = "item", name = "crushed-white-candy", amount = 10}
    }
  },
  {
    type = "recipe",
    name = "dissolve-white-candy",
    icon = "__base__/graphics/icons/stone.png",
    icon_size = 64,
    category = "candy-dissolution",
    enabled = false,
    energy_required = 4,
    ingredients = {
      {type = "item", name = "crushed-white-candy", amount = 10},
      {type = "fluid", name = "candy-solvent", amount = 5}
    },
    results = {
      {type = "item", name = "iron-ore", amount = 3},
      {type = "item", name = "copper-ore", amount = 3},
      {type = "item", name = "coal", amount = 3},
      {type = "item", name = "stone", amount = 3}
    }
  },
  {
    type = "recipe",
    name = "candy-solvent",
    category = "chemistry",
    enabled = false,
    energy_required = 3,
    ingredients = {
      {type = "fluid", name = "mint-oil", amount = 50}
    },
    results = {
      {type = "fluid", name = "candy-solvent", amount = 10}
    }
  },
  {
    type = "recipe",
    name = "peppermint-disc",
    category = "chemistry",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type = "fluid", name = "mint-oil", amount = 20},
      {type = "item", name = "saccharite-crystal", amount = 1}
    },
    results = {
      {type = "item", name = "peppermint-disc", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "chocolate-chip",
    category = "crafting-with-fluid",
    enabled = false,
    energy_required = 3,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 2},
      {type = "item", name = "copper-cable", amount = 3},
      {type = "fluid", name = "liquid-chocolate", amount = 20}
    },
    results = {
      {type = "item", name = "chocolate-chip", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "wafer-frame",
    category = "crafting",
    enabled = false,
    energy_required = 4,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 3},
      {type = "item", name = "steel-plate", amount = 5}
    },
    results = {
      {type = "item", name = "wafer-frame", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "sugar-glass-platform",
    category = "crafting",
    enabled = false,
    energy_required = 10,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 10},
      {type = "item", name = "wafer-frame", amount = 2},
      {type = "item", name = "copper-cable", amount = 10}
    },
    results = {
      {type = "item", name = "space-platform-foundation", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "crystalline-solar-panel",
    category = "crafting",
    enabled = false,
    energy_required = 8,
    ingredients = {
      {type = "item", name = "saccharite-crystal", amount = 5},
      {type = "item", name = "chocolate-chip", amount = 5},
      {type = "item", name = "peppermint-disc", amount = 5}
    },
    results = {
      {type = "item", name = "crystalline-solar-panel", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "crystal-accumulator",
    category = "crafting",
    enabled = false,
    energy_required = 6,
    ingredients = {
      {type = "item", name = "chocolate-chip", amount = 4},
      {type = "item", name = "peppermint-disc", amount = 2}
    },
    results = {
      {type = "item", name = "crystal-accumulator", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "confectionery-science-pack",
    category = "crafting",
    enabled = false,
    energy_required = 12,
    ingredients = {
      {type = "item", name = "peppermint-disc", amount = 3},
      {type = "item", name = "wafer-frame", amount = 1},
      {type = "item", name = "chocolate-chip", amount = 2}
    },
    results = {
      {type = "item", name = "confectionery-science-pack", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "sugar-processor",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 4},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 3}
    },
    results = {
      {type = "item", name = "sugar-processor", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "candy-hammer",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 4},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 3}
    },
    results = {
      {type = "item", name = "candy-hammer", amount = 1}
    }
  },
  {
    type = "recipe",
    name = "candy-dissolver",
    enabled = false,
    energy_required = 5,
    ingredients = {
      {type = "item", name = "dulcium-plate", amount = 4},
      {type = "item", name = "iron-gear-wheel", amount = 5},
      {type = "item", name = "electronic-circuit", amount = 3},
      {type = "item", name = "pipe", amount = 5}
    },
    results = {
      {type = "item", name = "candy-dissolver", amount = 1}
    }
  }
  
})
