local map = ...
local game = map:get_game()
local interrupteur = true

function map:on_started()
  if interrupteur then 
    chest_sword:set_enabled(false)
  end
end

function map:on_update()
  if  torch0:get_sprite():get_animation() == "lit"
  and torch1:get_sprite():get_animation() == "lit"
  and torch2:get_sprite():get_animation() == "lit"
  and torch3:get_sprite():get_animation() == "lit"
  and interrupteur then
      sol.audio.play_sound("secret")
      chest_sword:set_enabled(true)
      interrupteur = false
  end
end

navi_lamp.on_activated = function ()
  if interrupteur then
    sol.audio.play_sound("navi")
    game:start_dialog("Quest-Help.chap1.navi_lamp")
  end
end
