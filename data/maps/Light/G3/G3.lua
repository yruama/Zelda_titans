local map = ...
local game = map:get_game()

function map:on_started()

  local entrance_names = {
    "G3_0"
  }
  for _, entrance_name in ipairs(entrance_names) do
    local sensor = map:get_entity(entrance_name .. "_door_sensor")
    local tile = map:get_entity(entrance_name .. "_door")

    sensor.on_activated_repeat = function()
      if hero:get_direction() == 1
        and tile:is_enabled() then
        tile:set_enabled(false)
        sol.audio.play_sound("door_open")
      end
    end
  end

  local sensor_epee = map:get_entity('sensor_epee')
  sensor_epee.on_activated = function ()
    if not game:has_item('sword') then
      game:start_dialog('Quest-Error.chap1.sword', function ()
        hero:freeze()
        local m = sol.movement.create("path")
        m:set_path({2,2,2})
        m:set_speed(80)
        hero:set_animation("walking")
        m:start(hero, function()
          hero:unfreeze()
        end)
      end)
    end
  end

  local sensor_quest = map:get_entity('lamp_sensor')
  sensor_quest.on_activated = function ()
    if not game:has_item('lamp') then
      sol.audio.play_sound("navi")
      game:start_dialog("Quest-Error.chap1.lamp", function()
          hero:freeze()
          local m = sol.movement.create("path")
          m:set_path({6,6,6})
          m:set_speed(80)
          hero:set_animation("walking")
          m:start(hero, function()
          hero:unfreeze()
        end)
      end)
    end
  end

  local sensor_quest = map:get_entity('sensor_navi_objet')
  sensor_quest.on_activated = function ()
    if not game:get_value('navi_object') then
      sol.audio.play_sound("navi")
      game:start_dialog("Quest-Help.chap1.navi_objet")
      game:set_value('navi_object', true)
    end
  end
end
