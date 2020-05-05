local function loadStage(filename)
	local stage = require("data." .. filename)
	return f0b.tableIter.new(stage)
end

local function nextStage(iter)
	local result, segue = f0b.std.next(iter)
	if result then
		local stageIdx = iter[3]
		local filename = result[2]
		return loadStage(filename), stageIdx, segue
	else
		return nil, {1,1}, nil
	end
end

local function addInstructions(dataIters, table)
	dataIters[#dataIters + 1] = f0b.tableIter.new(table)
end

local function externalOps(opFunc, target, inst)
	local copy = f0b.std.basicDeepCopy(inst)
	table.remove(copy, 1)
	return opFunc(target, copy)
end

local instructionTable = {
	nop = function() end,

	wait = function(vn, line)
		vn.wait, vn.unskippable = unpack(line, 2)
		vn.uiDisplay = false
		return false
	end,

	name = function(vn, line)
		f0b.textboard.setName(vn.ui, vn.style, line[2])
	end,

	style = function(vn, line)
		vn.style = line[2]
		f0b.textboard.recalc(vn.ui, line[2], vn.lines)
	end,

	bg = function(vn, line)
		externalOps(f0b.layers.ops, vn.background, line)
	end,

	bgm = function(vn, line)
		externalOps(f0b.jukebox.ops, vn.tracks, line)
	end,

	sfx = function(vn, line)
		local sfx = lib.sfx[line[2]]
		local vol = line[3] or 1
		sfx:setVolume(vol)
		love.audio.play(sfx)
	end,

	gen = function(vn, line)
		addInstructions(vn.dataIters, line.exec(line.args))
		return true
	end,

	read = function(vn, line)
		addInstructions(vn.dataIters, line[2])
		return true
	end,

	var = function(vn, line)
		vn.vars[line[2]] = line[3]
	end,

	select = function(vn, line)
		local options
		if type(line[2]) == "table" then
			vn.selectTarget = nil
			options = line[2]
		else
			vn.selectTarget = line[2]
			options = line[3]
		end

		local noNewlines = {}
		for i = 1, #options do
			noNewlines[i] = string.gsub(options[i], "\n+%s*", " ")
		end

		f0b.textboard.setSelect(vn.ui, vn.style, noNewlines)
		vn.uiDisplay = true
		return false
	end,

	case = function(vn, line)
		local idx
		local case
		if type(line[2]) == "string" then
			local varName = line[2]
			idx = vn.vars[varName]
			case = line[3]
		else
			idx = table.remove(vn.vars)
			case = line[2]
		end
		addInstructions(vn.dataIters, case[idx])
		return true
	end,

	retear = function(vn, line)
		local len = #vn.dataIters
		vn.dataIters[len], vn.dataIters[len - 1] = nil, nil
		return true
	end
}

local function advanceVN2(self)
	for inst in self.dataIters[#self.dataIters] do
		local iType = type(inst)
		if iType == "string" then
			f0b.typewriter.setup(self.ui.text, self.style.font, inst)
			self.uiDisplay = true
			return
		elseif iType == "table" then
			local op = inst[1]
			local val = instructionTable[op](self, inst)
			if val == false then
				return
			elseif val == true then
				-- instruction stack has been modified
				return advanceVN2(self)
			end
		elseif iType == "boolean" then
			if inst == false then
				self.uiDisplay = false
				return
			end
		end
	end
	-- Iterator exhausted

	if #self.dataIters > 1 then
		self.dataIters[#self.dataIters] = nil
		return advanceVN2(self)
	else
		self.dataIters[1], self.cur, segue = nextStage(self.stage)
		if self.dataIters[1] then
			self.ui.namebox[3] = 0
			self.uiDisplay = false
			if segue then
				return advanceVN2(self)
			else
				return self.stateSwitch(true)
			end
		else
			return self.stateSwitch(true)
		end
	end
end

local function vnKeypressed(self, key)
	local ui = self.ui

	if ui.select.options then
		local val = f0b.textboard.keypress(ui, key)
		if val ~= nil then
			if self.selectTarget ~= nil then
				self.vars[self.selectTarget] = val
			else
				self.vars[#self.vars + 1] = val
			end
			return advanceVN2(self)
		end
	elseif (key == "return" or key == "space") and not self.unskippable then
		self.wait = 0
		if not self.uiDisplay or ui.text.finished then
			return advanceVN2(self)
		else
			return f0b.typewriter.finish(ui.text)
		end
	end
end

local function vnUpdate(self, dt)
	if self.wait > 0 then
		self.wait = self.wait - dt
		if self.wait <= 0 then
			self.unskippable = false
			return advanceVN2(self)
		end
	elseif self.uiDisplay and not self.ui.text.finished then
		local timer = self.textTimer
		if timer <= 0 then
			local char = f0b.typewriter.advance(self.ui.text)
			if char then
				timer = lib.chrono.textSpeed
				if string.find(",.?!:;~", char, 1, true) then
					timer = timer * 4
				end
			end
		end
		self.textTimer = timer - dt
	end	
end

local function vnDraw(self)
	if self.uiDisplay then
		return f0b.textboard.draw(self.ui, self.style)
	end
end

local function stageIter(stageTable, cur)
	local chapter, section
	if not cur then
		chapter, section = 1, 1
	else
		chapter, section = cur[1], cur[2] + 1
	end

	local segue = true
	if section > #stageTable[chapter] then
		segue = stageTable[chapter].segue
		section = 1

		repeat 
			chapter = chapter + 1
			if chapter > #stageTable then
				return nil
			end
		until #stageTable[chapter] > 0
	end

	local result = stageTable[chapter][section]
	if result then
		return {chapter, section}, result, segue
	else
		return nil
	end
end

local function vnPreCommon(self, chapter, section)
	local filename = lib.index[chapter][section][2]
	self.dataIters[1] = loadStage(filename)
	return advanceVN2(self)
end

local function vnPreStarted(self, stage)
	if stage then
		local chapter, section = unpack(stage)
		if self.cur[1] ~= chapter or self.cur[2] ~= section then
			f0b.jukebox.ops(self.tracks, {"clear"})
			f0b.layers.ops(self.background, {"clear"})
			self.wait = 0

			self.cur[1], self.cur[2] = chapter, section
			self.stage[3] = self.cur

			return vnPreCommon(self, chapter, section)
		end
	end
end

local function vnPreInit(self, stage)
	self.ui = f0b.textboard.new(self.style, self.lines)

	local chapter, section
	if stage then
		chapter, section = unpack(stage)
		self.cur[1], self.cur[2] = chapter, section
		self.stage[3] = self.cur
	else
		chapter, section = unpack(self.cur)
	end
	return vnPreCommon(self, chapter, section)
end

return {
	new = function(style, lines)
		local startStage = {1, 1}
		return {
			draw = vnDraw,
			update = vnUpdate,
			keypressed = vnKeypressed,
			pre = vnPreInit,

			background = {},
			tracks = {},

			style = style,
			lines = lines or 4,
			textTimer = 0,
			wait = 0,
			unskippable = false,
			vars = {},
			selectTarget = nil,

			ui = nil,
			uiDisplay = false,
			cur = startStage,
			stage = {stageIter, lib.index, startStage},
			dataIters = {},
		}
	end,
}
