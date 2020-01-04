local function setStage(n)
	local file = lib.stages[n]
	if file then
		local data = require(file)
		data.cur = 1
		return data
	else
		return nil
	end
end

local function insertInst(data, lines)
	local cur = data.cur
	for i = 1, #lines do
		table.insert(data, cur + i, lines[i])
	end
end

local instructionTable = {
	nop = function() end,

	wait = function(vn, line)
		vn.wait, vn.unskippable = unpack(line)
		return true
	end,

	name = function(vn, line)
		vn.ui:updateName(vn.style, line[1])
	end,

	style = function(vn, line)
		f0b.textboard.recalc(vn.ui, line[1], 4)
		vn.style = line[1]
	end,

	bg = function(vn, line)
		f0b.layers.ops(vn.background, line)
	end,

	bgm = function(vn, line)
		f0b.jukebox.ops(vn.tracks, line)
	end,

	sfx = function(vn, line)
		love.audio.play(lib.sfx[line[1]])
	end,

	gen = function(vn, line)
		insertInst(vn.data, line.exec(line.args))
	end,

	select = function(vn, line)
		vn.ui:setSelect(vn.style, line)
		return true
	end,

	case = function(vn, line)
		local path
		if type(line[1]) == "string" then
			local idx = table.remove(line, 1)
			path = vn.vars[idx]
		else
			path = table.remove(vn.vars)
		end
		insertInst(vn.data, line[path])
	end,
}

local function advanceVN(self)
	local data = self.data
	local ui = self.ui
	if data.cur <= #data then
		local line = data[data.cur]

		while type(line) == "table" do
			local op = table.remove(line, 1)

			if instructionTable[op](self, line) then
				break
			end

			data.cur = data.cur + 1
			line = data[data.cur]
		end

		if type(line) == "string" then
			f0b.typewriter.setup(ui.text, self.style, line)
			ui.show = true
		elseif ui.select.options then
			ui.show = true
		elseif data.cur > #data then
			return advanceVN(self)
		else
			ui.show = false
		end
		data.cur = data.cur + 1
	else
		self.stage = self.stage + 1
		self.data = setStage(self.stage)
		if self.data then
			ui.namebox[3] = 0
			ui.show = false
			return advanceVN(self)
		else
			self.stateSwitch = true
		end
	end
end

local function vnKeypressed(self, key)
	local ui = self.ui

	if ui.select.options then
		local select = ui.select
		if key == "return" then
			local val = select.cur + 1
			if select.options.varName then
				self.vars[select.options.varName] = val
			else
				self.vars[#self.vars + 1] = val
			end
			select.options = false
			return advanceVN(self)
		elseif key == "up" then
			select.cur = ((select.cur + 1) % #select.options)
		elseif key == "down" then
			select.cur = ((select.cur - 1) % #select.options)
		end
	elseif not self.unskippable and (key == "return" or key == "space") then
		self.wait = 0
		if not ui.show or ui.text.finished then
			return advanceVN(self)
		else
			return f0b.typewriter.finish(ui.text, self.style)
		end
	end
end

local function vnUpdate(self, dt)
	if self.wait > 0 then
		self.wait = self.wait - dt
		if self.wait <= 0 then
			self.unskippable = false
			return advanceVN(self)
		end
	elseif self.ui.show and not self.ui.text.finished then
		local timer = self.timer
		if timer <= 0 then
			local char = f0b.typewriter.advance(
				self.ui.text, self.style)
			if char then
				timer = lib.style.chrono.textSpeed
				if string.find(",.:?!;", char, 1, true) then
					timer = timer * 4
				end
			end
		end
		self.timer = timer - dt
	end	
end

local function vnDraw(self)
	if self.ui.show then
		return self.ui:draw(self.style)
	end
end

local function vnStart(self)
	if not self.data then
		self.stage = 1
		self.data = setStage(1)
		advanceVN(self)
	end
end

return {
	newEngine = function(lines, style)
		return {
			draw = vnDraw,
			update = vnUpdate,
			keypressed = vnKeypressed,
			pre = vnStart,

			background = {},
			tracks = {},

			ui = f0b.textboard.newBoard(style, lines),
			style = style,
			timer = 0,
			wait = 0,
			unskippable = false,
			vars = {},

			returnControl = false,
		}
	end,
}
