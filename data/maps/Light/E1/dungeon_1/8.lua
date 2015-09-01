local map = ...
local game = map:get_game()

function map:on_started()

end

switch.on_activated = function ()
	game:set_value('d1_boss_key', true)
	game:start_dialog('Quest-Help.chap1.dungeon1.boss_key')
end