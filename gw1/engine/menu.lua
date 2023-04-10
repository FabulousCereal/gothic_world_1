-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local clearArray = require("f0b.table").clearArray

local function replaceMenu(self, entries)
	local style = self.style
	local textList = {}
	for _, entry in ipairs(entries) do
		table.insert(textList, {
			entry[2] and style.color or style.disabled.color,
			entry[1]
		})
	end

	local select = self.ui.select
	f0b.ui.widget.select.set(select, textList)
	select.pos[1] = entries.x
	select.pos[2] = entries.y

	self.entries = entries
	self.background = entries.background
end

local menuOps = {
	state = function(_, entry)
		gamestate:stateSwitch(entry[3])
	end,

	menu = function(self, entry)
		table.insert(self.stack, self.ui.select.cur)
		replaceMenu(self, entry[3])
	end,

	["return"] = function(self)
		local entries, stack = self.allEntries, self.stack
		for i = 1, #stack - 1 do
			entries = entries[stack[i]][3]
		end
		stack[#stack] = nil
		replaceMenu(self, entries)
	end,
}

local function menuDraw(self)
	f0b.ui.draw(self.ui)
end

local function emCoords(x, y, scale)
	if scale then
		x, y = x * scale, y * scale
	end

	local w, h = love.graphics.getDimensions()
	if x < 0 then
		x = x + w
	end
	if y < 0 then
		y = y + h
	end
	return x, y
end

local function normalizeEntries(entries, em)
	entries.x, entries.y = emCoords(entries.x or 1, entries.y or 1, em)
	for i, entry in ipairs(entries) do
		local entry = entries[i]
		if entry[2] == "menu" then
			normalizeEntries(entry[3], em)
		end
	end
end

local function menuPre(self)
	f0b.ui.add(self.ui, "select", self.style, nil, "left")
	self.ui.select.display = true
	normalizeEntries(self.allEntries, self.style.font:getHeight())
	replaceMenu(self, self.allEntries)

	self.pre = nil
end

local function menuInput(self, fn, ...)
	local i = fn(self.ui.select, ...)
	if i then
		local entry = self.entries[i]
		if entry[2] then
			return menuOps[entry[2]](self, entry)
		end
	end
end

local function menuMousemoved(self, ...)
	return f0b.ui.widget.select.mousemoved(self.ui.select, ...)
end

local function giveInput(name)
	local fn = f0b.ui.widget.select[name]
	return function(self, ...)
		return menuInput(self, fn, ...)
	end
end

return {
	new = function(entries, style)
		return {
			draw = menuDraw,
			keypressed = giveInput("keypressed"),
			mousepressed = giveInput("mousepressed"),
			wheelmoved = giveInput("wheelmoved"),
			mousemoved = menuMousemoved,
			pre = menuPre,

			allEntries = entries,
			entries = nil,
			stack = {},
			style = style,
			ui = {},

			background = nil,
			tracks = nil,
		}
	end,
}
