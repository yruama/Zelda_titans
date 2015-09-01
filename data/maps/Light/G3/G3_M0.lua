local map = ...
local game = map:get_game()

local int = 0

local function jump_from_bed()
  hero:set_visible(true)
  hero:start_jumping(4, 24, true)
  game:set_pause_allowed(true)
  bed:get_sprite():set_animation("empty_open")
  sol.audio.play_sound("hero_lands")
  sol.timer.start(1000, function()
      game:start_dialog('Quest-Dialog.chap1.dream.2')
  end)
end

local function wake_up()
  snores:remove()
  bed:get_sprite():set_animation("hero_waking")
  sol.timer.start(500, function()
    jump_from_bed()
  end)
end

local function next_dialog()
  if int < 2 then
    sol.audio.play_sound('navi')
    game:start_dialog('Quest-Dialog.chap1.dream.' .. int, function ()
      int = int + 1
      sol.timer.start(1000, next_dialog)
    end)
  else
    sol.timer.start(1000, wake_up)
  end
end

function map:on_started(destination)

  if destination == from_intro then
    -- the intro scene is playing
    game:set_hud_enabled(true)
    game:set_pause_allowed(false)
    game:set_dialog_style("box")
    snores:get_sprite():set_ignore_suspend(true)
    bed:get_sprite():set_animation("hero_sleeping")
    hero:freeze()
    hero:set_visible(false)
    sol.timer.start(1500, next_dialog)
  else
    snores:remove()
  end
end
