local function create_candy_building(name, crafting_speed, crafting_categories, tint)
  local assembler_base = data.raw["assembling-machine"]["assembling-machine-2"]
  
  return {
    type = "assembling-machine",
    name = name,
    icon = "__base__/graphics/icons/assembling-machine-2.png",
    icon_size = 64,
    flags = {"placeable-neutral", "placeable-player", "player-creation"},
    minable = {mining_time = 0.2, result = name},
    max_health = 350,
    corpse = "assembling-machine-2-remnants",
    dying_explosion = "assembling-machine-2-explosion",
    resistances = {
      {type = "fire", percent = 70}
    },
    fluid_boxes = {
      {
        production_type = "input",
        pipe_picture = assembler_base.fluid_boxes[1].pipe_picture,
        pipe_covers = assembler_base.fluid_boxes[1].pipe_covers,
        volume = 1000,
        pipe_connections = {{flow_direction="input", direction = defines.direction.north, position = {0, -1}}}
      },
      {
        production_type = "output",
        pipe_picture = assembler_base.fluid_boxes[2].pipe_picture,
        pipe_covers = assembler_base.fluid_boxes[2].pipe_covers,
        volume = 1000,
        pipe_connections = {{flow_direction="output", direction = defines.direction.south, position = {0, 1}}}
      }
    },
    fluid_boxes_off_when_no_fluid_recipe = true,
    collision_box = {{-1.2, -1.2}, {1.2, 1.2}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    crafting_categories = crafting_categories,
    crafting_speed = crafting_speed,
    energy_source = {
      type = "electric",
      usage_priority = "secondary-input",
      emissions_per_minute = {pollution = 4}
    },
    energy_usage = "150kW",
    module_slots = 2,
    allowed_effects = {"consumption", "speed", "productivity", "pollution"},
    graphics_set = {
      animation = {
        layers = {
          {
            filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2.png",
            priority = "high",
            width = 214,
            height = 218,
            frame_count = 32,
            line_length = 8,
            shift = util.by_pixel(0, 2),
            scale = 0.5,
            tint = tint
          }
        }
      }
    },
    working_sound = {
      sound = {{filename = "__base__/sound/assembling-machine-t2-1.ogg", volume = 0.7}},
      audible_distance_modifier = 0.5,
      fade_in_ticks = 4,
      fade_out_ticks = 20
    }
  }
end

data:extend({
  create_candy_building(
    "sugar-processor",
    1.0,
    {"sugar-processing"},
    {r = 0.9, g = 0.7, b = 0.9}
  ),
  create_candy_building(
    "candy-hammer",
    1.0,
    {"candy-crushing"},
    {r = 0.9, g = 0.9, b = 0.7}
  ),
  create_candy_building(
    "candy-dissolver",
    1.0,
    {"candy-dissolution"},
    {r = 0.7, g = 0.9, b = 0.8}
  ),
  {
    type = "solar-panel",
    name = "crystalline-solar-panel",
    icon = "__base__/graphics/icons/solar-panel.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "crystalline-solar-panel"},
    max_health = 200,
    corpse = "solar-panel-remnants",
    collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    energy_source = {
      type = "electric",
      usage_priority = "solar"
    },
    picture = {
      layers = {
        {
          filename = "__base__/graphics/entity/solar-panel/solar-panel.png",
          priority = "high",
          width = 230,
          height = 224,
          shift = util.by_pixel(3.5, 0),
          scale = 0.5,
          tint = {r = 0.9, g = 0.9, b = 1.0}
        }
      }
    },
    production = "60kW"
  },
  {
    type = "accumulator",
    name = "crystal-accumulator",
    icon = "__base__/graphics/icons/accumulator.png",
    icon_size = 64,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "crystal-accumulator"},
    max_health = 150,
    corpse = "accumulator-remnants",
    collision_box = {{-0.9, -0.9}, {0.9, 0.9}},
    selection_box = {{-1, -1}, {1, 1}},
    energy_source = {
      type = "electric",
      buffer_capacity = "5MJ",
      usage_priority = "tertiary",
      input_flow_limit = "300kW",
      output_flow_limit = "300kW"
    },
    picture = {
      layers = {
        {
          filename = "__base__/graphics/entity/accumulator/accumulator.png",
          priority = "high",
          width = 132,
          height = 106,
          shift = util.by_pixel(0, -8),
          scale = 0.5,
          tint = {r = 1.0, g = 0.9, b = 1.0}
        }
      }
    },
    charge_cooldown = 30,
    discharge_cooldown = 60
  }
})

data:extend({
  {
    type = "recipe-category",
    name = "sugar-processing"
  },
  {
    type = "recipe-category",
    name = "candy-crushing"
  },
  {
    type = "recipe-category",
    name = "candy-dissolution"
  }
})
