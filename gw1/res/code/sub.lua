local function getProperWrap(font, text, maxWidth)
	if type(text) == "table" then -- Colored text
		local t = {}
		for i = 2, #text, 2 do
			t[i / 2] = text[i]
		end
		text = table.concat(t)
	end
	local width, wrappedtext = font:getWrap(text, maxWidth)
	return width, #wrappedtext
end

local function genSub(text, align)
	local style = res.style.subtitles
	local graphics = love.graphics

	local em = style.font:getHeight()
	local lh = em * style.lineHeight
	local padding = em * style.padding
	local screenW, screenH = graphics.getDimensions()
	local maxW = screenW - (em * style.margin + padding) * 2

	local widthPad, lines = getProperWrap(style.font, text, maxW)
	local width = widthPad + padding * 2
	local height = lh * lines + padding
	local x = math.floor(screenW * 0.5 - width * 0.5)
	local y = math.floor(screenH * 7/8 - height * 0.5)

	if not align then
		align = "left"
	end

	if style.backgroundColor and style.backgroundColor[4] > 0 then
		width, height = math.floor(width), math.floor(height)
		local canvas = graphics.newCanvas(width, height,
			{format = "rgba4"})
		graphics.setCanvas(canvas)
		graphics.clear(style.backgroundColor)
		if type(text) == "table" then
			graphics.setColor(1, 1, 1, 1)
		else
			graphics.setColor(style.color)
		end
		graphics.setFont(style.font)
		graphics.printf(text, math.floor(padding),
			math.floor(padding / 2), widthPad, align)
		graphics.setCanvas()
		return {canvas, x, y}
	else
		local subtitle = graphics.newText(style.font)
		subtitle:addf(text, math.floor(padding),
			math.floor(padding / 2), widthPad, align)
		return {subtitle, x, y}
	end
end

return {
	subtitle = genSub,

	date = function(args)
		local months = {"Enero", "Febrero", "Marzo", "Abril",
			"Mayo", "Junio", "Julio", "Agosto",
			"Septiembre", "Octubre", "Noviembre", "Diciembre"}
		local year, month, day, hour, min = unpack(args)
		local idx = args.idx
		local wait
		if args.wait then
			wait = {"wait", unpack(args.wait)}
		else
			wait = {"nop"}
		end

		local dateString = string.format("%u/%s/%u",
			day, months[month], year)
		local timeString = string.format("%.2u:%.2u", hour, min)
		return {
			{"bg", "add", idx, args=genSub(dateString, "center")},
			wait,
			false,
			{"bg", "mod", idx, args=genSub(timeString, "center")},
			false,
			{"bg", "rm", idx},
		}
	end,
}
