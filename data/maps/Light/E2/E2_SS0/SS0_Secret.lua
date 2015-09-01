local map = ...
local game = map:get_game()
local continue = true

local PosX
local PosY
local Grid

local function hasWin(n)
	for x = 0, 2 do
		if Grid[x][0] == n and Grid[x][1] == n and Grid[x][2] == n then
			return 1
		end
		if Grid[x][0] == n and Grid[x][2] == n and Grid[x][1] == n then
			return 1
		end
		if Grid[x][1] == n and Grid[x][2] == n and Grid[x][0] == n then
			return 1
		end
		if x == 0 and Grid[0][0] == n and Grid[1][1] == 1 and Grid[2][2] == n then
			return 1
		end
		if x == 0 and Grid[1][1] == n and Grid[2][2] == 1 and Grid[0][0] == n then
			return 1
		end
		if x == 2 and Grid[2][0] == n and Grid[1][1] == 1 and Grid[0][2] == n then
			return 1
		end
		if x == 2 and Grid[0][2] == n and Grid[2][2] == 1 and Grid[2][0] == n then
			return 1
		end
	end
	for y = 0, 2 do
		if Grid[0][y] == n and Grid[1][y] == n and Grid[2][y] == n then
			return 1
		end
		if Grid[0][y] == n and Grid[2][y] == n and Grid[1][y] == n then
			return 1
		end
		if Grid[1][y] == n and Grid[2][y] == n and Grid[0][y] == n then
			return 1
		end
	end
	return 0
end

local function getDanger()
	for x = 0, 2 do
		if Grid[x][0] == 1 and Grid[x][1] == 1 and Grid[x][2] == 0 then
			return x .. "_2"
		end
		if Grid[x][0] == 1 and Grid[x][2] == 1 and Grid[x][1] == 0 then
			return x .. "_1"
		end
		if Grid[x][1] == 1 and Grid[x][2] == 1 and Grid[x][0] == 0 then
			return x .. "_0"
		end
		if x == 0 and Grid[0][0] == 1 and Grid[1][1] == 1 and Grid[2][2] == 0 then
			return "2_2"
		end
		if x == 0 and Grid[1][1] == 1 and Grid[2][2] == 1 and Grid[0][0] == 0 then
			return "0_0"
		end
		if x == 2 and Grid[2][0] == 1 and Grid[1][1] == 1 and Grid[0][2] == 0 then
			return "0_2"
		end
		if x == 2 and Grid[0][2] == 1 and Grid[1][1] == 1 and Grid[2][0] == 0 then
			return "2_0"
		end
	end
	for y = 0, 2 do
		if Grid[0][y] == 1 and Grid[1][y] == 1 and Grid[2][y] == 0 then
			return "2_" .. y
		end
		if Grid[0][y] == 1 and Grid[2][y] == 1 and Grid[1][y] == 0 then
			return "1_" .. y
		end
		if Grid[1][y] == 1 and Grid[2][y] == 1 and Grid[0][y] == 0 then
			return "0_" .. y
		end
	end
	return "1_0"
end

local function complete()
	for x = 0, 2 do
	    for y = 0, 2 do
	       if Grid[x][y] == 0 then
	       	  return 0
	   		else
	   			print(Grid[x][y] .. "x" .. x .. "y" .. y)
	   		end 
	    end
	end
	print("\n")
	return 1
end

local function playIA()
	if hasWin(1) == 1 then
	  	game:start_dialog('Quest-Secondary.crepuscule.defi.ok', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
			game:start_dialog('Quest-Secondary.crepuscule.item.clayKey', function ()
				game:get_item('clay_key'):set_variant(1)
			end)
	  	end)
	end
	if complete() == 1 then
		game:start_dialog('Quest-Secondary.crepuscule.defi.fail', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
	  	end)
	end
	local i = getDanger()
	for entity in map:get_entities("e" .. i) do
	  	entity:set_enabled(true)
	  	local a, b = i:match("([^_]+)_([^_]+)")
	  	Grid[tonumber(a)][tonumber(b)] = 2
	  	if hasWin(2) == 1 then
	  		game:start_dialog('Quest-Secondary.crepuscule.defi.fail', function ()
		  		for entities in map:get_entities("case") do
					entities:set_enabled(false)
				end
		  	end)
	  	end
	end
	for entity in map:get_entities("case" .. i) do
		entity:set_enabled(false)
	end
	for entity in map:get_entities("case_" .. i) do
		entity:set_enabled(false)
	end
