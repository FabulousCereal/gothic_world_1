-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local maxPSize = 6
local function snowParticles(screenW, screenH)
	local graphics = love.graphics

	local speed = 12
	local span = screenH + maxPSize*2
	for i = 1, #res.index do -- Parallax
		local ch = res.index[i]
		span = span + #ch
	end
	span = span + #res.index

	local snow = graphics.newParticleSystem(f0b.draw.unitSquare, 512)
	snow:setDirection(math.pi/2)
	snow:setSpeed(speed)
	snow:setPosition(-maxPSize, -maxPSize)
	snow:setEmissionArea("uniform", screenW + maxPSize*2, 0)
	snow:setEmissionRate(6)
	snow:setParticleLifetime(span / speed)
	snow:setSizes(4, maxPSize)
	snow:setSizeVariation(1)
	snow:start()
	return snow
end

local fload = f0b.std.dofile
local screen = fload("res/data/screen.lua")

local vn = fload("engine/vn.lua")
local toc = fload("engine/toc.lua")
local stub = fload("engine/stub.lua")

local w, h = love.graphics.getDimensions()
local normalize = f0b.layers.normalize

local vnID = gamestate:add(vn.new(res.index, res.style.vn))
local tocID = gamestate:add(toc.new(res.index, res.style.toc, vnID))
local credID = gamestate:add(stub.new())
local helpID = gamestate:add(stub.new())
gamestate[tocID].tracks = f0b.jukebox.newTracklist(
	{"index", setup={play=false}, source="Pronóstico de Nieve (calliope ver).ogg"}
)
gamestate[tocID].background = normalize({
	{args={"menu/index.png"}, color={1, 1, 1, 1}, scale=1/11},
	{args={
		love.graphics.newText(res.font("dejaVuSans", 11), "recuérdame"),
		0, 0, 0, 1, 1, -w*4/7, -920,
	}, color={.5, .5, .5, 1}, scale=1/11},
	{args={snowParticles(w, h)}, scale=1/24,
		shader=res.shader.circle{resolution={maxPSize, maxPSize}}
	},
})
gamestate[credID].background = normalize({
	{args=screen.credit(res.style.menu, w, h)}
})
gamestate[helpID].background = normalize({
	{args=screen.help(res.style.menu, w, h)}
})

local confBG = normalize({
	{args={"zeh/menu/conf.png"}, shader=res.shader.edgy},
})
local mainBG = normalize({
	{args={"zeh/menu/main.png"}, shader=res.shader.edgy},
	{args=screen.menu(res.style.title, w, h)},
--[[	{args={f0b.draw.unitSquare, 40, 40, 0, 560, 560},
		shader=res.shader.fbmRipple{
			mul={1,1}, add={-.5,-2},rolloff=.8, amplitude=0.2,
			time=res.fun.gfx.shaderTime(6, 0, 15, 0),
			mv=res.fun.gfx.shaderTime(1/16,0),
			alphaMask=2/3,
		},
		color={.8,1,1,1},
	}]]
})

local menu = fload("engine/menu.lua")
local mainEntries = {
	{"Iniciar", "state", tocID},
	{"Configuración", "menu", {
		{"Volumen", false},
		{"Volver", "return"},
		x = -6, y = -6, background = confBG,
	}},
	{"Ayuda", "state", helpID},
	{"Créditos", "state", credID},
	{"Salir", "state", true},
	x = 2, y = 2, background = mainBG,
}

local mainMenu = menu.new(mainEntries, res.style.menu)
mainMenu.tracks = f0b.jukebox.newTracklist({source="Viento.ogg"})
mainMenu.backgroundColor = {0,0,0,1}
gamestate:add(mainMenu, nil, true)
