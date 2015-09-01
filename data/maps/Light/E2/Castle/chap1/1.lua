local map = ...
local game = map:get_game()
local int = 1

function map:on_started()
	local x, y = middle:get_position()
		map:move_camera(x, y, 250, function()
	end)
	zh:set_enabled(false)
	gh:set_enabled(false)
	nh:set_enabled(false)
	fh:set_enabled(false)
	fire:set_enabled(false)
end

local function prisoner()
	local m = sol.movement.create("path")
	m:set_path({4,4,4,4,4,4,4,4,4,4,4})
	m:set_speed(80)
	m:start(kid)
end

local function soldier()
	local m = sol.movement.create("path")
	m:set_path({4,4,4,4,4,4,4,4,4,4,4})
	m:set_speed(80)
	m:start(soldat)
end

local function heroMove()
	local m = sol.movement.create("path")
	m:set_path({4,4,4,4,4,2,2,2,2,2,2,2,2,2,0,0,0,0,0,2,2,2,2,2,2})
	hero:set_direction(3)
	m:set_speed(80)
	m:start(hero, function ()
		gh:set_position(120, 173)
		zh:set_position(368, 60)
	end)
end

local function heroDie()
	fire:set_enabled(true)
	local m = sol.movement.create("path")
	m:set_path({2,2,2,2,2,2,2,2})
	m:set_speed(80)
	m:start(fire, function ()
		fire:set_enabled(false)
		hero:set_animation('dying')
	end)
end

local function dialog()
  if int < 12 then
  	if int == 1 or int == 3 or int == 8 or int == 10 then
  		zh:set_enabled(true)
		gh:set_enabled(false)
		nh:set_enabled(false)
		fh:set_enabled(false)
		game:set_dialog_position('top')
	elseif int == 4 then
		zh:set_enabled(false)
		gh:set_enabled(false)
		nh:set_enabled(true)
		fh:set_enabled(false)
		game:set_dialog_position('bottom')
	elseif int == 6 then
		zh:set_enabled(false)
		gh:set_enabled(false)
		nh:set_enabled(false)
		fh:set_enabled(true)
		game:set_dialog_position('top')
  	else
  		zh:set_enabled(false)
		gh:set_enabled(true)
		nh:set_enabled(false)
		fh:set_enabled(false)
		game:set_dialog_position('bottom')
  	end
    game:start_dialog('Quest-Dialog.chap1.castle.cinematique.' .. int, function ()
      int = int + 1
      if int == 3 then
      	prisoner()
      	soldier()
      	sol.timer.start(2000, dialog)
      elseif int == 7 then
      	heroMove()
      	sol.timer.start(2000, dialog)
      elseif int == 10 then
      	heroDie()
      	sol.timer.start(3000, dialog)
      else
	  	sol.timer.start(250, dialog)
	  end
    end)
  end
  if int == 12 then
  	hero:teleport("Dark/B0/B0_0", 'from_chap1')
  end
end

cinematique.on_activated = function ()
	hero:freeze()
   	local m = sol.movement.create("path")
   	m:set_path({2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2})
   	m:set_speed(80)
   	hero:set_animation("walking")
   	m:start(hero, function()
   		gh:set_enabled(true)
   		game:start_dialog("Quest-Dialog.chap1.castle.cinematique.0", function()
   			dialog()
		end)
	end)
	--hero:unfreeze()
end