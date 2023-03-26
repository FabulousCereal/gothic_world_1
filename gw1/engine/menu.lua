-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local buttons = require("f0b.buttons")
local clearArray = require("f0b.table").clearArray

local function replaceMenu(self, entries)
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local x = entries.x - em * style.padding
	local maxW = 0
	local lineY = 0
	local buttons = f0b.table.clearArray(entries.buttons)
	local text = self.text
	text:clear()

	for i = 1, #entries do
		local entry = entries[i]
		local colorText
		if entry[2] then
			colorText = {style.color, entry[1]}
		else
			colorText = {style.disabled.color, entry[1]}
		end
		local y = math.floor(lineY)
		text:add(colorText, 0, y)
		local w = text:getWidth()
		if w > maxW then
			maxW = w
		end

		table.insert(buttons, {x, entries.y + y, w, em})
		lineY = lineY + lineSpacing
	end
	local rectW = math.floor(maxW + em * style.padding * 2)
	for i = 1, #buttons do
		buttons[i][3] = rectW
	end
	self.entries = entries
	self.background = entries.background
end

local menuOps = {
	state = function(_, entry)
		gamestate:stateSwitch(entry[3])
	end,

	menu = function(self, entry)
		table.insert(self.stack, self.entries.buttons.cur)
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
	local graphics = love.graphics
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local entries = self.entries
	local b = entries.buttons[entries.buttons.cur]
	f0b.shapes.bordered(graphics.rectangle, style,
		b[1], b[2], b[3], b[4], style.borderRadius)

	graphics.setColor(1, 1, 1, 1)
	graphics.draw(self.text, entries.x, entries.y)
end

local function normalizeEntries(entries, em)
	entries.x, entries.y = f0b.screen.coords(entries.x or 1, entries.y or 1, em)
	entries.buttons = {cur = 1}
	for i = 1, #entries do
		local entry = entries[i]
		if entry[2] == "menu" then
			normalizeEntries(entry[3], em)
		end
	end
end

local function menuPre(self)
	local font = self.style.font
	self.text = love.graphics.newText(font)
	normalizeEntries(self.allEntries, font:getHeight())
	replaceMenu(self, self.allEntries)

	self.pre = nil
end

local function menuInput(self, fn, ...)
	local entries = self.entries
	local i = fn(entries, ...)
	if i then
		local entry = entries[i]
		if entry[2] then
			return menuOps[entry[2]](self, entry)
		end
	end
end

local function menuMousemoved(self, ...)
	return buttons.mousemoved(self.entries, ...)
end

local function giveInput(fn)
	return function(self, ...)
		return menuInput(self, fn, ...)
	end
end

return {
	new = function(entries, style)
		return {
			draw = menuDraw,
			keypressed = giveInput(buttons.keypressed),
			mousepressed = giveInput(buttons.mousepressed),
			wheelmoved = giveInput(buttons.wheelmoved),
			mousemoved = menuMousemoved,
			pre = menuPre,

			allEntries = entries,
			entries = nil,
			stack = {},
			style = style,

			text = nil,

			background = nil,
			tracks = nil,
		}
	end,
}
