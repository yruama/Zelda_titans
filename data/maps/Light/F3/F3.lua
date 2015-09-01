local map = ...
local game = map:get_game()

function map:on_started()
	local wood_key = game:get_value('wood_key_access')
	if wood_key == true then
		wood_key_access_tp:set_enabled(false)
	end
end
