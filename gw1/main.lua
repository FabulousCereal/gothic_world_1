local function printBGColor(id, bgColor)
	print(string.format("%u - r:%.2f, g:%.2f, b:%.2f",
		id, bgColor[1], bgColor[2], bgColor[3]))
end

function love.load()
	love.setDeprecationOutput(true)
--	love.graphics.setDefaultFilter("linear", "linear")
--	love.graphics.setLineStyle("rough")
	love.keyboard.setKeyRepeat(true)
	love.keyboard.setTextInput(true)

	f0b = require("f0ball")
	lib = require("assets")
	common = require("common")
	gamestate = require("gamestate")
	stateSetup = require("setup")

	local gs = stateSetup(gamestate.create())

	love.draw = function()
		return gamestate.draw(gs)
	end

	love.update = function(dt)
		return gamestate.update(gs, dt)
	end

	love.keypressed = function(key, scancode)
		if key == "escape" then
			gs.to = "quit"
		elseif key == "backspace" then
			gs.to = table.remove(gs.stack)
		elseif key == "d" then
			if gs.state.background then
				for id, bg in ipairs(gs.state.background) do
					printBGColor(id, bg.color)
				end
			end
		else
			gamestate.keypressed(gs, key)
		end
	end

	local cur = 0
	love.textinput = function(t)
		if not gs.state.background then
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
				local bg = gs.state.background[cur]
				if bg then
					bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
					printBGColor(cur, bg.color)
					return
				end
			end

			for id, bg in ipairs(gs.state.background) do
				bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
				printBGColor(id, bg.color)
			end
		end
	end
end
