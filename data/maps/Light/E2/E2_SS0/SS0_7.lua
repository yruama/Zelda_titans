-- quete principal : Droite - Gauche - Centre - Haut - Bas

local map = ...
local game = map:get_game()
local enigme = 0
local t = 4
local z = 0
local s = 0

function map:on_started()
	tele:set_enabled(false)
	cf:set_enabled(false)
	for switch in map:get_entities("switch_") do
		switch:set_enabled(false)
	end
end

local function fail()
	for switch in map:get_entities("switch_") do
		switch:set_activated(false)
	end
end


local function checkSwitch(j)
	for i = 0, j do
		if enigme == 2 then
			z = i + t
		else
			z = i
		end
		print(z)
		if map:get_entity("switch_" .. z):is_activated() == false then
			sol.audio.play_sound("wrong")
			fail()
			enigme = 0
			s = 1
		end
		t = t - 2
	end
	if j == 4 and s == 0 then
		sol.audio.play_sound("secret")
		if enigme == 1 then
			tele:set_enabled(true)
			cf:set_enabled(true)
			fail()
		else
			map:open_doors('porte_secret')
			fail()
		end
	end
end

switch_0.on_activated = function ()
	t = 4
	s = 0
	if enigme == 0 then
		enigme = 1
	else
		if enigme == 1 then
			checkSwitch(0)
		else
			checkSwitch(4)
		end
	end
end

switch_1.on_activated = function ()
	t = 4
	s = 0
	if enigme == 1 then
		checkSwitch(1)
	else
		checkSwitch(3)
	end
end

switch_2.on_activated = function ()
	t = 4
	s = 0
	if enigme == 1 then
		checkSwitch(2)
	else
		checkSwitch(2)
	end
end

switch_3.on_activated = function ()
	t = 4
	s = 0
	if enigme == 1 then
		checkSwitch(3)
	else
		checkSwitch(1)
	end
end

switch_4.on_activated = function ()
	t = 4
	s = 0
	if enigme == 0 then
		enigme = 2
	else
		if enigme == 1 then
			checkSwitch(4)
		else
			checkSwitch(0)
		end
	end
end

Ysera.on_interaction = function ()
	game:start_dialog("Quest-Dialog.chap1.Ysera", function ()
		for switch in map:get_entities("switch_") do
			switch:set_enabled(true)
		end
	end)
end

--4 = 0 -> 0 + 4
--3 = 1 -> 1 + 2
--2 = 2 -> 2 + 0
--1 = 3 -> 3 - 2
--0 = 4 -> 4 - 4


