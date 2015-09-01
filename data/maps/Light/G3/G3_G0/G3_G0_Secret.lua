local map = ...
local game = map:get_game()
local continue = true

local PosX
local PosY
local Grid

function map:on_started()
	ruppebag:set_enabled(false)
	for entities in map:get_entities("m") do
		entities:set_enabled(false)
	end
	for entities in map:get_entities("b") do
		entities:set_enabled(false)
	end
	for entities in map:get_entities("case") do
		entities:set_enabled(false)
	end
	Grid = {}
	for x = 0, 6 do
	    Grid[x] = {}

	    for y = 0, 5 do
	        Grid[x][y] = 0 
	    end
	end
end

local function getPos(x)
	local i = 5
	local state = true

	while state do
		if i == 0 then
			state = false
		end
		if Grid[x][i] ~= 0 then
			state = false
			return i + 1
		end
		i = i - 1
	end
	return 0
end

case0.on_interaction = function ()
	if getPos(0) > -1 and continue then
		entitie = "b" .. getPos(0) .. "_0"
		Grid[0][getPos(0)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 0, getPos(0) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

case1.on_interaction = function ()
	if getPos(1) > -1 and continue then
		entitie = "b" .. getPos(1) .. "_1"
		Grid[1][getPos(1)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 1, getPos(1) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

case2.on_interaction = function ()
	if getPos(2) > -1 and continue then
		entitie = "b" .. getPos(2) .. "_2"
		Grid[2][getPos(2)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 2, getPos(2) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()			
		end
	end
end

case3.on_interaction = function ()
	if getPos(3) > -1 and continue then
		entitie = "b" .. getPos(3) .. "_3"
		Grid[3][getPos(3)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 3, getPos(3) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

case4.on_interaction = function ()
	if getPos(4) > -1 and continue then
		entitie = "b" .. getPos(4) .. "_4"
		Grid[4][getPos(4)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 4, getPos(4) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

case5.on_interaction = function ()
	if getPos(5) > -1 and continue then
		entitie = "b" .. getPos(5) .. "_5"
		Grid[5][getPos(5)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 5, getPos(5) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

case6.on_interaction = function ()
	if getPos(6) > -1 and continue then
		entitie = "b" .. getPos(6) .. "_6"
		Grid[6][getPos(6)] = 2
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, 6, getPos(6) - 1) == -1 then
			game:start_dialog('Quest-Secondary.ruppebag.win', function ()
				ruppebag:set_enabled(true)
			end)
			continue = false
		else
			play_ia()
		end
	end
end

puissance.on_interaction = function ()
	game:start_dialog('Quest-Secondary.ruppebag.1', function (answer)
		if answer == 1 then
			for entity in map:get_entities('case') do
			  	entity:set_enabled(true)
			end
			game:start_dialog('Quest-Secondary.ruppebag.1.o')
		else
			game:start_dialog('Quest-Secondary.ruppebag.1.n')
		end
	end)
end

-------------------------------------------------------------------

function play_ia()
	-- body
	local res = 0
	local pam
	
	pam	= copy_tab()

	res = min_max(pam, 0)
	print(res)
	print_tab(pam)
	print()
	print_tab(Grid)
	print("----------------")
	if getPos(res) > -1 then
		entitie = "m" .. getPos(res) .. "_"..res
		Grid[res][getPos(res)] = 1
		for entity in map:get_entities(entitie) do
	  		entity:set_enabled(true)
		end
		if win(Grid, res, getPos(res) - 1) == 1 then
			game:start_dialog('Quest-Secondary.ruppebag.lose')
			continue = false
		end
	end
end

function copy_tab()
	-- body
	local pam

	pam = {}
	for x=0,6 do
		i = 0
		pam[x] = {}
		for y=0,5 do
			pam[x][y] = Grid[x][y]
		end
	end
	return pam
end

function print_tab(pam)
	-- body
	for x=0,6 do
		print(pam[x][0] .. " " .. pam[x][1] .. " " .. pam[x][2] .. " " .. pam[x][4] .. " " .. pam[x][4] .. " " .. pam[x][5])
	end
end

function win(pam, posx, posy)
	-- body
	local mult = 1
	local res = 1
	local y
	local x

--	print("entré dans win avec "..posx..","..posy)
--	print_tab(pam)
	for y=-1,1 do
		for x=-1,1 do
			if x ~= 0 or y ~= 0 then
				if pam[posx][posy] == 1 then
					res = 1
				else
					res	= 1
				end
				mult = 1
--				print("pour le trajet => "..x..","..y)
				while (posx + x*mult >= 0) and (posx + x*mult < 7) and (posy + y*mult >=0) and posy + y*mult < 6 and pam[posx+x*mult][posy+y*mult] == 1 do
					res = res + 1
					mult = mult + 1
--					print("ia c'est bon pour la case"..posx + x*mult..","..posy + y*mult.." donc res="..res)
				end
				mult = 1;
				while (posx + x*mult*-1 >= 0 and posx + x*mult*-1 < 7 and posy + y*mult*-1 >=0 and posy + y*mult*-1 < 6 and pam[posx+x*mult*-1][posy+y*mult*-1] == 1) do
					res = res + 1
					mult = mult + 1
--					print("-ia c'est bon pour la case"..(posx + x*mult*-1)..","..(posy + y*mult*-1).." donc res="..res)
				end
--				print("pour l'ia donc res="..res)
				if res >= 4 then
					return 1
				end

				if pam[posx][posy] == 2 then
					res = 1
				else
					res	= 0
					res = 1
				end
				mult = 1
				while (posx + x*mult >= 0) and (posx + x*mult < 7) and (posy + y*mult >=0) and posy + y*mult < 6 and pam[posx+x*mult][posy+y*mult] == 2 do
					res = res + 1
					mult = mult + 1
--					print("j1 c'est bon pour la case"..(posx + x*mult)..","..(posy + y*mult).." donc res="..res)
				end
				mult = 1;
				while (posx + x*mult*-1 >= 0 and posx + x*mult*-1 < 7 and posy + y*mult*-1 >=0 and posy + y*mult*-1 < 6 and pam[posx+x*mult*-1][posy+y*mult*-1] == 2) do
					res = res + 1
					mult = mult + 1
--					print("-j1 c'est bon pour la case"..(posx + x*mult*-1)..","..(posy + y*mult*-1).." donc res="..res)
				end
--				print("pour j1 donc res="..res)
				if res >= 4 then
					return -1
				end
			end
		end
	end
	return 0
end

-- update d'un plateau lors d'un mouvement
function update_map(pam, color, posx, posy)
	-- body
	pam[posx][posy] = color
	return pam
end

function can_play(pam, posx)
	-- body
	local i = 0

	while pam[posx][i] ~= 0 and i < 6 do
		i = i + 1
	end
	return i
end

-- fonction en rec
function min_max(pam, rec)
	-- body
	local save_pos = 0
	local save_value = 0
	local now_value = 0
	local posy = 0
	local res = 1
	local posx

	if rec == 0 then
		save_pos = math.random(0,6)
		while can_play(pam, save_pos) > 6 do
			save_pos = math.random(0,6)
		end
	end

--	print("rentre dans min_max avec rec="..rec)
--	print_tab(pam)
	if rec < 6 then
		for posx=0,6 do
			posy = can_play(pam, posx)
--			print("peut on jouer en "..posx.."? "..posy)
			if posy < 6 then
				res = win(pam, posx, posy)
--				print("y a t-il un gagnant en "..posx..","..posy.." => "..res)
				if res ~= 0 and rec ~= 0 then
					return res
				elseif res ~= 0 and rec == 0 then
					return posx
				end
				now_value = min_max(update_map(pam, rec % 2 + 1, posx, posy), rec + 1)
				pam[posx][posy] = 0
--				print ("ret MIN-MAX =>"..now_value )
				if rec % 2 == 0 then
					if now_value > save_value then
						save_value = now_value
						save_pos = posx
					end
				else
					if now_value < save_value then
						save_value = now_value
						save_pos = posx
					end
				end
			end
		end
	end
	if rec > 0 then
		return save_value
	else
		return save_pos
	end
end