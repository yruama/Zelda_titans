local map = ...
local game = map:get_game()

local function set_enemy(s)
	e1:set_enabled(s)
	e2:set_enabled(s)
	e3:set_enabled(s)
	e4:set_enabled(s)
end

function map:on_started()
	set_enemy(false)
end

switch1.on_activated = function ()
	set_enemy(true)
	sol.audio.play_sound("wrong")
end

switch2.on_activated = function ()
	map:open_doors('door')
	sol.audio.play_sound("door_open")
end
