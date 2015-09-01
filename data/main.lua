-- Main script of the quest.

local console = require("console")
local quest_manager = require("quest_manager")

local debug_enabled = false
function sol.main.is_debug_enabled()
  return debug_enabled
end

-- Event called when the program starts.
function sol.main:on_started()

  -- Make quest-specific initializations.
  quest_manager:initialize_quest()

  -- Load built-in settings (audio volume, video mode, etc.).
  sol.main.load_settings()
  sol.video.set_mode("hq4x")
  sol.language.set_language("fr")
  -- If there is a file called "debug" in the write directory, enable debug mode.
  debug_enabled = sol.file.exists("debug")

  local solarus_logo = require("menus/solarus_logo")
  local language_menu = require("menus/language")
  local title_screen = require("menus/title")
  local savegame_menu = require("menus/savegames")

  -- Show the Solarus logo first.
  sol.menu.start(self, solarus_logo)

  -- Then the language selection menu, unless a game was started by a debug key.
  solarus_logo.on_finished = function()
    if self.game == nil then
      sol.menu.start(self, language_menu)
    end
  end

  -- Then the title screen.
  language_menu.on_finished = function()
    if self.game == nil then
      sol.menu.start(self, title_screen)
    end
  end

  -- Then the savegame menu.
  title_screen.on_finished = function()
    if self.game == nil then
      sol.menu.start(self, savegame_menu)
    end
  end
end

-- Event called when the program stops.
function sol.main:on_finished()

  sol.main.save_settings()
end

function sol.main:debug_on_key_pressed(key, modifiers)

  local handled = true
  if key == "f1" then
    if sol.game.exists("save1.dat") then
      self.game = sol.game.load("save1.dat")
      sol.menu.stop_all(self)
      self:start_savegame(self.game)
    end
  elseif key == "f2" then
    if sol.game.exists("save2.dat") then
      self.game = sol.game.load("save2.dat")
      sol.menu.stop_all(self)
      self:start_savegame(self.game)
    end
  elseif key == "f3" then
    if sol.game.exists("save3.dat") then
      self.game = sol.game.load("save3.dat")
      sol.menu.stop_all(self)
      self:start_savegame(self.game)
    end
  elseif key == "f12" and not console.enabled then
    sol.menu.start(self, console)
  elseif sol.main.game ~= nil and not console.enabled then
    local game = sol.main.game
    local hero = nil
    if game ~= nil and game:get_map() ~= nil then
      hero = game:get_map():get_entity("hero")
    end
  end

  return handled
end

-- If debug is enabled, the shift key skips dialogs
-- and the control key traverses walls.
local hero_movement = nil
local ctrl_pressed = false
function sol.main:on_update()

  if sol.main.is_debug_enabled() then
    local game = sol.main.game
    if game ~= nil then

      if game:is_dialog_enabled() then
        if sol.input.is_key_pressed("left shift") or sol.input.is_key_pressed("right shift") then
          game.dialog_box:show_all_now()
        end
      end

      local hero = game:get_hero()
      if hero ~= nil then
        if hero:get_movement() ~= hero_movement then
          -- The movement has changed.
          hero_movement = hero:get_movement()
          if hero_movement ~= nil
              and ctrl_pressed
              and not hero_movement:get_ignore_obstacles() then
            -- Also traverse obstacles in the new movement.
            hero_movement:set_ignore_obstacles(true)
          end
        end
        if hero_movement ~= nil then
          if not ctrl_pressed
              and (sol.input.is_key_pressed("left control") or sol.input.is_key_pressed("right control")) then
            hero_movement:set_ignore_obstacles(true)
            ctrl_pressed = true
          elseif ctrl_pressed
              and (not sol.input.is_key_pressed("left control") and not sol.input.is_key_pressed("right control")) then
            hero_movement:set_ignore_obstacles(false)
            ctrl_pressed = false
          end
        end
      end
    end
  end
end

-- Event called when the player pressed a keyboard key.
function sol.main:on_key_pressed(key, modifiers)

  local handled = false

  -- Debugging features.
  if sol.main.is_debug_enabled() then
    handled = sol.main:debug_on_key_pressed(key, modifiers)
  end

  -- Normal features.
  if not handled then

    if key == "f5" then
      -- F5: change the video mode.
      sol.video.switch_mode()
    elseif key == "return" and (modifiers.alt or modifiers.control)
        or key == "f11" then
      -- Alt + Return or Ctrl + Return or F11: switch fullscreen.
      sol.video.set_fullscreen(not sol.video.is_fullscreen())
    elseif key == "f4" and modifiers.alt then
      -- Alt + F4: stop the program.
      sol.main.exit()
    end
  end

  return handled
end

-- Starts a game.
function sol.main:start_savegame(game)

  local play_game = sol.main.load_file("play_game")
  play_game(game)
end

-- Returns the font and size to be used for dialogs
-- depending on the specified language (the current one by default).
function sol.language.get_dialog_font(language)

  language = language or sol.language.get_language()

  local font
  if language == "zh_TW" or language == "zh_CN" then
    -- Chinese font.
    font = "wqy-zenhei"
    size = 12
  else
    font = "la"
    size = 11
  end

  return font, size
end

-- Returns the font and font size to be used to display text in menus
-- depending on the specified language (the current one by default).
function sol.language.get_menu_font(language)

  language = language or sol.language.get_language()

  local font, size
  if language == "zh_TW" or language == "zh_CN" then
    -- Chinese font.
    font = "wqy-zenhei"
    size = 12
  else
    font = "minecraftia"
    size = 8
  end

  return font, size
end

