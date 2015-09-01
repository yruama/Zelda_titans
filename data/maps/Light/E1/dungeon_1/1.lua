local map = ...
local game = map:get_game()

function map:on_started()
	d1_1_p0:set_enabled(false)
end

d1_1_i0.on_activated = function()
	d1_1_p0:set_enabled(true)
end

for enemy in map:get_entities("d1_1_e0") do
	function enemy:on_dead()
		if not map:has_entities("d1_1_e0") then
			map:open_doors("d1_1_p0")
		end
	end
end