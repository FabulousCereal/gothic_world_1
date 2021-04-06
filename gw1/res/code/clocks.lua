local clockHandFunction = {
	line = function(style, radius, hourTurn, minuteTurn)
		local floor, cos, sin = math.floor, math.cos, math.sin
		love.graphics.setLineWidth(style.borderWidth / 2)
		f0b.shapes.line({
			radius + cos(hourTurn) * -radius / 9,
			radius + sin(hourTurn) * -radius / 9,
			radius + cos(hourTurn) * radius / 3,
			radius + sin(hourTurn) * radius / 3},
			style.borderWidth / 4)

		love.graphics.setLineWidth(style.borderWidth / 3)
		f0b.shapes.line({
			radius + cos(minuteTurn) * -radius / 9,
			radius + sin(minuteTurn) * -radius / 9,
			radius + cos(minuteTurn) * radius * 5/6,
			radius + sin(minuteTurn) * radius * 5/6},
			style.borderWidth / 6)
	end,

	triangle = function(style, radius, hourTurn, minuteTurn)
		local graphics = love.graphics
		local bw = style.borderWidth
		local points = {-bw, -bw, -bw, bw, radius/3, 0}
		graphics.setLineWidth(1)
		graphics.translate(radius, radius)

		graphics.rotate(hourTurn)
		graphics.polygon("fill", points)
		graphics.polygon("line", points)

		points[5] = radius * 5/6 - style.borderWidth
		graphics.rotate(minuteTurn)
		graphics.polygon("fill", points)
		graphics.polygon("line", points)

		graphics.origin()
	end,
}

local printNumeralFunction = {
	roman = function(font, num, x, trueY)
		-- There is an Unicode plane for this, but I really want that IIII
		local r = {"I", "II", "III", "IIII", "V", "VI", "VII", "VIII",
			"IX", "X", "XI", "XII"}
		local num = r[num]

		local letterSpacing = .5
		local chars = {}
		local offset = 0
		for i = 1, #num do
			local c = string.sub(num, i, i)
			chars[#chars+1] = c
			chars[#chars+1] = offset
			if i == #num then
				offset = offset + font:getWidth(c)
			else
				offset = offset
					+ font:getWidth(c) * letterSpacing
			end
		end
		local start = x - offset / 2

		local gPrint = love.graphics.print
		for i = 1, #chars, 2 do
			gPrint(chars[i], math.floor(start + chars[i+1]), trueY)
		end
	end,

--	cyrillic = function(font, num, x, trueY)
--		local c = {"А", "В", "Г", "Д", "Е", "Ѕ",
--			"З", "И", "Ѳ", "АІ", "ВІ"}
--	end,

	arabic = function(font, num, x, trueY)
		num = tostring(num)
		local width = font:getWidth(num)
		return love.graphics.print(num, math.floor(x - width / 2),
			trueY)
	end,
}

return {
	wall = function(style, hour, minute, brand, numerals, hands)
		local graphics = love.graphics

		local w, h = graphics.getDimensions()
		local dims = math.floor(math.max(w, h) * 2/3)
		local clockFace = graphics.newCanvas(dims, dims)
		graphics.setCanvas(clockFace)

		local radius = math.floor(dims / 2)
		f0b.shapes.bordered(graphics.circle, style, radius, radius,
			radius - style.borderWidth / 2)

		local numDistance = radius * 5/6 - style.borderWidth / 2
		local numTurn = math.pi * 2 / 12
		local em = style.font:getHeight()

		if not numerals then
			numerals = "arabic"
		end
		local printNumeral = printNumeralFunction[numerals]
		graphics.setFont(style.font)
		graphics.setColor(style.color)
		for i = 1, 12 do
			local r = numTurn * (i - 3)
			local x = numDistance * math.cos(r)
			local y = numDistance * math.sin(r)
			printNumeral(style.font, i, x + radius,
				math.floor(y + radius - em / 2))
		end

		if not hands then
			hands = "line"
		end
		local hourTurn = (numTurn * hour + numTurn / 60 * minute)
			- math.pi/2
		local minuteTurn = math.pi * 2 / 60 * minute - math.pi/2
		clockHandFunction[hands](style, radius, hourTurn, minuteTurn)

		local brandFont = res.font(style.fontFamily, math.floor(em * 2/3))
		local brandEm = brandFont:getHeight()
		graphics.setFont(brandFont)
		graphics.print(brand,
			math.floor(radius - brandFont:getWidth(brand) / 2),
			math.floor(radius + brandFont:getHeight() * 5/3))
		graphics.setCanvas()
		return clockFace, math.floor(w / 2 - dims / 2),
			math.floor(h / 2 - dims / 2)
	end,

	alarm = function(style, hour, minute)
		local text = love.graphics.newText(style.font)
		local twidth, theight = text:getDimensions(
			text:add({style.backgroundColor, "88:88"})
		)
		text:add({style.color, string.format("%u:%u", hour, minute)})

		local w, h = love.graphics.getDimensions()
		return text, w / 2 - twidth / 2, h / 2 - theight / 2
	end,
}
