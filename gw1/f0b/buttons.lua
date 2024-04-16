-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function renderText(button)
	local text = button.text
	text[1]:setf(text.str, text.limit, text.align or button.style.textAlign)
	return text[1]:getWidth()
end

local function buttonWidth(button)
	return button.pos[3]
end

local function buttonHeight(button, lineHeight, pad, bw, margin)
	local boxH = button.text.lines * lineHeight + pad + bw*2
	return boxH + margin*2, boxH
end

local function regen(button)
	local style = button.style
	local _, pad, margin, lineHeight, bw = f0b.style.getUnits(style)
	local pos, box, text = button.pos, button.box, button.text
	local buttonH, boxH = buttonHeight(button, lineHeight, pad, bw, margin)
	local w = buttonWidth(button)
	pos[4] = buttonH

	box[1] = margin
	box[2] = margin
	box[3] = w - margin * 2
	box[4] = boxH

	local textPad = (pad+bw+margin)*2
	text[1]:setFont(style.font)
	text[2] = math.floor(box[1] + bw + pad)
	text[3] = math.floor(box[2] + bw + pad/2)
	text.limit = w - textPad
	return button, renderText(button) + textPad, boxH+margin
end

local function setStyle(button, style)
	button.style = style
end

local function setWidth(button, w)
	button.pos[3] = w
end

local function setLines(button, l)
	button.text.lines = l
end

local function setDims(button, w, lines)
	setWidth(button, w)
	setLines(button, lines)
	return w, lines
end

local function setPos(button, x, y)
	button.pos[1] = x
	button.pos[2] = y
end

local function draw(button, style, x, y)
	if not style then
		style = button.style
	end
	local graphics = love.graphics
	graphics.push()

	graphics.translate(button.pos[1] - (x or 0), button.pos[2] - (y or 0))

	graphics.setColor(1, 1, 1, 1)
	f0b.draw.rect(f0b.style.getShader(style), unpack(button.box))

	graphics.setColor(type(button.text.str) == "table"
		and {1, 1, 1, 1} or style.color)
	graphics.draw(unpack(button.text))

	graphics.pop()
end

local function buttonStub(style)
	return {
		pos = {0, 0, 0, 0},
		box = {0, 0, 0, 0},
		text = {str = "", limit = 0, lines = 0,
			love.graphics.newText(style.font), 0, 0},
		style = style,
	}
end

return {
	mousemoved = function(button, x, y)
		return f0b.math.rectangleTest(button.box,
			x - button.pos[1], y - button.pos[2])
	end,

	getBoxDims = function(button)
		return unpack(button.box, 3)
	end,

	getHeight = function(button)
		return button.pos[4]
	end,

	setWidth = setWidth,

	setStyle = setStyle,

	setDims = setDims,

	setPos = setPos,

	setText = function(button, str, limit, align)
		button.text.str = str
		if limit then
			setWidth(button, limit)
		end
		if align ~= nil then
			button.text.align = align
		end
	end,

	setTextInPlace = function(button, str)
		button.text.str = str
		renderText(button)
	end,

	setTextAdapt = function(button, str, limit, align)
		local style = button.style
		local _, pad, margin, _, bw = f0b.style.getUnits(style)
		local space = (pad+bw+margin)*2
		local w, wrap = style.font:getWrap(str, limit - space)
		button.text.str = str
		if align ~= nil then
			button.text.align = align
		end
		return setDims(button, w + space, #wrap)
	end,

	draw = draw,

	drawBox = function(button, style)
		return draw(button, style, unpack(button.box, 1, 2))
	end,

	regen = regen,

	stub = buttonStub,

	new = function(style, str, x, y, limit, lines, align)
		local b = buttonStub(style)
		b.text.align = align
		b.text.str = str
		setPos(b, x, y)
		setDims(b, limit, lines)
		return regen(b)
	end,
}
