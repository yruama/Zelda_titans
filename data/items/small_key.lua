local item = ...
local game = item:get_game()


function item:on_created()

  self:set_shadow("small")
  self:set_brandish_when_picked(false)
  self:set_sound_when_picked("picked_small_key")
end

function item:get_num_small_keys(map)
	savegame_variable = map:get_world() .. "_small_keys"
  return game:get_value(savegame_variable) or 0
end

function item:on_obtaining(variant, savegame_variable)
	local map = item:get_map()

	savegame_variable = map:get_world() .. "_small_keys"
	item:set_savegame_variable(savegame_variable)
	game:set_value(savegame_variable, item:get_num_small_keys(map) + 1)
end
