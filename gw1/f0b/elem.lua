-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function starRegular(sides)
	local segs = sides * 2
	local angle = math.pi*2 / segs
	local cos, sin = math.cos, math.sin
	local star = {{0, 0}}
	for i = 2, segs + 2 do
		local pos = angle * i
		local dist = (i % 2 + 1) / 2
		star[i] = {cos(pos) * dist, sin(pos) * dist}
	end
	return love.graphics.newMesh(star, "fan", "static")
end

local function polyRegular(sides)
	local segs = sides or math.min(love.graphics.getDimensions())
	local angle = math.pi*2 / segs
	local cos, sin = math.cos, math.sin
	local unit = {}
	for i = 1, segs do
		local pos = angle * i
		unit[i] = {cos(pos), sin(pos)}
	end
	return love.graphics.newMesh(unit, "fan", "static")
end

local function elemMetatable(func)
	return setmetatable({}, {
		__index = function(self, key)
			local val = func(key)
			self[key] = val
			return val
		end,
	})
end

local function unitCanvas()
	local graphics = love.graphics
	local cnv = graphics.newCanvas(1, 1)
	graphics.setCanvas(cnv)
	graphics.clear(1, 1, 1, 1)
	graphics.setCanvas()
	return cnv
end

local poly = elemMetatable(polyRegular)
local star = elemMetatable(starRegular)
local cnvSquare = unitCanvas()

local function genScreenFill()
	local w, h = love.graphics.getDimensions()
	return setmetatable(
		{
			cnvSquare, 0, 0, 0, w, h,
		},
		{
			__call = function(self, scale)
				return {self[1], 0, 0, 0, self[5] * scale, self[6] * scale}
			end
		}
	)
end

return {
	poly = poly,
	star = star,

	circle = polyRegular(),

	screenFill = genScreenFill(),

	square = cnvSquare,
}
