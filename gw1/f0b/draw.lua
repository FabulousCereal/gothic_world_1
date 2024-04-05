-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function unitCanvas()
	local graphics = love.graphics
	local cnv = graphics.newCanvas(1, 1)
	graphics.setCanvas(cnv)
	graphics.clear(1, 1, 1, 1)
	graphics.setCanvas()
	return cnv
end

local unitSquare = unitCanvas()

local function textGen(style, ...)
	local t = love.graphics.newText(style.font)
	t:setf(...)
	return t, style.font:getHeight() * style.padding
end

local function textWrapDims(t, x, y, limit, pad)
	local floor = math.floor
	return floor(x - pad), floor(y - pad/2),
		floor(limit + pad*2), floor(t:getHeight() + pad)
end

local function shaderDraw(shader, x, y, w, h)
	local graphics = love.graphics
	graphics.setShader(shader)
	graphics.draw(unitSquare, x, y, 0, w, h)
	graphics.setShader()
end

local function textShaderDraw(t, tx, ty, style, invert, ...)
	local graphics = love.graphics
	graphics.setColor(1,1,1,1)
	shaderDraw(f0b.style.getShader(style), ...)
	graphics.setColor(style[invert and "backgroundColor" or "color"])
	graphics.draw(t, tx, ty)
end

return {
	textCanvas = function(text, limit, alignment, style)
		local t, pad = textGen(style, text, limit, alignment)

		local xOff, yOff, w, h = textWrapDims(t, 0, 0, limit, pad)
		local em = style.font:getHeight()
		local bw = style.borderWidth
		xOff = xOff - bw
		yOff = yOff - bw
		w = w + bw*2
		h = h + bw*2

		local graphics = love.graphics
		local cnv = graphics.newCanvas(w, h)
		graphics.setCanvas(cnv)
		textShaderDraw(t, -xOff, -yOff, style, false, 0, 0, w, h)
		graphics.setCanvas()

		return cnv, xOff, yOff
	end,

	text = function(text, tx, ty, limit, alignment, style, invert)
		local t, pad = textGen(style, text, limit, alignment)
		local x, y, w, h = textWrapDims(t, tx, ty, limit, pad)
		textShaderDraw(t, tx, ty, style, invert, x, y, w, h)
	end,

	line = function(p, pRadius, lineWidth)
		local graphics = love.graphics
		local shader = res.shader.circle
		graphics.setLineWidth(lineWidth or pRadius*2)
		graphics.setShader(shader)
		shader:send("style_backgroundColor", {1,1,1,1})
		shader:send("style_borderWidth", 0)
		for i = 1, #p, 2 do
			graphics.draw(unitSquare,
				p[i] - pRadius, p[i+1] - pRadius,
				0, pRadius*2, pRadius*2)
		end
		graphics.setShader()
		return graphics.line(p)
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
	end,

	shader = function(shader, coords)
		return shaderDraw(shader, unpack(coords))
	end,

	unitSquare = unitSquare,

	screenFill = function()
		love.graphics.draw(unitSquare, 0, 0, 0,
			love.graphics.getDimensions())
	end
}
