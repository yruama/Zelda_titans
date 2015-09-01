local map = ...
local game = map:get_game()

function map:on_started()
	chest1:set_enabled(false)
	chest2:set_enabled(false)
end

chest_1.on_activated = function()
	chest1:set_enabled(true)
end

chest_2.on_activated = function()
	chest2:set_enabled(true)
end