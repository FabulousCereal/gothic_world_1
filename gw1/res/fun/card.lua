-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

return {
	subtitle = function(text, align)
		local button = f0b.button
		local style = res.style.subtitles
		local graphics = love.graphics

		local sW, sH = graphics.getDimensions()
		local b = button.stub(style)
		button.setTextAdapt(b, text, sW, align)
		button.regen(b)

		local w, h = button.getBoxDims(b)
		local cnv = graphics.newCanvas(w, h)
		local prev = graphics.getCanvas()
		graphics.setCanvas(cnv)
		button.drawBox(b)
		graphics.setCanvas(prev)
		return {cnv, f0b.math.centerRectAt(sW * .5, sH * 7/8, w, h)}
	end,

	card = function(fontName, fontSize, text, align)
		local graphics = love.graphics

		local sW, sH = graphics.getDimensions()
		local font = res.font(fontName, fontSize)
		local t = graphics.newText(font)
		if not align then
			align = "left"
		end
		local w, h = t:getDimensions(t:addf(text, sW, align))
		t:setf(text, w, align)
		return {t, f0b.math.centerRect(sW, sH, w, h)}
	end,
}
