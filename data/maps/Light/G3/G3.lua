local map = ...
local game = map:get_game()

function map:on_started()

  local sensor_sword = map:get_entity('sensor_sword')
  sensor_sword:set_enabled(false)
  local as = game:get_value('ausecours')
  if as == true then
    ausecours:set_enabled(false)
    sensor_quete:set_enabled(false)
    sensor_sword:set_enabled(true)
  end

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

  local pnj = map:get_entity('ausecours')
  local sensor_quete = map:get_entity('sensor_quete')
  sensor_quete.on_activated = function ()
    local m = sol.movement.create("path")
    hero:freeze()
    m:set_path({4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,2,2,2,2})
    m:set_speed(80)
    m:start(ausecours, function()
      game:start_dialog("Quest-Dialog.chap1.attaque", function()
        local n = sol.movement.create('path')
        n:set_path({6,6,6,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0})
        n:set_speed(80)
        n:start(ausecours, function()
          sensor_quete:set_enabled(false)
          ausecours:set_enabled(false)
          game:set_value('ausecours', true)
          game:start_dialog("Quest-Dialog.chap1.aventure", function()
            local o = sol.movement.create('path')
            hero:set_direction(1)
            o:set_path({2,2,2,2})
            o:set_speed(80)
            o:start(hero, function ()
              sensor_sword:set_enabled(true)
              hero:unfreeze()
            end)
          end)
        end)
      end)
    end)
  end

 
  sensor_sword.on_activated = function ()
    if not game:has_item('sword') then
      sol.audio.play_sound("navi")
      game:start_dialog("Quest-Error.chap1.sword", function()
          hero:freeze()
          hero:set_direction(1)
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
