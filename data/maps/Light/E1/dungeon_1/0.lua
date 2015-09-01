local map = ...
local game = map:get_game()

function map:on_started()
	map:open_doors('door')
end

sensor.on_activated = function ()
	map:close_doors('door')
	sol.audio.play_sound("close_door")
end