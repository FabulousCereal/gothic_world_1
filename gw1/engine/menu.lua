-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function replaceMenu(self, entries)
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local text = self.text
	text:clear()

	local maxW = 0
	local lineY = 0
	for i = 1, #entries do
		local entry = entries[i]
		local colorText
		if entry[2] then
			colorText = {style.color, entry[1]}
		else
			colorText = {style.disabled.color, entry[1]}
		end
		text:add(colorText, 0, math.floor(lineY))
		lineY = lineY + lineSpacing
		local w = text:getWidth()
		if w > maxW then
			maxW = w
		end
	end
	self.rectW = math.floor(maxW + em * style.padding * 2)
	self.entries = entries
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

local function menuKeypressed(self, key)
	local entries = self.entries
	if key == "return" then
		local entry = entries[entries.cur]
		if entry[2] then
			return menuOps[entry[2]](self, entry)
		end
	elseif key == "up" then
		entries.cur = ((entries.cur - 2) % #entries) + 1
	elseif key == "down" then
		entries.cur = ((entries.cur) % #entries) + 1
	elseif key == "home" then
		entries.cur = 1
	elseif key == "end" then
		entries.cur = #entries
	end
end

local function menuDraw(self)
	local graphics = love.graphics
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local rectX = math.ceil(self.entries.x - em * style.padding)
	local rectY = math.floor(self.entries.y
		+ (self.entries.cur - 1) * lineSpacing)
	f0b.shapes.bordered(graphics.rectangle, style,
		rectX, rectY, self.rectW, self.rectH, style.borderRadius)

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
