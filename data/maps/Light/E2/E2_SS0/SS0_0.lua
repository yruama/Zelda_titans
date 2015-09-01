local map = ...
local game = map:get_game()
local surface = sol.surface.create(320, 240)

function map:on_started()
  	if destination == to_ss_castle 
  	and not game:get_value('chap1_sscastle') then
  		sol.audio.play_sound("navi")
		game:start_dialog('Quest-Help.chap1.navi_ss_chateau')
		game:set_value('chap1_sscastle', true)
  	end
end
