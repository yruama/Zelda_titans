local map = ...
local game = map:get_game()

function map:on_started()
end

switch.on_activated = function ()
	sol.audio.play_sound("door_open")
	game:set_value('door_2', true)
	game:start_dialog('Quest-Help.chap1.dungeon1.porte')
end