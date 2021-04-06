local widgets = f0b.ui.widgets

local function mapCoord(self, x, y)
	return math.floor(y / self.tileH) * self.w
		+ math.floor(x / self.tileW) + 1
end

local function strmapToTable(base)
	local eventMap
	if type(base[1]) == "string" then
		local w, h = #base[1], #base
		for i = 2, h do
			if #base[i] > w then
				w = #base[i]
			end
		end

		eventMap = {
			w = w, h = h,
			ev = base.ev or {},
			places = base.places or {},
			tileW = base.tileW,
			tileH = base.tileH,
			name = false,
		}
		local byte = string.byte
		local start = byte(" ")
		for y = 0, h - 1 do
			local row = base[y+1]
			local yOff = y * w
			for x = 1, #row do
				eventMap[yOff + x] = byte(row, x) - start
			end
			for x = #row + 1, w do
				eventMap[yOff + x] = 0
			end
		end

	else
		eventMap = base
	end

	return eventMap
end

local quadMetatable = {
	__index = function(table, n)
		local tW, tH = table.tW, table.tH
		if type(n) == "number" and n > 0 and n <= tW * tH then
			local y = math.floor((n-1) / tW)
			local x = (n-1) - math.floor(y * tW)
			local tileSize = table.tileSize
			local quad = love.graphics.newQuad(
				x * tileSize, y * tileSize, tileSize, tileSize,
				table.img)
			table[n] = quad
			return quad
		end
	end,
}

local tileCache = setmetatable({}, {
	__index = function(table, key)
		local img = res.img[key]
		local w, h = img:getDimensions()
		local tileSize = 16
		local q = setmetatable(
			{
				img = img,
				tileSize = tileSize,
				tW = w / tileSize,
				tH = h / tileSize
			},
			quadMetatable
		)
		table[key] = q
		return q
	end,
})

local function genBatches(map)
	local nSB = love.graphics.newSpriteBatch
	local byte = string.byte
	local start = byte(" ")
	local batches = {color = map.color or {1,1,1,1}}
	for i = 1, #map do
		local layer = map[i]
		local quads = tileCache[layer.img]
		local tileSize = quads.tileSize
		local batch = nSB(quads.img, quads.tW * quads.tH, "static")
		for y = 0, #layer - 1 do
			local row = layer[y + 1]
			for x = 0, #row - 1 do
				local q = quads[byte(row, x + 1) - start]
				if q then
					batch:add(q, x * tileSize, y * tileSize)
				end
			end
		end
		batches[i] = batch
	end
	return batches
end

local function loadMap(self, name)
	self.eventMap, self.tileBatch = unpack(self.mapCache[name])
end

local eventTypes = {
	oneShot = function(self, event)
		if not event[3] then
			event[3] = true
			return f0b.lisp.push(self.dataStack, event[2])
		end
	end,

	goto = function(self, event)
		loadMap(self, event[2])
		local pos = self.eventMap.places[event[3]]
		self.x = (pos[1] + .5) * self.tileSize
		self.y = (pos[2] + .5) * self.tileSize
	end
}

local function queueEvent(self, idx, evName)
	local evMap = self.eventMap
	local tileEvs = evMap.ev[evMap[idx]]
	if tileEvs then
		local tileEv = tileEvs[evName]
		if tileEv then
			local id = tileEv.var
				or string.format("%q_%d_%q", evMap.name, idx,
					evName)
			local state = self.state[id] or 1
			local ev = tileEv[state] -- Phew
			return eventTypes[ev[1]](self, ev)
		end
	end
end

local function testEvents(self, prevIdx, curIdx, walked)
	if prevIdx ~= curIdx then
		queueEvent(self, curIdx, "enter")
		queueEvent(self, prevIdx, "exit")
	end
	if walked then
		queueEvent(self, curIdx, "step")
	end
end

local function testMove(evMap, x, y)
	if x > 0 and x < evMap.w * evMap.tileW then
		local idx = evMap[mapCoord(evMap, x, y)]
		if idx then
			return idx > 0
		end
	end
	return false
end

