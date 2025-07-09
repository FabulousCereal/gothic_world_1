-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

local function getProperWrap(font, str, limit)
	if type(str) == "table" then -- Colored text
		local t = {}
		for i = 2, #str, 2 do
			t[i / 2] = str[i]
		end
		str = table.concat(t)
	end
	local w, wrappedText = font:getWrap(str, limit)
	return w, #wrappedText
end

local function renderText(b)
	local t = b.text[1]
	t:setf(b.str, b.limit, b.align or b.style.textAlign)
	return t:getWidth()
end

local function buttonWidth(button)
	return button.pos[3]
end

local function buttonHeight(button, lineHeight, pad, bw, margin)
	local boxH = button.lines * lineHeight + pad + bw*2
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
	button.limit = w - textPad
	return button, renderText(button) + textPad, boxH+margin
end

local function setWidth(button, w)
	button.pos[3] = w
end

local function setLines(button, l)
	button.lines = l
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

local function setAlign(button, align)
	if align ~= nil then
		button.align = align
	end
end

-- Set text. If unspecified, the previous `limit` and `align` values are kept,
-- even if the new text overflows
local function setText(button, str, limit, align)
	button.str = str
	if limit then
		setWidth(button, limit)
	end
	setAlign(button, align)
end

local function draw(button, style, x, y)
	if not style then
		style = button.style
	end
	local graphics = love.graphics
	graphics.push()

	graphics.translate(button.pos[1] + (x or 0), button.pos[2] + (y or 0))

	graphics.setColor(1, 1, 1, 1)
	f0b.draw.rect(f0b.style.getShader(style), unpack(button.box))

	graphics.setColor(type(button.str) == "table"
		and {1, 1, 1, 1} or style.color)
	graphics.draw(unpack(button.text))

	graphics.pop()
end

local function buttonStub(style)
	return {
		-- Position and size of the whole element, margins included
		pos = {0, 0, 0, 0},
		-- Offset (relative to pos) and size of the button box
		box = {0, 0, 0, 0},
		text = {love.graphics.newText(style.font), 0, 0},
		style = style,
		str = "",
		lines = 0,
		-- If false, align according to style
		align = false,
		-- Max size of the text object
		limit = 0,
	}
end

return {
	-- Whether X and Y are inside the button box
	mousemoved = function(button, x, y)
		return f0b.math.rectangleTest(button.box,
			x - button.pos[1], y - button.pos[2])
	end,

	-- Button dimensions, sans margin
	getBoxDims = function(button)
		return unpack(button.box, 3)
	end,

	-- Get height with margin
	getHeight = function(button)
		return button.pos[4]
	end,

	getLimit = function(button)
		return button.limit
	end,

	-- Set width with margin
	setWidth = setWidth,

	-- Set width with margin and lines of height
	setDims = setDims,

	setPos = setPos,

	setStyle = function(button, style)
		button.style = style
	end,

	-- Set text, adapting the button size to it
	setTextAdapt = function(button, str, limit, align)
		local style = button.style
		local _, pad, margin, _, bw = f0b.style.getUnits(style)
		local outer = (pad+bw+margin)*2
		local w, lines = getProperWrap(style.font, str, limit - outer)
		button.str = str
		setAlign(button, align)
		return setDims(button, w + outer, lines)
	end,

	setText = setText,

	draw = draw,

	-- Draw the button with margin omitted
	drawBox = function(button, style)
		return draw(button, style, -button.box[1], -button.box[2])
	end,

	-- Make changes effective
	regen = regen,

	regenText = renderText,

	-- Useless minimal button
	stub = buttonStub,

	-- A new button
	new = function(style, str, x, y, limit, lines, align)
		local b = buttonStub(style)
		setPos(b, x, y)
		setText(b, str, limit, align)
		setLines(b, lines)
		return regen(b)
	end,
}
