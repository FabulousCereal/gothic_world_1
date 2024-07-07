-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local multiRepl = require("f0b.ui._uiCommon").multiRepl
local oneMod = require("f0b.math").oneMod
local dispatch = require("f0b.table").dispatch

local function selectRegen(select)
	local style = select.style

	local _, _, margin = f0b.style.getUnits(style)
	local screenW = love.graphics.getWidth()

	local lineY = 0
	local maxW = 0
	for i = 1, #select.choices do
		local choice = select.choices[i]
		if select.repl then
			choice = multiRepl(choice, select.repl)
		end
		local button, textW, y = f0b.button.new(style, choice,
			0, lineY, screenW, 1, select.align)
		select[i] = button
		lineY = lineY + y
		if textW > maxW then
			maxW = textW
		end
	end
	for i = #select, #select.choices + 1, -1 do
		select[i] = nil
	end
	if style.width == "adapt" then
		for _, button in ipairs(select) do
			f0b.button.setWidth(button, maxW)
			f0b.button.regen(button)
		end
	end
	select.pos[3] = select[1].pos[3]
	select.pos[4] = lineY + margin + style.borderWidth/2
	return select
end

local keys = dispatch({
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

local function mouseTest(select, x, y)
	if f0b.math.rectangleTest(select.pos, x, y) then
		x = x - select.pos[1]
		y = y - select.pos[2]
		for i, button in ipairs(select) do
			if f0b.button.mousemoved(button, x, y) then
				select.cur = i
				return i
			end
		end
	end
end

return {
	mousepressed = mouseTest,

	mousemoved = function(...)
		return mouseTest(...) and "hand"
	end,

	keypressed = function(select, key)
		return keys[key](select)
	end,

	wheelmoved = function(select, _x, y)
		y = math.modf(y)
		if y ~= 0 then
			return keys[y > 0 and "up" or "down"](select)
		end
	end,

	draw = function(select)
		local style = select.style
		local graphics = love.graphics
		graphics.push()

		graphics.translate(unpack(select.pos, 1, 2))
		for i, button in ipairs(select) do
			f0b.button.draw(button, (i == select.cur)
				and style or style.unselected)
		end

		graphics.pop()
	end,

	regen = function(select, style)
		select.style = style
		if select.choices then
			return selectRegen(select)
		end
	end,

	set = function(select, choices)
		select.choices = choices
		return selectRegen(select)
	end,

	new = function(style, repl, align, x, y)
		return {
			cur = 1,
			pos = {x or 0, y or 0, 0, 0},
			style = style,
			display = false,
			choices = false,
			repl = repl,
			align = align,
		}
	end,
}
