local map = ...
local game = map:get_game()

function map:on_started()
  ss0_5sk:set_enabled(false)
end

for enemy in map:get_entities("enemi") do
	function enemy:on_dead()
		if not map:has_entities("enemi") then
			ss0_5sk:set_enabled(true)
		end
	end
end