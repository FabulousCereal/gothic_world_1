-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense
--[=[
local menuKeys = {
	["return"] = function(self, entries)
		local entry = entries[entries.cur]
		if entry[2] then
			return menuOps[entry[2]](self, entry)
		end
	end,

	up = function(self, entries)
		entries.cur = ((entries.cur - 2) % #entries) + 1
	end,

	down = function(self, entries)
		entries.cur = ((entries.cur) % #entries) + 1
	end,

	home = function(self, entries)
		entries.cur = 1
	end,

	["end"] = function(self, entries)
		entries.cur = #entries
	end,
}

local function menuMousepressed(self, x, y, button, _isTouch, _presses)
	if button == 1 then
		local i = mouseTouch(self, x, y)
		if i then
			local entries = self.entries
			entries.cur = i
			menuKeys["return"](self, entries)
		end
	end
end

local function menuMousemoved(self, x, y, _dx, _dy, _isTouch)
	local i = mouseTouch(self, x, y)
	if i then
		self.entries.cur = i
	end
end
]=]
return {
	mouseIntersect = function(buttons, x, y)
		for i, b in ipairs(buttons) do
			if x >= b[1] and y >= b[2] and x <= b[1] + b[3] and y <= b[2] + b[4] then
				return i
			end
		end
	end,
}
