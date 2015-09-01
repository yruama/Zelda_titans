local map = ...
local game = map:get_game()

function map:on_started()
	boss0:set_enabled(false)
	porte_boss:set_enabled(false)
	fin_dungeon_1:set_enabled(false)
end

boss0_i.on_activated = function()
	boss0:set_enabled(true)
	porte_boss:set_enabled(true)
end

for enemy in map:get_entities("boss") do
	function enemy:on_dead()
		fin_dungeon_1:set_enabled(true)
		sol.audio.play_music("boss")
	end
end