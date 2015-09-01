local map = ...
local game = map:get_game()
local navi_cristal_i = true;


navi_cristal.on_activated = function ()
	if navi_cristal_i then
		sol.audio.play_sound("navi")
		 game:start_dialog('Quest-Help.chap1.navi_cristal')
		 navi_cristal = false
	end
end