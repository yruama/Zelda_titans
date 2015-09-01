local map = ...
local game = map:get_game()

function map:on_started()
	if game:get_value('d1_0_p0_save') then
		map:open_doors("d1_0_p0")
	end
	D1_0_E_0:set_enabled(false)
	D1_0_E_1:set_enabled(false)
	D1_0_E_2:set_enabled(false)
	D1_0_E_3:set_enabled(false)
	D1_0_E_4:set_enabled(false)
	D1_0_E_5:set_enabled(false)
	D1_0_E_6:set_enabled(false)
	D1_0_E_7:set_enabled(false)

	if destination == to_d1 
	and not game:get_value('chap1-donjon1') then
		sol.audio.play_sound("navi")
		game:start_dialog('Quest-Help.chap1.navi_donjon1')
		game:get_value('chap1-donjon1', true)
	end

end

d1_0_i0.on_activated = function()
	map:open_doors('d1_0_p0')
	game:set_value("d1_0_p0_save", true)
end

d1_0_i1.on_activated = function()
	D1_0_E_0:set_enabled(true)
	D1_0_E_1:set_enabled(true)
	D1_0_E_2:set_enabled(true)
	D1_0_E_3:set_enabled(true)
	D1_0_E_4:set_enabled(true)
	D1_0_E_5:set_enabled(true)
	D1_0_E_6:set_enabled(true)
	D1_0_E_7:set_enabled(true)
end