local function moveUpdate(self, dt)
	local isDown = love.keyboard.isDown
	local mv = dt * self.tileSize * 2.5
	if isDown("lshift", "rshift") then
		mv = mv * 1.5
	end

	local direction = 0
	local decay = 2/3
	local dX, dY = self.dX * decay, self.dY * decay
	if isDown("up") then
		dY = dY - mv
		direction = 2
	elseif isDown("down") then
		dY = dY + mv
		direction = 1
	end
	if isDown("left") then
		dX = dX - mv
		direction = direction + 3
	elseif isDown("right") then
		dX = dX + mv
		direction = direction + 6
	end

	local oldX = self.x
	local oldY = self.y
	local newX = oldX + dX
	local newY = oldY + dY
	local evMap = self.eventMap
	if testMove(evMap, newX, self.y) then
		self.x = newX
		self.dX = dX
	else
		self.dX = 0
	end
	if testMove(evMap, self.x, newY) then
		self.y = newY
		self.dY = dY
	else
		self.dY = 0
	end

	if direction ~= 0 then
		self.direction = direction
		self.step = self.step + mv / self.tileSize
	end

	return testEvents(self, mapCoord(evMap, oldX, oldY),
		mapCoord(evMap, self.x, self.y), direction ~= 0)
end

local function advanceEvent(self)
	return f0b.lisp.process(self.dataStack, self)
end

local function overworldKeypressed(self, key)
	local textboard = self.ui.textboard
	if textboard.display then
		return widgets.textboard.keypressed(textboard, key)
	else
		self.wait = 0
		return advanceEvent(self)
	end
end

local function overworldUpdate(self, dt)
	local textboard = self.ui.textboard
	if textboard.display then
		if textboard.finished then
			if self.textCont then
				return advanceEvent(self)
			end
		else
			return widgets.textboard.update(textboard, dt)
		end
	elseif #self.dataStack > 0 then
		return advanceEvent(self)
	else
		return moveUpdate(self, dt)
	end
end

local function overworldDraw(self)
	local graphics = love.graphics
	local floor = math.floor

	local halfW, halfH = graphics.getDimensions()
	halfW, halfH = halfW / 2, halfH / 2

	local tileBatch = self.tileBatch
	local xOff, yOff = floor(halfW - self.x), floor(halfH - self.y)

	graphics.setColor(tileBatch.color)
	for i = 1, #tileBatch do
		graphics.draw(tileBatch[i], xOff, yOff)
	end

	local spriteMirror = floor(self.step % 2) * 2 - 1
	graphics.draw(self.player,
		floor(halfW), floor(halfH - self.tileSize),
		0,
		spriteMirror, 1,
		floor(self.player:getWidth() / 2))

	return f0b.ui.draw(self.ui)
end

local function overworldPre(self)
	local logue = require("engine.inst.logue")
	self.dataStack = f0b.lisp.init(logue.typeTable, logue.instructionTable)
	self.player = res.img["player.png"]
	self.pre = nil

	f0b.ui.add(self.ui, "textboard", self.style)
	f0b.jukebox.ops(self.tracks, "set",
		{"pluie", nil, true, source=res.bgm["lluvia.ogg"]}
	)
	f0b.jukebox.ops(self.tracks, "set",
		{"melodia", nil, true, source=res.bgm["melodia.ogg"]}
	)

	return loadMap(self, "house")
end

local mapCacheMetatable = {
	__index = function(t, key)
		local map = love.filesystem.load("data/" .. key .. ".lua")()
		local eventMap = strmapToTable(map[1])
		eventMap.name = key

		if not map[1].img then
			table.remove(map, 1)
		end

		local batches = genBatches(map)
		t[key] = {eventMap, batches}
		return t[key]
	end,
}

return {
	new = function(style)
		local tileSize = 16
		return {
			draw = overworldDraw,
			update = overworldUpdate,
			keypressed = overworldKeypressed,
			pre = overworldPre,

			x = tileSize,
			y = tileSize,
			tileSize = tileSize,
			dX = 0,
			dY = 0,
			direction = 1,
			step = 1,

			style = style,
			tracks = {},
			player = nil,
			map = nil,
			tileBatch = nil,
			dataStack = nil,
			state = {},
			ui = {},
			mapCache = setmetatable({}, mapCacheMetatable),
		}
	end,
}
