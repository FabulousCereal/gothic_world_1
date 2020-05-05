local function creditScreen(style)
	local credit = {style.disabled.color,
		"Basada en una historia original\npor el ",
		style.color, "G",
		style.disabled.color, "rupo\n\t\t\t\t",
		style.color, "W",
		style.disabled.color, "arominutes."}

	local text = love.graphics.newText(style.font, credit)

	local w, h = love.graphics.getDimensions()
	local textW, textH = text:getDimensions()
	return {text,
		math.floor(w / 2 - textW / 2),
		math.floor(h / 2 - textH / 2)}
end

return function(gs)
	local vn = require("engine.vn")
	local toc = require("engine.toc")
	local menu = require("engine.menu")
	local stub = require("engine.stub")

	local mStyle = lib.style.menu
	local em = mStyle.font:getHeight()
	local w, h = love.graphics.getDimensions()

	local vnID = gamestate.add(gs, vn.new(lib.style.vnMaria, 4))
	local tocID = gamestate.add(gs, toc.new(lib.index, mStyle, gs[vnID]))
	local credID = gamestate.add(gs, stub.new())

	local confEntries = {
		{name="Resolución", disabled=true},
		{name="Música", disabled=true},
		{name="Sonido", disabled=true},
		{name="Volver", to=true}
	}
	local cmID = gamestate.add(gs, menu.new(confEntries, mStyle,
		w - em * 9, h - em * 9))

	local mainEntries = {
		{name="Comenzar", to=tocID},
		{name="Configuración", to=cmID},
		{name="Créditos", to=credID},
		{name="Salir", to=true}
	}
	local mmID = gamestate.add(gs, menu.new(mainEntries, mStyle,
		em * 3, em * 3), nil, true)


	gs[credID].background = {
		{args=creditScreen(mStyle), color={1,1,1,1}}
	}
	gs[cmID].background = {
		{exec=love.graphics.circle, args={"line", 160, 160, 20},
			color={1,1,1,1}}
	}
	gs[mmID].background = {
--		{args=common.screenCover(.6), color={0,0,0,.25}},
		{args={f0b.elem.circle, 480, 360, 0, 5}, color={1,1,1,1}}
--		{exec=love.graphics.circle, args={"fill", 480, 360, 5},
--			color={1,1,1,1}}
	}
--	gs[mmID].backgroundColor = {1, 1, 1, 1}

	return gs
end
