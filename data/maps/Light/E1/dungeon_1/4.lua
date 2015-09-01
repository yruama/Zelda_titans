local map = ...
local game = map:get_game()

function map:on_started()

end

switch.on_activated = function ()
	map:open_doors('door')
	sol.audio.play_sound("door_open")
end

