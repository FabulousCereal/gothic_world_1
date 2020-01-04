local function transitionExec(self, dt)
	local color = self.transitionColor
	-- Apparently, calling setVolume(1 - table[n]) makes all
	-- subsequent calls to source:play() return false, regardless of
	-- the value of table[n].
	local alpha = color[4] + dt
	if alpha < 1 then
		love.audio.setVolume(1 - alpha)
		color[4] = color[4] + dt
	else
		if self.to == "quit" then
			love.event.quit()
		else
			if self.state.tracks then
				f0b.jukebox.ops(self.state.tracks, {"clear"})
			end
			self.cur = self.to
			self.state = self[self.cur]
			if self.state.pre then
				self.state:pre()
			end

			color[4] = 0
			love.audio.setVolume(1)
		end
	end
end

local function transitionSet(self, newState)
	if type(newState) == "string" then
		self.stack[#self.stack + 1] = self.cur
		self.to = newState
	elseif newState == true then
		self.to = table.remove(self.stack)
	end
end

local function setMenus()
	local colors = {{1, 0, 0, 1}, {0.5, 0, 0.5, 1}}
	local mEntries = {
		{name="Comenzar", color=1, to="vn", args=false},
		{name="Configuración", color=1, to="confMenu", args=false},
		{name="Salir", color=1, to=true, args=false},
	}
	local cEntries = {
		{name="Resolución", color=2},
		{name="Música", color=2},
		{name="Volver", color=1, to=true, args=false},
	}

	local mMenu, cMenu
	mMenu = f0b.menus.newMenu(mEntries, lib.style.menu, colors, 2, {64,64})
	cMenu = f0b.menus.newMenu(cEntries, lib.style.menu, colors, 2, {480,360})

	mMenu.background = {
		{exec=love.graphics.circle, args={"fill", 480, 360, 5},
			color = {1,1,1,1}
		},
	}
	cMenu.background = {
		{exec=love.graphics.circle, args={"line", 240, 180, 20}, 
			color={1,1,1,1}
		},
	}

	return mMenu, cMenu
end

local gameState = {
	transitionColor = {0,0,0,0},
	stack = {"quit"},
	cur = "mainMenu",
	to = "mainMenu",

	execTransition = transitionExec,
	setTransition = transitionSet,
}

gameState.mainMenu, gameState.confMenu = setMenus()

local vn = require("engine.vn")
gameState.vn = vn.newEngine(4, lib.style.vnDefault)

gameState.state = gameState.mainMenu

return gameState
