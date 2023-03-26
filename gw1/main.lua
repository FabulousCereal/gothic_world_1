-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

gamestate = {
	add = function(gs, engine, id, initial)
		if id == nil then
			id = #gs + 1
		end
		assert(gs[id] == nil,
			"Name (" .. id .. ") already in use with gamestate")
		engine.id = id
		gs[id] = engine
		if initial then
			gs.state = engine
			if engine.pre then
				engine:pre()
			end
			love.graphics.setBackgroundColor(
				engine.backgroundColor or {0, 0, 0, 1})
		end
		return id
	end,

	stateSwitch = function(self, newStateID, args)
		self.preSwitchArgs = args
		if not newStateID or newStateID == true then
			self.to = table.remove(self.stack)
		else
			table.insert(self.stack, self.state.id)
			self.to = newStateID
		end
	end,

	nextID = function(gs, prevReserved)
		return (prevReserved or #gs) + 1
	end,

	transitionColor = {0,0,0,0},
	stack = {"quit"},
	state = nil,
	to = nil,
	preSwitchArgs = nil,

	quit = {
		pre = function()
			return love.event.quit()
		end,
	},
}

local function transitionExec(dt)
	local color = gamestate.transitionColor
	-- Apparently, calling setVolume(1 - color[4]) makes all
	-- subsequent calls to source:play() return false, for reasons unknown
	local alpha = color[4] + dt * 1.2
	if alpha < 1 then
		love.audio.setVolume(1 - alpha)
		color[4] = alpha
	else
		local state = gamestate.state
		if state.tracks then
			f0b.jukebox.ops(state.tracks, "cmdall", {"stop"})
		end
		if state.post then
			state:post()
		end

		newState = gamestate[gamestate.to]
		love.graphics.setBackgroundColor(
			newState.backgroundColor or {0, 0, 0, 1})
		if newState.pre then
			newState:pre(gamestate.preSwitchArgs)
			gamestate.preSwitchArgs = nil
		end
		if newState.tracks then
			f0b.jukebox.ops(newState.tracks, "cmdall", {"play"})
		end
		gamestate.state = newState

		love.audio.setVolume(1)
		color[4] = 0
		gamestate.to = nil
	end
end

local function printBGColor(id, bgColor)
	print(string.format("%u - r:%.2f, g:%.2f, b:%.2f",
		id, bgColor[1], bgColor[2], bgColor[3]))
end

function love.load()
	love.setDeprecationOutput(true)
	love.keyboard.setKeyRepeat(true)
	love.keyboard.setTextInput(true)

	require("f0ball")
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

		local background = gamestate.state.background
		if acts and background then
			if cur ~= 0 then
				local bg = background[cur]
				if bg then
					bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
					printBGColor(cur, bg.color)
				end
				return
			end

			for id, bg in ipairs(background) do
				bg.color[acts[1]] = bg.color[acts[1]] + acts[2]
				printBGColor(id, bg.color)
			end
		end
	end
end

function love.draw()
	local state = gamestate.state
	local graphics = love.graphics

	if state.background then
		f0b.layers.draw(state.background)
	end
	if state.draw then
		state:draw()
	end

	if gamestate.to then
		graphics.setColor(gamestate.transitionColor)
		graphics.draw(unpack(f0b.elem.screenFill))
	end
end

function love.update(dt)
	if gamestate.to then
		return transitionExec(dt)
	else
		local state = gamestate.state
		if state.background then
			f0b.layers.update(state.background, dt)
		end
		if state.tracks then
			f0b.jukebox.update(state.tracks, dt)
		end
		if state.update then
			state:update(dt)
		end
	end
end

function love.keypressed(key, ...)
	if key == "escape" then
		gamestate.to = "quit"
	elseif key == "backspace" then
		gamestate.to = table.remove(gamestate.stack)
	elseif key == "d" then
		if gamestate.state.background then
			f0b.table.print(gamestate.state.background, 10)
		end
	else
		gamestate.keypressed(key, ...)
	end
end

local function giveInput(callback)
	return function(...)
		local state = gamestate.state
		local fn = state[callback]
		if fn and not gamestate.to then
			return fn(state, ...)
		end
	end
end

gamestate.keypressed = giveInput("keypressed")
local callbacks = {"mousemoved", "mousepressed"}
for i, cb in pairs(callbacks) do
	love[cb] = giveInput(cb)
end
