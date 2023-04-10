-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function floorButton(button)
	local floor = math.floor
	f0b.table.map(button.pos, floor)
	f0b.table.map(button.box, floor)
	for k = 2, 3 do
		button.text[k] = floor(button.text[k])
	end
	return button
end

local function setTextStr(button, str, align)
	local text = button.text
	text[1]:setf(str, text.wrap, align)
	text.str = str
	return text[1]:getWidth()
end

local function regen(button, style, x, y, w, textLines, str, align)
	local em, pad, margin, lineHeight = f0b.style.getUnits(style)
	local hbw = style.borderWidth/2

	local pos, box, text = button.pos, button.box, button.text
	local borderMargin = margin + hbw
	if not textLines then
		textLines = 1
	end
	local textH = textLines * lineHeight + pad + hbw*2

	pos[1] = x
	pos[2] = y
	pos[3] = w
	pos[4] = textH + borderMargin*2

	box[1] = borderMargin
	box[2] = borderMargin
	box[3] = w - borderMargin*2
	box[4] = textH
	box[5] = style.borderRadius

	text.wrap = f0b.style.textLimit(style, w)
	text.lines = textLines
	text[1]:setFont(style.font)
	if not str then
		str = text.str
	end
	if not align then
		align = text.align
	end
	setTextStr(button, str, align)
	text[2] = box[1] + hbw + pad
	text[3] = box[2] + hbw + pad/2

	return floorButton(button),
		x + w - borderMargin, y + textH + borderMargin,
		text[1]:getWidth()
end

local function buttonDefault(style)
	return {
		pos = {x, y, w, 0},
		box = {0, 0, 0, 0, 0},
		text = {str = "", wrap = 0, lines = 0, align = "left",
			love.graphics.newText(style.font), 0, 0},
	}
end

return {
	mousemoved = function(button, x, y)
		local pos, box = button.pos, button.box
		x, y = x - pos[1], y - pos[2]
		return f0b.shapes.rectangleTest(box, x, y)
	end,

	setWidth = function(button, style, w)
		local _, pad, margin = f0b.style.getUnits(style)
		w = w + pad*2 + style.borderWidth
		button.box[3] = w
	end,

	setPos = function(button, y, h, rel)
		local pos = button.pos
		if rel == "bottom" then
			y = y + h - pos[4]
		end
		pos[2] = y
	end,

	setText = setTextStr,

	draw = function(button, style)
		local graphics = love.graphics
		graphics.push()

		local pos = button.pos
		graphics.translate(pos[1], pos[2])

		f0b.shapes.bordered(graphics.rectangle, style, unpack(button.box))

		graphics.setColor(type(button.text.str) == "table"
			and {1, 1, 1, 1} or style.color)
		graphics.draw(unpack(button.text))

		graphics.pop()
	end,

	regen = regen,

	default = buttonDefault,

	new = function(style, ...)
		return regen(buttonDefault(style), style, ...)
	end,
}
