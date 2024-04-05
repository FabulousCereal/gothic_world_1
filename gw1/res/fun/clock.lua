-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function lineTurn(radius, turn, len)
	local floor = math.floor
	local cos = math.cos(turn)
	local sin = math.sin(turn)
	local bLen = radius * -backLen
	return {
		floor(radius + cos(turn) * -radius / 9),
		floor(radius + sin(turn) * -radius / 9),
		floor(radius + cos(turn) * len),
		floor(radius + sin(turn) * len)
	}
end

local function lineHands(radius, hourTurn, minuteTurn)
	return lineTurn(radius, hourTurn, radius / 3),
		lineTurn(radius, minuteTurn, radius * 5/6)
end

local clockHandFunction = {
	line = function(style, radius, hourTurn, minuteTurn)
		hour, minute = lineHands(radius, hourTurn, minuteTurn)
		local bw = style.borderWidth
		f0b.draw.line(hour, math.floor(bw / 4))
		f0b.draw.line(minute, math.floor(bw / 6))
	end,

	circle = function(style, radius, hourTurn, minuteTurn)
		hour, minute = lineHands(radius, hourTurn, minuteTurn)
		local bw = style.borderWidth
		local lw = math.floor(bw/8)
		f0b.draw.line(hour, math.floor(bw * 2/3), lw)
		f0b.draw.line(minute, math.floor(bw * 2/3), lw)
	end,

	triangle = function(style, radius, hourTurn, minuteTurn)
		local graphics = love.graphics
		local bw = math.floor(style.borderWidth/2)
		local points = {-bw, -bw, -bw, bw, math.floor(radius/3), 0}
		graphics.setLineWidth(1)
		graphics.translate(radius, radius)

		graphics.rotate(hourTurn)
		graphics.polygon("fill", points)
		graphics.polygon("line", points)

		points[5] = math.floor(radius * 5/6 - style.borderWidth)
		graphics.rotate(minuteTurn)
		graphics.polygon("fill", points)
		graphics.polygon("line", points)

		graphics.origin()
	end,
}

local printNumeralFunction = {
	sextant = function(font, num, x, trueY)
--		local r = {"🬀", "🬁", "🬃", "🬇", "🬏", "🬞",
--			"🬟", "🬠", "🬢", "🬦", "🬭", "🬰"}
--		local r = {"🬁", "🬈", "🬗", "🬇", "🬖", "🬋",
--			"🬞", "🬢", "🬤", "🬃", "🬅", "🬰"}
		local r = {
			"🬏", "🬅", "🬗",
			"🬃", "🬈", "🬋",
			"🬁", "🬖", "🬤",
			"🬇", "🬢", "🬰",
		}
		num = r[num]
		local width = font:getWidth(num)
		love.graphics.print(num, math.floor(x - width / 2), trueY)
	end,

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

		local w, h = graphics.getDimensions()
		local dims = floor(math.max(w, h) * 2/3)
		local clockFace = graphics.newCanvas(dims, dims)
		local prevCanvas = graphics.getCanvas()
		graphics.setCanvas(clockFace)

		graphics.setColor(1,1,1,1)
		f0b.draw.shader(f0b.style.setupShader(res.shader.circle, style),
			{0, 0, dims, dims})

		local tau = f0b.math.tau
		local radius = floor(dims / 2)
		local numDistance = radius * 5/6 - style.borderWidth / 2
		local numTurn = tau / 12
		local em = style.font:getHeight()

		local printNumeral = printNumeralFunction[numerals or "arabic"]
		graphics.setFont(style.font)
		graphics.setColor(style.color)
		for i = 1, 12 do
			local r = numTurn * (i - 3)
			local x = numDistance * math.cos(r)
			local y = numDistance * math.sin(r)
			printNumeral(style.font, i, x + radius,
				floor(y + radius - em / 2))
		end

		local hourTurn = (numTurn * hour + numTurn / 60 * minute)
			- tau/4
		local minuteTurn = tau / 60 * minute - tau/4
		clockHandFunction[hands or "line"](style, radius, hourTurn, minuteTurn)

		local brandFont = res.font(style.fontFamily, floor(em * 2/3))
		local brandEm = brandFont:getHeight()
		graphics.setFont(brandFont)
		graphics.print(brand,
			floor(radius - brandFont:getWidth(brand) / 2),
			floor(radius + brandFont:getHeight() * 5/3))
		graphics.setCanvas(prevCanvas)
		return clockFace, floor(w / 2 - dims / 2),
			floor(h * 3/7 - dims / 2)
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
