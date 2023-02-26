-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function snowParticles(screenW)
	local graphics = love.graphics

	local size = 2
	local cnv = graphics.newCanvas(size*2, size*2)
	graphics.setCanvas(cnv)
	graphics.draw(f0b.elem.circle, size, size, 0, size)
	graphics.setCanvas()

	local snow = graphics.newParticleSystem(cnv, 512)
	snow:setDirection(math.pi/2)
	snow:setSpeed(12)
	snow:setPosition(screenW, -size)
	snow:setEmissionArea("uniform", screenW, size)
	snow:setEmissionRate(6)
	snow:setParticleLifetime(60)
	snow:setSizes(4/3)
	snow:start()
	return snow
end

local function creditScreen(style, w, h)
	local c, dc = style.color, style.disabled.color
	local credit = {dc, "Basada en una historia original\npor el ",
		c, "G", dc, "rupo\n\t\t\t\t",
		c, "W", dc, "arominutes.\n\nGráficos adicionales por ",
		c, "Z", dc, "eh ", c, "R", dc, "oh."}
	local text = love.graphics.newText(style.font, credit)
	local textW, textH = text:getDimensions()
	return {text,
		math.floor(w / 2 - textW / 2),
		math.floor(h / 2 - textH / 2)}
end

local function menuScreen(style, w, h)
	local text = love.graphics.newText(style.font, "Gothic World 1")
	local textW, textH = text:getDimensions()
	return {text,
		math.floor(w * 2/3 - textW / 2),
		math.floor(h * 2/3 - textH / 2)}
end

local fload = f0b.std.dofile

local vn = fload("engine/vn.lua")
local toc = fload("engine/toc.lua")
local stub = fload("engine/stub.lua")

local w, h = love.graphics.getDimensions()
local elemColor = {0, 0, 0, 1/3}

local vnID = gamestate:add(vn.new(res.index, res.style.vn))
local tocID = gamestate:add(toc.new(res.index, res.style.menu, vnID))
local credID = gamestate:add(stub.new(), credBG)
gamestate[tocID].tracks = f0b.jukebox.newTracklist(
	{nil, 1, true, false, source="Pronóstico de Nieve (calliope ver).ogg"}
)
gamestate[tocID].background = f0b.layers.normalize({
	{args={"menu/index.png"}, color={1, 1, 1, 1}, distance=4},
	{args={snowParticles(w)}, distance=1},
})
gamestate[credID].background = {
	{args=creditScreen(res.style.menu, w, h)}
}

local confBG = f0b.layers.normalize({
	{args={{
		{args={"menu/conf.png"}},
		{args={f0b.elem.circle, w/2, h/2, 0, w/2}, color=elemColor},
	}}},
})
local mainBG = f0b.layers.normalize({
	{args={{
		{args=menuScreen(res.style.title, w, h)},
--		{args={"menu/main.png"}},
--		{args=f0b.elem.screenFill(.89), color=elemColor},
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
	{"Créditos", "state", credID},
	{"Salir", "state", true},
	x = 3, y = 3, background = mainBG,
}

local mainMenu = menu.new(mainEntries, res.style.menu)
mainMenu.tracks = f0b.jukebox.newTracklist({source="Viento.ogg"})
mainMenu.backgroundColor = {0,0,0,1} --{1,1,1,1}
gamestate:add(mainMenu, nil, true)
