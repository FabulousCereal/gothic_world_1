-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local minuteLen = 5/6
local hourLen = 1/3
local backLen = 1/9

local function lineTurn(radius, turn, len)
	local floor = math.floor
	local cos = math.cos(turn)
	local sin = math.sin(turn)
	local bLen = radius * -backLen
	return {
		floor(radius + cos * bLen),
		floor(radius + sin * bLen),
		floor(radius + cos * len),
		floor(radius + sin * len)
	}
end

local function lineHands(radius, hourTurn, minuteTurn)
	return lineTurn(radius, hourTurn, hourLen * radius),
		lineTurn(radius, minuteTurn, minuteLen * radius)
end

local clockHandFun = {
	line = function(style, radius, hourTurn, minuteTurn)
		local hour, minute = lineHands(radius, hourTurn, minuteTurn)
		local bw = style.borderWidth
		love.graphics.setColor(style.borderColor)
		f0b.draw.line(hour, bw/2)
		f0b.draw.line(minute, bw*1/3)
	end,

	circle = function(style, radius, hourTurn, minuteTurn)
		local hands = {lineHands(radius, hourTurn, minuteTurn)}
		local bw = style.borderWidth / 8
		local size = style.borderWidth * 4 / 3
		for _, hand in pairs(hands) do
			f0b.draw.line(hand, bw)
			for i = 1, #hand, 2 do
				local x = hand[i] - size/2
				local y = hand[i+1] - size/2
				f0b.draw.sdf(res.shader.circle, x, y, 0,
					size, size)
			end
		end
	end,

	triangle = function(_, radius, hourTurn, minuteTurn)
		local ctx = res.shader.triangle
		local rb = radius * backLen / 2
		f0b.draw.sdf(ctx, radius, radius, hourTurn,
			hourLen*radius, rb, backLen / (hourLen*2), 1/2)
		f0b.draw.sdf(ctx, radius, radius, minuteTurn,
			minuteLen*radius, rb, backLen / (minuteLen*2), 1/2)
	end,
}

local printNumeralFun = {
	sextant = function(font, n, x, y)
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
		local num = r[n]
		local width = font:getWidth(num)
		love.graphics.print(num, math.floor(x - width / 2), y)
	end,

	roman = function(font, n, x, y)
		-- There is an Unicode plane for this, but I really want that IIII
		local r = {"I", "II", "III", "IIII", "V", "VI", "VII", "VIII",
			"IX", "X", "XI", "XII"}
		local num = r[n]

		local compact = .5
		local chars = {}
		local offset = 0
		local ins = table.insert
		for i = 1, #num do
			local c = string.sub(num, i, i)
			ins(chars, c)
			ins(chars, offset)
			local w = font:getWidth(c)
			offset = offset + w * ((i == #num) and 1 or compact)
		end
		local start = x - offset / 2

		local gPrint = love.graphics.print
		for i = 1, #chars, 2 do
			gPrint(chars[i], math.floor(start + chars[i+1]), y)
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
		f0b.draw.sdf(f0b.style.setupShader(res.shader.circle, style),
			0, 0, 0, dims, dims)

		local tau = math.pi*2
		local radius = floor(dims / 2)
		local numDistance = radius * 5/6 - style.borderWidth / 2
		local numTurn = tau / 12
		local em = style.font:getHeight()

		local printNumeral = printNumeralFun[numerals or "arabic"]
		graphics.setFont(style.font)
		graphics.setColor(style.color)
		for i = 1, 12 do
			local r = numTurn * (i - 3)
			local x = numDistance * math.cos(r)
			local y = numDistance * math.sin(r)
			printNumeral(style.font, i, x + radius,
				floor(y + radius - em / 2))
		end

		local brandFont = res.font(style.fontFamily, floor(em * 2/3))
		graphics.setFont(brandFont)
		graphics.print(brand,
			floor(radius - brandFont:getWidth(brand) / 2),
			floor(radius + brandFont:getHeight() * 5/3))

		local hourTurn = (numTurn * hour + numTurn / 60 * minute)
			- tau/4
		local minuteTurn = tau / 60 * minute - tau/4
		clockHandFun[hands or "line"](style, radius, hourTurn, minuteTurn)

		graphics.setCanvas(prevCanvas)
		return clockFace, f0b.math.centerRectAt(w * .5, h * 3/7, dims, dims)
	end,

	alarm = function(style, hour, minute)
		local text = love.graphics.newText(style.font)
		local tW, tH = text:getDimensions(
			text:add({style.backgroundColor, "88:88"})
		)
		text:add({style.color, string.format("%u:%u", hour, minute)})

		local w, h = love.graphics.getDimensions()
		return text, f0b.math.centerRect(w, h, tW, tH)
	end,
}
