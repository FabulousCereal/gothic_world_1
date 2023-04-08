-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function textGen(style, ...)
	local t = love.graphics.newText(style.font)
	t:setf(...)
	return t, style.font:getHeight() * style.padding
end

local function textWrapDims(t, x, y, limit, pad)
	local floor = math.floor
	return floor(x - pad), floor(y - pad/2),
		floor(limit + pad*2), floor(t:getHeight() + 0) -- ???
end

local function textColor(style, invert)
	if invert then
		return style.backgroundColor, style.color
	end
	return style.color, style.backgroundColor
end

local function textDraw(text, x, y, limit, alignment, style, invert)
	local t, pad = textGen(style, text, limit, alignment)
	local color, bgColor = textColor(style, invert)
	local graphics = love.graphics
	local x, y, w, h = textWrapDims(t, x, y, limit, pad)
	graphics.setColor(bgColor)
	graphics.rectangle("fill", x, y, w, h, style.borderRadius)
	graphics.setColor(color)
	graphics.draw(t, x, y)
end

return {
	textCanvas = function(text, limit, alignment, style, invert)
		local t, pad = textGen(style, text, limit, alignment)

		local xOff, yOff, w, h = textWrapDims(t, 0, 0, limit, pad)
		local em = style.font:getHeight()
		local bw = math.floor(style.borderWidth/2 * em)
		xOff = xOff - bw
		yOff = yOff - bw
		w = w + bw*2
		h = h + bw*2

		local color, bgColor = textColor(style, invert)
		local graphics = love.graphics
		local cnv = graphics.newCanvas(w, h)
		graphics.setCanvas(cnv)
		graphics.setColor(bgColor)
		graphics.rectangle("fill", bw, bw, w - bw, h - bw, style.borderRadius)
		graphics.setColor(color)
		graphics.rectangle("line", bw, bw, w - bw, h - bw, style.borderRadius)
		graphics.draw(t, -xOff, -yOff)
		graphics.setCanvas()

		return cnv, xOff, yOff
	end,

	bordered = function(func, style, ...)
		local graphics = love.graphics

		graphics.setColor(style.backgroundColor)
		func("fill", ...)

		if style.borderWidth > 0 then
			graphics.setLineWidth(style.borderWidth)
			graphics.setColor(style.borderColor)
			func("line", ...)
		end
	end,

	line = function(points, pointRadius)
		local graphics = love.graphics
		local circle = graphics.circle
		local lineWidth = graphics.getLineWidth()
		graphics.setLineWidth(lineWidth / 2)
		for i = 1, #points, 2 do
			circle("fill", points[i], points[i+1], pointRadius)
			circle("line", points[i], points[i+1], 1)
--			graphics.draw(elem.circle, points[i], points[i+1], 0,
--				pointRadius, pointRadius)
		end
		graphics.setLineWidth(lineWidth)
		return graphics.line(points)
	end,

	text = textDraw,

	dropShadow = function(drawArgs, xOff, yOff, scaleX, scaleY)
		local graphics = love.graphics
		local r, g, b, a = graphics.getColor()
		graphics.setColor(0, 0, 0, a/2)

		local shadow = {drawArgs[1], 0, 0, 0, 1, 1, 0, 0, 0, 0}
		for i = 2, #shadow do
			shadow[i] = drawArgs[i] or shadow[i]
		end

		shadow[2] = shadow[2] + xOff
		shadow[3] = shadow[3] + yOff
		shadow[5] = shadow[5] * (scaleX or 1)
		shadow[6] = shadow[6] * (scaleY or scaleX or 1)

		graphics.draw(unpack(shadow))
		graphics.setColor(r, g, b, a)
		graphics.draw(unpack(drawArgs))
	end
}
