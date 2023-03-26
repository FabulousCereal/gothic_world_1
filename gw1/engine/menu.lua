-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local buttons = require("f0b.buttons")

local function replaceMenu(self, entries)
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local text = self.text
	text:clear()

	local x = entries.x - em * style.padding
	local maxW = 0
	local lineY = 0
	local buttons = {}
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
	self.buttons = buttons
	self.background = entries.background
end

local menuOps = {
	state = function(_, entry)
		gamestate:stateSwitch(entry[3])
	end,

	menu = function(self, entry)
		table.insert(self.stack, self.entries.cur)
		local entries = entry[3]
		if not entries.cur then
			entries.cur = 1
		end
		replaceMenu(self, entries)
	end,

	["return"] = function(self)
		local entries, stack = self.allEntries, self.stack
		stack[#stack] = nil
		for i = 1, #stack do
			entries = entries[stack[i]][3]
		end
		replaceMenu(self, entries)
	end,
}

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

local function menuKeypressed(self, key)
	local fn = menuKeys[key]
	if fn then
		return fn(self, self.entries)
	end
end

local function menuMousepressed(self, x, y, button, _isTouch, _presses)
	if button == 1 then
		local i = buttons.mouseIntersect(self.buttons, x, y)
		if i then
			local entries = self.entries
			entries.cur = i
			menuKeys["return"](self, entries)
		end
	end
end

local function menuMousemoved(self, ...)
	local i = buttons.mouseIntersect(self.buttons, ...)
	if i then
		self.entries.cur = i
	end
end

local function menuDraw(self)
	local graphics = love.graphics
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local b = self.buttons[self.entries.cur]
--	local rectX = math.ceil(self.entries.x - em * style.padding)
--	local rectY = math.floor(self.entries.y
--		+ (self.entries.cur - 1) * lineSpacing)
--	f0b.shapes.bordered(graphics.rectangle, style,
--		rectX, rectY, self.rectW, self.rectH, style.borderRadius)
	f0b.shapes.bordered(graphics.rectangle, style,
		b[1], b[2], b[3], b[4], style.borderRadius)

	graphics.setColor(1, 1, 1, 1)
	graphics.draw(self.text, self.entries.x, self.entries.y)
end

local function normalizeEntries(entries, em)
	entries.x, entries.y = f0b.screen.coords(entries.x or 1, entries.y or 1, em)
	for i = 1, #entries do
		local entry = entries[i]
		if entry[2] == "menu" then
			normalizeEntries(entry[3], em)
		end
	end
end

local function menuPre(self)
	local font = self.style.font
	local em = font:getHeight()
	self.text = love.graphics.newText(font)
	normalizeEntries(self.allEntries, em)
	replaceMenu(self, self.allEntries)
	self.rectH = em

	self.pre = nil
end

return {
	new = function(entries, style)
		entries.cur = 1
		return {
			draw = menuDraw,
			keypressed = menuKeypressed,
			mousemoved = menuMousemoved,
			mousepressed = menuMousepressed,
			pre = menuPre,

			allEntries = entries,
			entries = nil,
			stack = {},
			style = style,

			text = nil,
			rectW = nil,
			rectH = nil,

			background = nil,
			tracks = nil,
		}
	end,
}
