return function(font, text, align)
	local graphics = love.graphics

	local w, h = graphics.getDimensions()
	local t = graphics.newText(font)
	if not align then
		align = "left"
	end
	local tW, tH = t:getDimensions(t:addf(text, w, align))
	return {t, w/2 - tW/2, h/2 - tH/2}
end
