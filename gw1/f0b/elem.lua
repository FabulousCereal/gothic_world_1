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

local poly = elemMetatable(polyRegular)
local star = elemMetatable(starRegular)

local function genScreenFill()
	local w, h = love.graphics.getDimensions()
	return setmetatable(
		{
			poly[4], w/2, h/2, math.pi/4,
			math.max(w, h) / math.sqrt(2)
		},
		{
			__call = function(self, scale)
				return {self[1], self[2], self[3], self[4],
					self[5] * scale}
			end
		}
	)
end

local function roundRect(w, h, r)
	-- We could be fancy and do a superellipse, but we'd like to save on
	-- vertices
	local angle = math.pi / 2 / r
	local cos = math.cos
	local sin = math.sin
	local rect = {}
	local corner = function(k, x, y)
		local l = k + r
		while k < l do
			local a = angle * k
			k = k + 1
			rect[k] = {cos(a)*r + x, sin(a)*r + y}
		end
		return k
	end

	w = w - r
	h = h - r

	local k = corner(0, w, h)
	k = corner(k, r, h)
	k = corner(k, r, r)
	k = corner(k, w, r)
	return love.graphics.newMesh(rect, "fan", "static")
end

return {
	poly = poly,
	star = star,

	roundRect = roundRect,

	circle = polyRegular(),

	screenFill = genScreenFill(),
}
