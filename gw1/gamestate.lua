local function transitionExec(self, dt)
	local color = self.transitionColor
	-- Apparently, calling setVolume(1 - table[n]) makes all
	-- subsequent calls to source:play() return false, for reasons unknown
	local alpha = color[4] + dt
	if alpha < 1 then
		love.audio.setVolume(1 - alpha)
		color[4] = alpha
	else
		if self.to == "quit" then
			love.event.quit()
		else
			if self.state.tracks then
				f0b.jukebox.ops(self.state.tracks,
					{"cmdall", "pause"})
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
				f0b.jukebox.ops(newState.tracks,
					{"cmdall", "play"})
			end
			self.state = newState

			love.audio.setVolume(1)
			color[4] = 0
			self.to = nil
		end
	end
end

local function transitionSet(self, newStateID, args)
	local state = self.state
	self.preSwitchArgs = args

	if not newStateID or newStateID == true then
		self.to = table.remove(self.stack)
	else
		self.stack[#self.stack + 1] = state.id
		self.to = newStateID
	end
end

return {
	keypressed = function(gs, key)
		if not gs.to then
			return gs.state:keypressed(key)
		end
	end,

	update = function(gs, dt)
		local state = gs.state

		if gs.to then
			return transitionExec(gs, dt)
		else
			if state.background and #state.background > 0 then
				f0b.layers.update(state.background, dt)
			end
			if state.tracks then
				f0b.jukebox.update(state.tracks, dt)
			end
			if state.update then
				return state:update(dt)
			end
		end
	end,

	draw = function(gs)
		local state = gs.state
		local graphics = love.graphics

		if state.background and #state.background > 0 then
			f0b.layers.draw(state.background)
		end
		if state.draw then
			state:draw()
		end

		if gs.to then
			graphics.setColor(gs.transitionColor)
			graphics.draw(unpack(common.screenCover))
		end
	end,

	add = function(gs, engine, id, initial)
		if id == nil then
			id = #gs + 1
		end
		engine.id = id
		engine.stateSwitch = gs.stateSwitchFunc
		gs[id] = engine
		if initial then
			gs.state = engine
			if engine.pre then
				engine:pre()
			end
		end
		return id
	end,

	create = function()
		local gs = {
			transitionColor = {0,0,0,0},
			stack = {"quit"},
			state = nil,
			to = nil,
			preSwitchArgs = nil,
			stateSwitchFunc = nil,
		}

		gs.stateSwitchFunc = function(to, args)
			return transitionSet(gs, to, args)
		end

		return gs
	end,
}
