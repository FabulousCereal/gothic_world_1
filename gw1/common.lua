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
	local style = lib.style.subtitles

	local em = style.em --style.font:getHeight()
	local lh = em * style.font:getLineHeight()
	local screenW, screenH = love.graphics.getDimensions()
	local maxW = screenW - em * style.margin * 2

	local width, lines = getProperWrap(style.font, text, maxW)
	local height = lh * lines
	local x = math.floor(screenW * 0.5 - width * 0.5)
	local y = math.floor(screenH * 0.875 - height * 0.5)

	if not align then
		align = "left"
	end

	if style.backgroundColor then
		local canvas = love.graphics.newCanvas(
			width, height, {format = "rgba4"}
		)
		love.graphics.setCanvas(canvas)
		love.graphics.setColor(style.backgroundColor)
		love.graphics.rectangle("fill", 0, 0, width, height)
		if type(text) == "table" then
			love.graphics.setColor({1,1,1,1})
		else
			love.graphics.setColor(style.color)
		end
		love.graphics.setFont(style.font)
		love.graphics.printf(text, 0, 0, width, align)
		love.graphics.setCanvas()
		return {canvas, x, y}
	else
		local subtitle = love.graphics.newText(style.font)
		subtitle:setf(text, width, align)
		return {subtitle, x, y}
	end
end

return {
	screenCover = {"fill", 0, 0, love.graphics.getDimensions()},

--	title = function(args)
--		local h1font = lib.fonts["vollkorn48"]

	subtitle = genSub,

	vnDateSubs = function(args)
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
		local timeString = string.format("%.2u:%.2u",
			hour, min)
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
