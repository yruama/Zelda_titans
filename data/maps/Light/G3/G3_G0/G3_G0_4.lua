local map = ...
local game = map:get_game()

function map:on_started()
  zst:set_enabled(false)
  zse:set_enabled(false)
end
revel_secret.on_activated = function()
  zone_secret:set_enabled(false)
  zst:set_enabled(true)
  zse:set_enabled(true)
end
