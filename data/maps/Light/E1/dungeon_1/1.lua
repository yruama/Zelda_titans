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
	chest:set_enabled(false)
	if game:get_value('d1_boss_key') == true then
		bk:set_enabled(true)
	else
		bk:set_enabled(false)
	end
end

switch1.on_activated = function ()
	map:open_doors('door')
	sol.audio.play_sound("door_open")
end

switch2.on_activated = function ()
	set_enemy(true)
end

switch3.on_activated = function ()
	chest:set_enabled(true)
	sol.audio.play_sound("secret")
end