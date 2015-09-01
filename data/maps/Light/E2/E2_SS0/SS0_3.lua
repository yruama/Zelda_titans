local map = ...
local game = map:get_game()

function map:on_started()
	if game:get_value('hiiiiiiii') == true then
		portess03:set_enabled(false)
	end
end

ss0_3_p0.on_activated = function()
	portess03:set_enabled(false)
	game:set_value('hiiiiiiii', true)
end
