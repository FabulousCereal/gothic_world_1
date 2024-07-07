-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function draw(img, hx, hy, x, y, sx, sy, ...)
	local h = love.graphics.getHeight()
	local iw, ih = img:getDimensions()
	x = math.floor(x - (iw/2 + hx)*sx)
	y = math.floor(h + y - (ih + hy)*sy)
	return love.graphics.draw(img, x, y, 0, sx, sy, ...)
end

return {
	draw = function(doll, x, y, sx, sy, ...)
		local img, hx, hy = unpack(doll)
		return draw(img,
			hx or 0,
			hy or 0,
			x or 0,
			(y or 0) + 1,
			sx or 1,
			sy or 1,
			...
		)
	end,
}
