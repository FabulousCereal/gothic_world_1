local function transitionExec(self, dt)
	local color = self.transitionColor
	-- Apparently, calling setVolume(1 - color[4]) makes all
	-- subsequent calls to source:play() return false, for reasons unknown
	local alpha = color[4] + dt
	if alpha < 1 then
		love.audio.setVolume(1 - alpha)
		color[4] = alpha
	else
		if self.state.tracks then
			f0b.jukebox.ops(self.state.tracks, "cmdall", {"stop"})
		end
		if self.state.post then
			self.state:post()
		end

		newState = self[self.to]
		love.graphics.setBackgroundColor(
			newState.backgroundColor or {0, 0, 0, 1})
		if newState.pre then
			newState:pre(self.preSwitchArgs)
			self.preSwitchArgs = nil
		end
		if newState.tracks then
			f0b.jukebox.ops(newState.tracks, "cmdall", {"play"})
		end
		self.state = newState

		love.audio.setVolume(1)
		color[4] = 0
		self.to = nil
	end
end

gamestate = {
	keypressed = function(gs, key)
		if not gs.to and gs.state.keypressed then
			gs.state:keypressed(key)
		end
	end,

	update = function(gs, dt)
		local state = gs.state

		if gs.to then
			return transitionExec(gs, dt)
		else
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
	end,

	draw = function(gs)
		local state = gs.state
		local graphics = love.graphics

		if state.background then
			f0b.layers.draw(state.background)
		end
		if state.draw then
			state:draw()
		end

		if gs.to then
			graphics.setColor(gs.transitionColor)
			graphics.draw(unpack(f0b.elem.screenFill))
		end
	end,

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

