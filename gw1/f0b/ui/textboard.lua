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
		f0b.buttons.setText(board.textboard, string.sub(str, 1, pos),
			board.style.textAlign)
		board.pos = pos + 1
		return char
	else
		board.finished = true
		return nil
	end
end

local function typewriterFinish(board)
	local text = board.textboard.text
	f0b.buttons.setText(board.textboard, board.str, board.style.textAlign)
	board.pos = #board.str + 1
	board.finished = true
end

local function nameAndWidth(board, style)
	local style = board.style
	local em = style.font:getHeight()
	local pad = style.padding * em
	board.namebox[3] = math.floor(
		board.nametext[1]:getWidth() + pad + style.borderWidth*2)
end

local function textboardRegen(board, style)
	board.style = style

	local em, pad, margin, lh = f0b.style.getUnits(style)
	local screenW, screenH = love.graphics.getDimensions()

	local tb = f0b.buttons.regen(board.textboard, style, 0, 0, screenW,
		style.lines)
	f0b.buttons.setPos(board.textboard, 0, screenH, "bottom")

	local floor = math.floor
	local bw = style.borderWidth
	local nameboxH = em + bw*2 + pad/2
	local nbox = board.namebox
	local ntext = board.nametext
	nbox[1] = floor(tb.pos[1] + tb.box[1] + pad)           -- X
	nbox[2] = floor(tb.pos[2] + tb.box[2] - nameboxH + bw) -- Y 
	-- Width is set with name.
	nbox[4] = floor(nameboxH) -- Height

	ntext[1]:setFont(style.font)
	ntext[2] = floor(nbox[1] + pad/2 + bw) -- X
	ntext[3] = floor(nbox[2] + pad/4 + bw) -- Y

	nameAndWidth(board, style)
	return board
end

return {
	setText = function(board, str, append, instant)
		str = multiRepl(str, board.repl)
		local text = board.textboard.text
		if append then
			str = board.str .. str
		else
			board.pos = 1
			text[1]:clear()
		end

		local _, str = board.style.font:getWrap(str, text.wrap)
		board.str = table.concat(str, "\n")
		board.timer = 0
		board.finished = instant
	end,

	setName = function(board, name)
		board.name = name
		if name then
			board.nametext[1]:set(name)
			nameAndWidth(board, style)
		end
	end,

	finish = typewriterFinish,

	--mousepressed = function(board, x, y, button)

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
		f0b.buttons.draw(board.textboard, style)

		local graphics = love.graphics
		if board.name then
			f0b.shapes.shader(style, board.namebox)
			graphics.setColor(style.color)
			graphics.draw(unpack(board.nametext))
		end
	end,

	regen = textboardRegen,

	new = function(style, repl)
		local board = {
			namebox = {0, 0, 0, 0, 0},
			nametext = {
				love.graphics.newText(style.font), 0, 0
			},
			name = false,
			str = false,
			textboard = f0b.buttons.default(style),
			pos = 0,
			speed = 1,
			finished = true,
			display = false,
			style = style,
			repl = repl,
		}
		return textboardRegen(board, style)
	end,
}
