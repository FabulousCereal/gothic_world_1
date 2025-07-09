-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

local function centerRectAt(ax, ay, bx, by)
	return math.floor(ax - bx*.5), math.floor(ay - by*.5)
end

return {
	clamp = function(n, min, max)
		return math.min(math.max(n, min), max)
	end,

	oneMod = function(n, div) -- Fuck one-based indexing
		return (n-1)%div + 1
	end,

	rectangleTest = function(rect, x, y)
		return x >= rect[1] and y >= rect[2]
			and x <= rect[1] + rect[3] and y <= rect[2] + rect[4]
	end,

	centerRectAt = centerRectAt,

	centerRect = function(ax, ay, bx, by)
		return centerRectAt(ax*.5, ay*.5, bx, by)
	end,
}
