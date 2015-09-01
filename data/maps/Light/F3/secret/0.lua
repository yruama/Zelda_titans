local map = ...
local game = map:get_game()

wood_key.on_interaction = function()
	game:start_dialog('Quest-Secondary.wood_key.get', function ()
		if game:get_money() > 14 then
			game:start_dialog('Quest-Secondary.wood_key.get.ok', function ()
				game:get_item('wooden_key'):set_variant(1)
				wood_key:set_enabled(false)
				game:set_value('wood_key_access', true)
			end)
		else
			game:start_dialog('Quest-Secondary.wood_key.get.no', function ()
				wood_key:set_enabled(false)
				game:set_value('wood_key_access', true)
			end)
		end
	end)
end