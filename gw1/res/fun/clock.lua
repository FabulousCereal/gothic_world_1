local clockHandFunction = {
	line = function(style, radius, hourTurn, minuteTurn)
		local cos, sin = math.cos, math.sin
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

		local compact = .5
		local chars = {}
		local offset = 0
		for i = 1, #num do
			local c = string.sub(num, i, i)
			local n = #chars
			chars[n+1] = c
			chars[n+2] = offset
			local w = font:getWidth(c)
			offset = offset + w * ((i == #num) and 1 or compact)
		end
		local start = x - offset / 2

		local gPrint = love.graphics.print
		for i = 1, #chars, 2 do
			gPrint(chars[i], math.floor(start + chars[i+1]), trueY)
		end
	end,

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
		local floor = math.floor
		local tau = f0b.math.tau

		local w, h = graphics.getDimensions()
		local dims = floor(math.max(w, h) * 2/3)
		local clockFace = graphics.newCanvas(dims, dims)
		graphics.setCanvas(clockFace)

		local radius = floor(dims / 2)
		f0b.shapes.bordered(graphics.circle, style, radius, radius,
			radius - style.borderWidth / 2)

		local numDistance = radius * 5/6 - style.borderWidth / 2
		local numTurn = tau / 12
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
				floor(y + radius - em / 2))
		end

		if not hands then
			hands = "line"
		end
		local hourTurn = (numTurn * hour + numTurn / 60 * minute)
			- tau/4
		local minuteTurn = tau / 60 * minute - tau/4
		clockHandFunction[hands](style, radius, hourTurn, minuteTurn)

		local brandFont = res.fonts(style.fontFamily, floor(em * 2/3))
		local brandEm = brandFont:getHeight()
		graphics.setFont(brandFont)
		graphics.print(brand,
			floor(radius - brandFont:getWidth(brand) / 2),
			floor(radius + brandFont:getHeight() * 5/3))
		graphics.setCanvas()
		return clockFace, floor(w / 2 - dims / 2),
			floor(h / 2 - dims / 2)
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
