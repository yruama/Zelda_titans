local map = ...
local game = map:get_game()

block_castle_enter.on_interaction = function ()
	game:start_dialog('Quest-Dialog.chap1.castle.soldier', function ()
		hero:freeze()
        local m = sol.movement.create("path")
        m:set_path({6,6,6})
        m:set_speed(80)
        hero:set_animation("walking")
        m:start(hero, function()
        	game:start_dialog('Quest-Dialog.chap1.castle.navi')
       		hero:unfreeze()
       	end)
	end)
end