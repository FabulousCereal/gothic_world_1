function love.load()
	love.setDeprecationOutput(true)
--	love.graphics.setDefaultFilter("linear", "linear")
--	love.graphics.setLineStyle("rough")

	f0b = require("f0ball")
	lib = require("assets")
	common = require("common")
	gameState = require("gamestate")
end

function love.draw()
	local state = gameState.state

	if #state.background > 0 then
		f0b.layers.draw(state.background)
	end
	state:draw()
	if gameState.to ~= gameState.cur then
		love.graphics.setColor(gameState.transitionColor)
		love.graphics.rectangle(unpack(common.screenCover))
	end
end

function love.update(dt)
	local state = gameState.state

	if state.stateSwitch then
		gameState:setTransition(state.stateSwitch)
		state.stateSwitch = false
	end

	if gameState.to ~= gameState.cur then
		return gameState:execTransition(dt)
	elseif state.update then
		if state.background and #state.background > 0 then
			f0b.layers.update(state.background, dt)
		end
		if state.tracks then
			f0b.jukebox.update(state.tracks, dt)
		end
		return state:update(dt)
	end
end

function love.keypressed(key)
	if key == "escape" then
		gameState.to = "quit"
--		gameState.to = table.remove(gameState.stack)
	elseif gameState.state.keypressed then
		return gameState.state:keypressed(key)
	end
end
