-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local oneMod = require("f0b.math").oneMod

local keys = f0b.table.dispatch({
	["return"] = function(buttons)
		return buttons.cur
	end,

	up = function(buttons)
		buttons.cur = oneMod(buttons.cur - 1, #buttons)
	end,

	down = function(buttons)
		buttons.cur = oneMod(buttons.cur + 1, #buttons)
	end,

	home = function(buttons)
		buttons.cur = 1
	end,

	["end"] = function(buttons)
		buttons.cur = #buttons
	end,
})

local function mouseTest(self, x, y)
	local buttons = self.buttons
	for i, b in ipairs(buttons) do
		if x >= b[1] and y >= b[2] and x <= b[1] + b[3] and y <= b[2] + b[4] then
			buttons.cur = i
			return i
		end
	end
end

return {
	mousepressed = function(self, x, y, mouseButton)
		if mouseButton == 1 then
			return mouseTest(self, x, y)
		end
	end,

	mousemoved = function(...)
		mouseTest(...) -- Discard return value
	end,

	keypressed = function(self, key)
		return keys[key](self.buttons)
	end,

	wheelmoved = function(self, x, y)
		y = f0b.math.clamp(math.floor(y), -1, 1)
		if y ~= 0 then
			return keys[y > 0 and "up" or "down"](self.buttons)
		end
	end,
}
