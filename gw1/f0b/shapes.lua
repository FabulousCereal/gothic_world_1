return {
	draw = function (properties, style, func)
		love.graphics.setColor(style.backgroundColor)
		func("fill", unpack(properties))
		if style.borderWidth > 0 then
			love.graphics.setLineWidth(style.borderWidth)
			love.graphics.setColor(style.borderColor)
			func("line", unpack(properties))
		end
	end,
}
