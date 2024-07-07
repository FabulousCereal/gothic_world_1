local function falling(ctx)
	return {0, love.timer.getTime()*ctx.mul[2]*2}
end

local function fallingMul(_, _, dyn)
	local mul
	if dyn then
		local now = love.timer.getTime()
		mul = function(_)
			local m = (love.timer.getTime() - now)-96
			local t = math.pow(.99, m)
			return {t,t}
		end
	else
		local m = 2.5
		mul = {m,m}
	end
	return {
		{"bg", "add",
			color={.2, .4, .4, 0}, fade={"fadein", 3},
			draw=f0b.draw.screenFill,
			shader=res.shader.fbmWarp{
				mul=mul, add={-.5,-.5},
				rolloff=.707, amplitude=0.3,
				mv=res.fun.gfx.shaderTime(1/32),
				alphaMask=.5,
			},
		},
	}
end

local function eauDeParfum()
	local img = res.img("gothic_world_120px.png")
	local imgW, imgH = img:getDimensions()
	local imgEm = 60
	local imgX = math.floor(imgEm / 4)
	local imgY = math.floor(imgEm / 4)

	local font = res.font("dejaVuSans", math.floor(imgEm / 5))
	local graphics = love.graphics

	local eauHeight = font:getHeight()
	local eauPos = imgH + imgY*2 + eauHeight/2

	local canvasW = imgW + imgX*2
	local canvasH = eauPos + eauHeight
	local canvas = graphics.newCanvas(canvasW, canvasH)

	graphics.setCanvas(canvas)
	graphics.setColor(1,1,1,1)
	graphics.setBlendMode("alpha", "premultiplied")
	graphics.setLineWidth(2)

	graphics.draw(img, imgX, imgY)

	local frameH = math.floor(imgH + imgEm / 2)

	graphics.rectangle("line", 1, 1, canvasW - 2, frameH - 1)

	graphics.setFont(font)
	graphics.printf("eau de parfum", 0, eauPos, canvasW, "center")

	graphics.setCanvas()
	graphics.setBlendMode("alpha", "alphamultiply")

	local w, h = graphics.getDimensions()
	return {{"bg", "add",
		args={canvas, f0b.math.centerRect(w, h, canvasW, canvasH)},
		fade={"fadein", 3},
	}}
end

local function fadeSwap(_, _, args)
	local time = 3
	return {
		{"bg", "fade", {"delay", time, true}},
		{"bg", "add", args=args, fade={"fadein", time}},
	}
end

return {
	{"name", "María"},
	{"style", "vnMaria"},
	{"bgm", "set", "intro", .1, source="newgw2-alt.ogg",
		fade={"fadeto", 0.5, 2}},

	{"wait", 2},
	[[Tuve un sueño antes del desastre.]],

	{"bg", "add", args={"maria/intro1.png", -80}, fade={"fadein", 2}},
	[[Soñé que caía sobre un inmenso océano sin costas.]],

	{"macro", fadeSwap, {"maria/intro2.png", 0, 0, 0, .8}},
	[[Un mar negro bajo una bóveda de nubes y estrellas. Una
tiniebla que abarcaba mas allá de la Tierra.]],

--	{"macro", fadeSwap, {"maria/intro3.png", 0, 0, 0, .8}},
	[[El viento helado parecía gritar en mis oídos. Era tan punzante que
pensé que me arrancaría la piel.]],

	[[En eso...]],

	{"macro", fadeSwap, {"maria/intro4.png", 0, 0, 0, .8}},
	[[Una pequeña paloma revoloteó junto a mi.]],

--	{"macro", fadeSwap, {"maria/intro5.png", 0, 0, 0, .8}},
	[[La paloma trataba de tomarme con sus patas. Intentaba detener mi
caída.]],

	{"macro", fadeSwap,
		{"maria/intro6.png",
			300, 200, -math.pi/2, 1, 1, 400, 300
		}
	},
	{"wait", 1},
	[["Gracias, pero no puedes..."]],

	{"bg", "fade", {"delay", 3, true}},
--	{"bg", "add", args={"maria/intro7.png", 0, 0, 0, .8},
--		color={1, 1, 1, 0},
--		fade={"delay", 1.5, "fadein", 3}},

	{"bg", "add", color={.15, .3, .3, 0}, fade={"fadein", 3},
		draw=f0b.draw.screenFill,
		shader=res.shader.fbm{
			mul={2,2}, add=falling,
			amplitude=.5
		}
	},
	{"bgm", "set", "waves", 0, source="olas.ogg",
		fade={"fadeto", 1, 20}},
	[[Pasamos por una nube, y cuando salimos cubiertas de escarcha blanca,
encontré a la paloma acobijada a mi pecho.]],

	{"bg", "fade", {"fadeout", 3}},
	[[Con mis manos entumecidas la abracé, mientras el olor y el ruido de
las olas nos envolvían.]],

	{"macro", fallingMul, false},
	{"wait", 1, true},
	[["Gracias..."]],

	{"macro", eauDeParfum},
	{"bgm", "modall", fade={"fadeout", 4, true}},
	{"wait", 4, true},
	{"bg", "fade", -1, {"fadeout", 2, true}},
	{"bg", "fade", {"fadeout", 2, true}},
	{"wait", 1.9, true},
}
