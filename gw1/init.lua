-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function snowParticles(screenW, screenH)
	local graphics = love.graphics

	local size = 3
	local cnv = graphics.newCanvas(size*2, size*2)
	graphics.setCanvas(cnv)
	graphics.draw(f0b.elem.circle, size, size, 0, size)
	graphics.setCanvas()

	local speed = 12
	local span = screenH + size*2
	local snow = graphics.newParticleSystem(cnv, 512)
	snow:setDirection(math.pi/2)
	snow:setSpeed(12)
	snow:setPosition(screenW, -size)
	snow:setEmissionArea("uniform", screenW, size)
	snow:setEmissionRate(6)
	snow:setParticleLifetime(span / 12)
	snow:setSizes(1)
	snow:start()
	return snow
end

local fload = f0b.std.dofile
local screen = fload("res/data/screen.lua")

local vn = fload("engine/vn.lua")
local toc = fload("engine/toc.lua")
local stub = fload("engine/stub.lua")

local w, h = love.graphics.getDimensions()
local elemColor = {0, 0, 0, 1/3}

local vnID = gamestate:add(vn.new(res.index, res.style.vn))
local tocID = gamestate:add(toc.new(res.index, res.style.menu, vnID))
local credID = gamestate:add(stub.new())
local helpID = gamestate:add(stub.new())
gamestate[tocID].tracks = f0b.jukebox.newTracklist(
	{nil, 1, true, false, source="Pronóstico de Nieve (calliope ver).ogg"}
)
gamestate[tocID].background = f0b.layers.normalize({
	{args={"menu/index.png"}, color={1, 1, 1, 1}, distance=4},
	{args={snowParticles(w, h)}, distance=1},
})
gamestate[credID].background = {
	{args=screen.credit(res.style.menu, w, h)}
}
gamestate[helpID].background = {
	{args=screen.help(res.style.menu, w, h)}
}

local confBG = f0b.layers.normalize({
	{args={{
		{args={"zeh/conf.png"}},
		{args={f0b.elem.circle, w/2, h/2, 0, w/2}, color=elemColor},
	}}},
})
local mainBG = f0b.layers.normalize({
	{args={{
--		{args=menuScreen(res.style.title, w, h)},
		{args={"zeh/main.png"}},
		{args=f0b.elem.screenFill(.9), color=elemColor},
	}}},
})

local menu = fload("engine/menu.lua")
local mainEntries = {
	{"Comenzar", "state", tocID},
	{"Configuración", "menu", {
		{"Volumen", false},
		{"Volver", "return"},
		x = -9, y = -9, background = confBG,
	}},
	{"Ayuda", "state", helpID},
	{"Créditos", "state", credID},
	{"Salir", "state", true},
	x = 3, y = 3, background = mainBG,
}

local mainMenu = menu.new(mainEntries, res.style.menu)
mainMenu.tracks = f0b.jukebox.newTracklist({source="Viento.ogg"})
mainMenu.backgroundColor = {0,0,0,1}
gamestate:add(mainMenu, nil, true)
