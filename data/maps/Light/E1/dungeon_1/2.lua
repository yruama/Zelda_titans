local map = ...
local game = map:get_game()

function map:on_started()
	if game:get_value('door_2') == true then
		door2:set_enabled(false)
	end
end

