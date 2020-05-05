return {
	titleCard = function(style, text)
		local graphics = love.graphics

		local w, h = graphics.getDimensions()
		local font = lib.font("takaoMincho", 72)
		local t = graphics.newText(font)
		local tW, tH = t:getDimensions(t:add({style.color, text}))
		return {t, w/2 - tW/2, h/2 - tH/2}
	end,
}