end

crepuscule.on_interaction = function ()
	game:start_dialog('Quest-Secondary.crepuscule.pres', function ()
		game:start_dialog('Quest-Secondary.crepuscule.defi.ttt', function ()
			for entities in map:get_entities("case") do
				entities:set_enabled(true)
			end
			l1_1:set_enabled(true)
			playIA()
		end)
	end)
end

function map:on_started()
	for entities in map:get_entities("l") do
		entities:set_enabled(false)
	end
	for entities in map:get_entities("e") do
		entities:set_enabled(false)
	end
	for entities in map:get_entities("case") do
		entities:set_enabled(false)
	end
	Grid = {}
	for x = 0, 2 do
	    Grid[x] = {}

	    for y = 0, 2 do
	        Grid[x][y] = 0 
	    end
	end
	Grid[1][1] = 1
end

case0_0.on_interaction = function ()
	l0_0:set_enabled(true)
	Grid[0][0] = 1
	case0_0:set_enabled(false)
	case_0_0:set_enabled(false)
	playIA()
end

case_0_0.on_interaction = function ()
	l0_0:set_enabled(true)
	Grid[0][0] = 1
	case0_0:set_enabled(false)
	case_0_0:set_enabled(false)
	playIA()
	if hasWin(1) == 1 then
	  	game:start_dialog('Quest-Secondary.crepuscule.defi.ok', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
	  	end)
	end
	if complete() == 1 then
		game:start_dialog('Quest-Secondary.crepuscule.defi.fail', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
	  	end)
	end
end

case0_1.on_interaction = function ()
	l0_1:set_enabled(true)
	Grid[0][1] = 1
	case0_1:set_enabled(false)
	playIA()
	if hasWin(1) == 1 then
	  	game:start_dialog('Quest-Secondary.crepuscule.defi.ok', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
	  	end)
	end
	if complete() == 1 then
		game:start_dialog('Quest-Secondary.crepuscule.defi.fail', function ()
	  		for entities in map:get_entities("case") do
				entities:set_enabled(false)
			end
	  	end)
	end
end

case0_2.on_interaction = function ()
	l0_2:set_enabled(true)
	Grid[0][2] = 1
	case0_2:set_enabled(false)
	case_0_2:set_enabled(false)
	playIA()
end

case_0_2.on_interaction = function ()
	l0_2:set_enabled(true)
	Grid[0][2] = 1
	case_0_2:set_enabled(false)
	case0_2:set_enabled(false)
	playIA()
end

case1_0.on_interaction = function ()
	l1_0:set_enabled(true)
	Grid[1][0] = 1
	case1_0:set_enabled(false)
	playIA()
end

case1_2.on_interaction = function ()
	l1_2:set_enabled(true)
	Grid[1][2] = 1
	case1_2:set_enabled(false)
	playIA()
end

case2_0.on_interaction = function ()
	l2_0:set_enabled(true)
	Grid[2][0] = 1
	case2_0:set_enabled(false)
	case_2_0:set_enabled(false)
	playIA()
end

case_2_0.on_interaction = function ()
	l2_0:set_enabled(true)
	Grid[2][0] = 1
	case_2_0:set_enabled(false)
	case2_0:set_enabled(false)
	playIA()
end


case2_1.on_interaction = function ()
	l2_1:set_enabled(true)
	Grid[2][1] = 1
	case2_1:set_enabled(false)
	playIA()
end

case2_2.on_interaction = function ()
	l2_2:set_enabled(true)
	Grid[2][2] = 1
	case2_2:set_enabled(false)
	case_2_2:set_enabled(false)
	playIA()
end

case_2_2.on_interaction = function ()
	l2_2:set_enabled(true)
	Grid[2][2] = 1
	case_2_2:set_enabled(false)
	case2_2:set_enabled(false)
	playIA()
end