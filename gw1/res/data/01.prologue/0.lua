local function eauDeParfum()
	local img = res.img("gothic_world_120px.png")
	local imgW, imgH = img:getDimensions()
	local imgEm = 60
	local imgX = math.floor(imgEm / 4)
	local imgY = math.floor(imgEm / 4)

	local font = res.fonts("dejaVuSans", math.floor(imgEm / 5))
	local graphics = love.graphics

	local canvasW = imgW + imgX*2
	local canvasH = imgH + imgY*3
	local canvas = graphics.newCanvas(canvasW, canvasH)

	graphics.setCanvas(canvas)
	graphics.setColor(1,1,1,1)
	graphics.setBlendMode("alpha", "premultiplied")
	graphics.setLineWidth(2)

	graphics.draw(img, imgX, imgY)

	local frameH = math.floor(imgH + imgEm / 2)
	
	graphics.rectangle("line", 1, 1, canvasW - 2, frameH - 1)

	graphics.setFont(font)
	graphics.printf("eau de parfum", 0,
		math.ceil(canvasH - font:getHeight()), canvasW, "center")

	graphics.setCanvas()
	graphics.setBlendMode("alpha", "alphamultiply")

	local w, h = graphics.getDimensions()
	return {{"bg", "add",
		args={canvas,
			math.floor(w / 2 - canvasW / 2),
			math.floor(h / 2 - canvasH / 2)},
		tween={"fadein", 3},
	}}
end

local function fadeShow(...)
	local time = 3
	local args = select(select("#", ...), ...)
	return {
		{"bg", "mod", tween={"delay", time, true}},
		{"bg", "add", args=args, tween={"fadein", time}},
	}
end

return {
	{"name", "María"},
	{"style", "vnMaria"},
	{"bgm", "set", "intro", 0.1, source="newgw2-alt.ogg",
		fade={"fadeto", 0.5, 2}},
	{"wait", 2},
	[[Tuve un sueño antes del desastre.]],

	{"bg", "add", args={"maria/intro1.png", -80}, tween={"fadein", 2}},
	[[Soñé que caía sobre un inmenso océano sin costas.]],

	{"macro", fadeShow, {"maria/intro2.png", 0, 0, 0, .8}},
	[[Un mar negro bajo una bóveda de nubes y estrellas blancas. Una
tiniebla que abarcaba mas allá de la Tierra.]],

--	{"macro", fadeShow, {"maria/intro3.png", 0, 0, 0, .8}},
	[[El viento era tan helado y punzante que parecía chillar.]],

	[[En eso...]],

	{"macro", fadeShow, {"maria/intro4.png", 0, 0, 0, .8}},
	[[Una pequeña paloma revoloteó junto a mi.]],

--	{"macro", fadeShow, {"maria/intro5.png", 0, 0, 0, .8}},
	[[La paloma trataba de tomarme con sus patas. Intentaba detener mi
caída.]],

	{"macro", fadeShow,
		{"maria/intro6.png",
			300, 200, -math.pi/2, 1, 1, 400, 300
		}
	},
	{"wait", 1},
	[["Gracias, pero no puedes..."]],

	{"bg", "mod", tween={"delay", 3, true}},
	{"bg", "add", color={.15, .2, .2, 0}, tween={"fadein", 3},
		args=f0b.elem.screenFill},
--	{"bg", "add", args={"maria/intro7.png", 0, 0, 0, .8},
--		color={1, 1, 1, 0},
--		tween={"delay", 1.5, "fadein", 3}},

	{"bgm", "set", "waves", 0, source="olas.ogg",
		fade={"fadeto", 1, 20}},
	[[Pasamos por una nube, y cuando salimos cubiertas de escarcha blanca,
encontré a la paloma acobijada a mi pecho.]],

	[[Con mis manos entumecidas la abracé, mientras el olor y el ruido de
las olas nos envolvían.]],

	{"macro", fadeShow, {"sea2.png", 0, 0, 0, .8}},
	{"wait", 1, true},
	[["Gracias..."]],

	{"macro", eauDeParfum},
--	{"bgm", "mod", "intro", fade={"fadeout", 4, true}},
--	{"bgm", "mod", "waves", fade={"fadeout", 4, true}},
	{"bgm", "modall", fade={"fadeout", 4, true}},
	{"wait", 4, true},
	{"bg", "mod", -1, tween={"fadeout", 2, true}},
	{"bg", "mod", tween={"fadeout", 2, true}},
	{"wait", 1.9, true},
}
