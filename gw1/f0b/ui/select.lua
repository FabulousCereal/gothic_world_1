-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function textboardRegen(board, style)
	board.style = style

	local em = style.font:getHeight()
	local padding = em * style.padding
	local margin = em * style.margin
	local lh = em * style.lineHeight
	local screenW = love.graphics.getWidth()

	local sbox = board.selectbox
	local select = board.select
	local floor = math.floor

	sbox[1] = floor(margin + style.borderWidth + padding * 2) -- X
	-- Y is modified during drawing.
	sbox[3] = floor(screenW - margin * 2 - padding * 4)       -- Width
	sbox[4] = floor(em + padding / 2)                         -- Height
	sbox[5] = style.borderRadius                              -- Radius

	local textboxH = lh * style.lines + padding + style.borderWidth
	select[1]:setFont(style.font)
	select[2] = floor(sbox[1] + padding)                -- X
	select[3] = floor(textboxH + em * style.margin * 2) -- Y

	board.wrap = sbox[3] - padding * 2 -- Max text width
	return board
end

return {
	set = function(board, choices)
		local style = board.style
		local lineSpacing = style.font:getHeight() * style.lineSpacing
		local lineY = 0

		local select = board.select
		local text = select[1]
		text:clear()
		for i = 1, #choices do
			local choice = string.gsub(choices[i], "\n+%s*", " ")
			text:addf(choice, board.wrap, "center", 0,
				math.floor(lineY))
			lineY = lineY + lineSpacing
		end
		board.cur = 1
		board.num = #choices
		board.display = true
	end,

	keypress = function(board, key)
		if key == "return" then
			return board.cur
		elseif key == "up" then
			board.cur = ((board.cur - 2) % board.num) + 1
		elseif key == "down" then
			board.cur = (board.cur % board.num) + 1
		elseif key == "home" then
			board.cur = 1
		elseif key == "end" then
			board.cur = board.num
		end
	end,

	draw = function(board)
		local style = board.style
		local graphics = love.graphics
		local bordered = f0b.shapes.bordered

		local em = style.font:getHeight()
		local padding = em * style.padding
		local lineSpacing = em * style.lineSpacing

		local floor = math.floor
		local select, selectbox = board.select, board.selectbox
		selectbox[2] = floor(select[3] - padding / 4)
		for i = 1, board.num do
			local lStyle
			if i == board.cur then
				lStyle = style
			else
				lStyle = style.unselected
			end
			bordered(graphics.rectangle, lStyle, unpack(selectbox))
			selectbox[2] = floor(selectbox[2] + lineSpacing)
		end
		graphics.setColor(style.color)
		return graphics.draw(unpack(select))
	end,

	regen = textboardRegen,

	new = function(style)
		local board = {
			selectbox = {0, 0, 0, 0, 0},
			select = {love.graphics.newText(style.font), 0, 0},
			wrap = 0,
			cur = 1,
			num = false,
			display = false,
		}
		return textboardRegen(board, style)
	end,
}
