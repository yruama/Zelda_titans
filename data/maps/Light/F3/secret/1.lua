local map = ...
local game = map:get_game()

function map:on_started()
	p0:set_enabled(false)
end

i0.on_activated = function()
	p0:set_enabled(true)
end

i1.on_activated = function()
	p0:set_enabled(true)
end