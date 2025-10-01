-- Placeholder control script.
-- Register runtime events and planet-specific logic here.

script.on_init(function()
  -- Initialize global state for your planet.
  global.planet_state = {
    initialized = true
  }
end)

script.on_configuration_changed(function(event)
  -- Handle migrations and configuration changes.
  if not global.planet_state then
    global.planet_state = { initialized = true }
  end
end)
