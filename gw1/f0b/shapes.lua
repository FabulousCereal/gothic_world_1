--local elem = require("f0b.elem")

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

		local em = style.font:getHeight()
		local padding = em * style.padding
		local _, wrappedText = style.font:getWrap(text, limit)
		local height = em * style.lineHeight * #wrappedText

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

	dropShadow = function(xOff, yOff, drawable, ...)
		local graphics = love.graphics
		local color = {graphics.getColor()}
		graphics.setColor(0, 0, 0, color[4]/2)

		local defaults = {0, 0, 0, 1, 1, 0, 0, 0, 0}
		local args = {...}
		for i = 1, #defaults do
			if not args[i] then
				args[i] = defaults[i]
			end
		end

		local scaleBlur = .01
		graphics.draw(drawable, args[1] + xOff, args[2] + yOff,
			args[3], args[4] + scaleBlur, args[5] + scaleBlur,
			unpack(args, 6))
		graphics.setColor(color)
		graphics.draw(drawable, unpack(args))
	end
}
