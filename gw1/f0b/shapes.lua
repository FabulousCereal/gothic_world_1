-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

return {
	bordered = function(func, style, ...)
		local graphics = love.graphics

		graphics.setColor(style.backgroundColor)
		func("fill", ...)

		graphics.setLineWidth(style.borderWidth)
		graphics.setColor(style.borderColor)
		func("line", ...)
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

	text = function(text, x, y, limit, alignment, style, invert)
		local color, bgColor = style.color, style.backgroundColor
		if invert then
			color, bgColor = bgColor, color
		end

		local _, wrappedText = style.font:getWrap(text, limit)
		local em = style.font:getHeight()
		local height = em * style.lineHeight * #wrappedText
		local padding = em * style.padding

		local graphics = love.graphics
		graphics.setColor(bgColor)
		graphics.rectangle("fill",
			x - padding,
			y - padding / 2,
			limit + padding * 2,
			height + padding)
		graphics.setColor(color)
		graphics.setFont(style.font)
		graphics.printf(text, x, y, limit, alignment)
	end,

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
