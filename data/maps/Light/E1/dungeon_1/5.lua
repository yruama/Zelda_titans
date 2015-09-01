local map = ...
local game = map:get_game()

function map:on_started()
	close_1:set_enabled(false)
end

sensor_close.on_activated = function ()
	sol.audio.play_sound("wrong")
	close_1:set_enabled(true)
end

switch_open.on_activated = function ()
	sol.audio.play_sound("door_open")
	map:open_doors('door')
end