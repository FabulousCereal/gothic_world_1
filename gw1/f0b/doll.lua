-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

return {
	draw = function(doll, x, y, sx, sy, ...)
		local img, hx, hy = unpack(doll)
		local h = love.graphics.getHeight()
		local iw, ih = img:getDimensions()
		x = x or 0
		y = (y or 0) + 1
		sx = sx or 1
		sy = sy or 1
		hx = hx or 0
		hy = hy or 0
		local x = math.floor(x - (iw/2 + hx)*sx)
		local y = math.floor(h + y - (ih + hy)*sy)
		love.graphics.draw(img, x, y, 0, sx, sy, ...)
	end,
}
