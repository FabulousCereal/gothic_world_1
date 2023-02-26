-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function printBGColor(id, bgColor)
	print(string.format("%u - r:%.2f, g:%.2f, b:%.2f",
		id, bgColor[1], bgColor[2], bgColor[3]))
end

function love.load()
	love.setDeprecationOutput(true)
	love.keyboard.setKeyRepeat(true)
	love.keyboard.setTextInput(true)

	require("f0ball")
	require("gamestate")
	require("res")
	require("init")

	local cur = 0
	love.textinput = function(t)
		if not gamestate.state.background then
			return
		end

		local num = tonumber(t)
		if num then
			cur = cur * 10 + num
			print(cur)
			return
		elseif t == "x" then
			cur = math.floor(cur / 10)
			print(cur)
			return
		end

		local d = .025
		local acts
		if t == "r" then
			acts = {1, -d}
		elseif t == "R" then
			acts = {1, d}
		elseif t == "g" then
			acts = {2, -d}
		elseif t == "G" then
			acts = {2, d}
		elseif t == "b" then
			acts = {3, -d}
		elseif t == "B" then
			acts = {3, d}
		end

		if acts then
			if cur ~= 0 then
				local bg = gamestate.state.background[cur]
				if bg then
					bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
					printBGColor(cur, bg.color)
				end
				return
			end

			for id, bg in ipairs(gamestate.state.background) do
				bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
				printBGColor(id, bg.color)
			end
		end
	end
end

function love.draw()
	return gamestate:draw()
end

function love.update(dt)
	return gamestate:update(dt)
end

function love.keypressed(key, scancode)
	if key == "escape" then
		gamestate.to = "quit"
	elseif key == "backspace" then
		gamestate.to = table.remove(gamestate.stack)
	elseif key == "d" then
		if gamestate.state.background then
			f0b.table.print(gamestate.state.background, 10)
		end
	else
		gamestate:keypressed(key, scancode)
	end
end
