-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local buttons = require("f0b.buttons")

local function selectRegen(board)
	local style = board.style

	local em = style.font:getHeight()
	local padding = em * style.padding
	local margin = em * style.margin
	local lineHeight = em * style.lineHeight
	local lineSpacing = lineHeight * style.lineSpacing
	local screenW = love.graphics.getWidth()

	local floor = math.floor

	local borderMargin = margin + style.borderWidth
	local padgin = padding + borderMargin
	local textboardSize = lineHeight * style.lines + padgin*2

	local select = board.select
	local text = select[1]
	text:clear()
	text:setFont(style.font)
	select[2] = floor(padgin) -- X
	select[3] = floor(textboardSize + padgin/2) -- Y

	local textW = screenW - select[2]*2
	local lineY = 0
	local buttons = {cur = 1}
	local choices = board.choices
	for i, choice in pairs(choices) do
		choice = string.gsub(choice, "\n+%s*", " ")
		text:addf(choice, textW, "center", 0, lineY)
		local h = text:getHeight()
		table.insert(buttons, {
			floor(borderMargin),
			floor(textboardSize + borderMargin/2 + lineY),
			floor(screenW - borderMargin*2),
			floor(h + padding), style.borderRadius})
		lineY = lineY + h + lineSpacing
	end
	board.display = true
	board.buttons = buttons
	return board
end

return {
	set = function(board, choices)
		board.choices = choices
		return selectRegen(board)
	end,

	draw = function(board)
		local style = board.style
		local graphics = love.graphics
		local bordered = f0b.shapes.bordered

		local em = style.font:getHeight()
		local padding = em * style.padding
		local lineSpacing = em * style.lineSpacing

		local floor = math.floor
		for i, button in ipairs(board.buttons) do
			local lStyle
			if i == board.buttons.cur then
				lStyle = style
			else
				lStyle = style.unselected
			end
			bordered(graphics.rectangle, lStyle, unpack(button))
		end
		graphics.setColor(style.color)
		return graphics.draw(unpack(board.select))
	end,

	regen = function(board, style)
		board.style = style
		if board.choices then
			return selectRegen(board)
		end
	end,

	new = function(style)
		return {
			style = style,
			select = {love.graphics.newText(style.font), 0, 0},
			display = false,
			choices = false,
			buttons = nil,
		}
	end,
}
