-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local multiRepl = require("f0b.ui._uiCommon").multiRepl

local function nextCodePoint(text, start)
	local byte = string.byte(text, start)
	if byte > 0xf0 then
		finish = start + 3
	elseif byte > 0xe0 then
		finish = start + 2
	elseif byte > 0xc0 then
		finish = start + 1
	else
		finish = start
	end
	return finish, string.sub(text, start, finish)
end

local function typewriterNext(board)
	local str, pos = board.str, board.pos
	if pos <= #str then
		local pos, char = nextCodePoint(str, pos)
		board.text[1]:setf(string.sub(str, 1, pos), board.text.wrap,
			board.style.textAlign)
		board.pos = pos + 1
		return char
	else
		board.finished = true
		return nil
	end
end

local function typewriterFinish(board)
	board.text[1]:setf(board.str, board.text.wrap, board.style.textAlign)
	board.pos = #board.str + 1
	board.finished = true
end

local function textboardRegen(board, style)
	board.style = style

	local em = style.font:getHeight()
	local lh = em * style.lineHeight
	local padding = em * style.padding
	local margin = em * style.margin
	local screenW, screenH = love.graphics.getDimensions()

	local floor = math.floor

	local tbox = board.textbox
	local nbox = board.namebox
	local text = board.text
	local name = board.name

	local textboxH = lh * style.lines + padding + style.borderWidth
	tbox[1] = floor(margin)                      -- X
	tbox[2] = floor(screenH - margin - textboxH) -- Y
	tbox[3] = floor(screenW - margin * 2)        -- Width
	tbox[4] = floor(textboxH)                    -- Height
	tbox[5] = style.borderRadius                 -- Radius

	local nameboxH = em + style.borderWidth / 2
	nbox[1] = floor(tbox[1] + padding)   -- X
	nbox[2] = floor(tbox[2] - nameboxH)  -- Y 
	-- Width is set with name.
	nbox[4] = floor(nameboxH)            -- Height
	nbox[5] = style.borderRadius / 2 + 1 -- Radius

	text[1]:setFont(style.font)
	text[2] = floor(tbox[1] + padding)     -- X
	text[3] = floor(tbox[2] + padding / 2) -- Y
	text.wrap = floor(tbox[3] - (padding + style.borderWidth) * 2)

	name[1]:setFont(style.font)
	name[2] = floor(nbox[1] + padding / 2) -- X
	name[3] = nbox[2]                      -- Y
	return board
end

return {
	setText = function(board, str, append, instant)
		str = multiRepl(str, board.repl)
		if append then
			str = board.str .. str
		else
			board.pos = 1
			board.text[1]:clear()
		end

		local _, str = board.style.font:getWrap(str, board.text.wrap)
		board.str = table.concat(str, "\n")
		board.timer = 0
		board.finished = instant
	end,

	setName = function(board, name)
		if name then
			local style = board.style
			local em = style.font:getHeight()
			local pad = style.padding * em + style.borderWidth
			board.name[1]:set(name)
			board.namebox[3] = math.floor(
				board.name[1]:getWidth() + pad)
		else
			board.namebox[3] = 0
		end
	end,

	finish = typewriterFinish,

	keypressed = function(board, key)
		if key == "space" or key == "return" then
			return typewriterFinish(board)
		end
	end,

	update = function(board, dt)
		if board.finished then
			return
		end

		local timer = board.timer
		while timer <= 0 do
			local char = typewriterNext(board)
			if char then
				local w = res.chrono.textSpeed / board.speed
				local longs = ",.?!:;~"
				if string.find(longs, char, 1, true) then
					w = w * 4
				end
				timer = timer + w
			else
				break
			end
		end
		board.timer = timer - dt
	end,

	draw = function(board)
		local style = board.style
		local graphics = love.graphics
		local bordered = f0b.shapes.bordered

		if board.namebox[3] > 0 then
			bordered(graphics.rectangle, style,
				unpack(board.namebox))
			graphics.setColor(style.color)
			graphics.draw(unpack(board.name))
		end

		bordered(graphics.rectangle, style, unpack(board.textbox))
		graphics.setColor(style.color)
		return graphics.draw(unpack(board.text))
	end,

	regen = textboardRegen,

	new = function(style, repl)
		local newText = love.graphics.newText
		local board = {
			textbox = {0, 0, 0, 0, 0},
			namebox = {0, 0, 0, 0, 0},
			text = {
				newText(style.font), 0, 0,
				wrap = 0,
			},
			name = {
				newText(style.font), 0, 0
			},
			pos = 0,
			speed = 1,
			str = nil,
			finished = true,
			display = false,
			style = style,
			repl = repl,
		}
		return textboardRegen(board, style)
	end,
}
