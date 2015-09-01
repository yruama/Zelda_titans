local map = ...
local game = map:get_game()

function map:on_started()

end


ss0_8_npc.on_interaction = function ()
	game:start_dialog('Quest-Dialog.chap1.ss.voleur', function(andwer)
		if answer == 1 then
			game:start_dialog('Quest-Dialog.chap1.ss.voleur.o')
		else
			game:start_dialog('Quest-Dialog.chap1.ss.voleur.n')
		end
		hero:freeze()
        local m = sol.movement.create("path")
        m:set_path({0,0,0,0,0})
        m:set_speed(80)
        --ss0_8_npc:set_animation("walking")
        m:start(ss0_8_npc, function()
        	hero:unfreeze()
		end)
	end)
end

ss0_8_i.on_activated = function ()
	game:start_dialog('Quest-Dialog.chap1.ss.voleur.course', function ()
		local m = sol.movement.create('path_finding')
		m:set_target(map:get_entity("hero"))
		m:set_speed(64)
		m:start(ss0_8_npc)
	end)
end