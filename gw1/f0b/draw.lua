-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

local unitSquare = (function()
	local graphics = love.graphics
	local cnv = graphics.newCanvas(1, 1)
	graphics.setCanvas(cnv)
	graphics.clear(1, 1, 1, 1)
	graphics.setCanvas()
	return cnv
end)()

local function shaderAndBack(shader, prev, ...)
	local graphics = love.graphics
	graphics.setShader(shader)
	graphics.draw(unitSquare, ...)
	graphics.setShader(prev)
end

local function sdfDraw(sdf, margin, x, y, r, w, h, ...)
	local shader, prev = f0b.shader.prepare(sdf)
	w = w + margin*2
	h = h + margin*2
	shader:send("margin", margin)
	shader:send("resolution", {w, h})
	shaderAndBack(shader, prev, x - margin, y - margin, r, w, h, ...)
end

return {
	line = function(p, width, radius)
		local margin = 1
		local dx = p[3] - p[1]
		local dy = p[4] - p[2]
		local r = math.atan2(dy, dx)
		local l = math.sqrt(dx*dx + dy*dy) + width
		local o = -width/2
		local ctx = res.shader.rect{
			borderRadius = (radius or width/2) + margin
		}
		local graphics = love.graphics
		graphics.push()
		graphics.translate(p[1], p[2])
		graphics.rotate(r)
		sdfDraw(ctx, margin, o, o, 0, l, width)
		graphics.pop()
	end,

	rect = function(style, x, y, ...)
		sdfDraw(f0b.style.setupShader(res.shader.rect, style), 0, x, y, 0, ...)
	end,

	sdf = function(sdf, ...)
		sdfDraw(sdf, 1, ...)
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

	unitSquare = unitSquare,

	screenFill = function()
		love.graphics.draw(unitSquare, 0, 0, 0,
			love.graphics.getDimensions())
	end,
}
