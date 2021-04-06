local widgets = f0b.ui.widgets

local function stateReset(vn, fullClear)
	vn.wait = 0
	vn.returnValue = nil
	vn.textCont = false
	vn.unskippable = false
	vn.selectTarget = false

	local ui = vn.ui
	ui.select.display = false
	ui.textboard.display = false
	widgets.textboard.setName(ui.textboard, false)
	if fullClear then
		f0b.jukebox.ops(vn.tracks, "clear")
		f0b.layers.ops(vn.background, "clear")
	end
end

local function loadStage(filename)
	local path = "data/" .. filename .. ".lua"
	return love.filesystem.load(path)()
end

local function getStage(index, cur, offset)
	cur[2] = cur[2] + offset

	local segue = true
	if cur[2] > #index[cur[1]] then
		segue = index[cur[1]].segue
		repeat
			cur[1] = cur[1] + 1
			if cur[1] > #index then
				return nil
			end
			cur[2] = 1
		until cur[2] <= #index[cur[1]]
	end

	local filename = index[cur[1]][cur[2]][2]
	return loadStage(filename), segue
end

local function externalOps(opFunc, target, inst)
	local copy = f0b.table.deepCopy(inst)
	local op = table.remove(copy, 2)
	table.remove(copy, 1)
	return opFunc(target, op, copy)
end

local instructionTable = {
	nop = function() end,

	style = function(line, vn)
		vn.style = res.style[line[2]]
		f0b.ui.regen(vn.ui, vn.style)
	end,

	sfx = function(line)
		local sfx = res.sfx[line[2]]
		sfx:setVolume(line[3] or 1)
		love.audio.play(sfx)
	end,

	bg = function(line, vn)
		externalOps(f0b.layers.ops, vn.background, line)
	end,

	bgm = function(line, vn)
		externalOps(f0b.jukebox.ops, vn.tracks, line)
	end,

	var = function(line, vn)
		local idx = line[2]
		if idx == nil then
			idx = #vn.vars + 1
		end
		vn.vars[idx] = line[3]
	end,

	global = function(line, vn)
		local dst = line[3]
		local src = line[4] or dst
		if line[2] == "get" then
			vn.vars[dst] = vn.gVars[src]
		elseif line[2] == "set" then
			vn.gVars[dst] = vn.vars[src]
		end
	end,

	select = function(line, vn)
		local options
		if type(line[2]) == "table" then
			vn.selectTarget = nil
			options = line[2]
		else
			vn.selectTarget = line[2]
			options = line[3]
		end

		widgets.select.set(vn.ui.select, options)
		return true
	end,

	case = function(line, vn)
		local var
		local caseIdx = 2
		if type(line[2]) == "table" then
			var = table.remove(vn.vars)
		else
			var = vn.vars[line[2]]
			caseIdx = caseIdx + 1
		end

		local case = line[caseIdx]
		local default = line[caseIdx + 1]

		local data = case[var]
		if not data and default then
			data = default[var]
		end

		if data then
			f0b.lisp.push(vn.dataStack, data)
		end
	end,

	map = function(line, vn)
		vn.vars[line[2]] = line[3][line[2]]
	end,

	macro = function(line, vn)
		f0b.lisp.push(vn.dataStack, line[2](line[3]))
	end,

	read = function(line, vn)
		f0b.lisp.push(vn.dataStack, line[2])
	end,

	loop = function(line, vn)
		f0b.lisp.push(vn.dataStack, line[2], true)
	end,

	retear = function(line, vn)
		f0b.lisp.pop(vn.dataStack, line[2])
	end,

	["break"] = function(_, vn)
		f0b.lisp["break"](vn.dataStack)
	end,

	["return"] = function(line, vn)
		f0b.lisp.unwind(vn.dataStack)
		vn.returnValue = line[2]
	end,
}

local function advanceVN2(self)
	self.ui.textboard.display = false
	if f0b.lisp.process(self.dataStack, self) then
		return
	end

	if self.returnValue == false then
		f0b.lisp.restart(self.dataStack)
	else
		f0b.lisp.unwind(self.dataStack)
		local stage, segue = getStage(self.index, self.cur, 1)
		if stage then
			f0b.lisp.push(self.dataStack, stage)
			if segue then
				stateReset(self, false)
				return advanceVN2(self)
			end
		end
	end
	stateReset(self, true)
	return gamestate:stateSwitch(true)
end

local function vnKeypressed(self, key)
	local ui = self.ui
	if ui.select.display then
		local val = widgets.select.keypress(ui.select, key)
		if val ~= nil then
			ui.select.display = false
			local idx
			if self.selectTarget ~= nil then
				idx = self.selectTarget
			else
				idx = #self.vars + 1
			end
			self.vars[idx] = val
			return advanceVN2(self)
		end
	elseif not ui.textboard.finished then
		return widgets.textboard.keypressed(ui.textboard, key)
	elseif not self.unskippable and (key == "space" or key == "return") then
		self.wait = 0
		return advanceVN2(self)
	end
end

local function vnUpdate(self, dt)
	if self.wait > 0 then
		self.wait = self.wait - dt
	elseif not self.ui.select.display then
		local textboard = self.ui.textboard
		if textboard.display then
			if textboard.finished then
				self.unskippable = false
				if self.textCont then
					return advanceVN2(self)
				end
			else
				return widgets.textboard.update(textboard, dt)
			end
		else
			self.unskippable = false
			return advanceVN2(self)
		end
	end	
end

local function vnDraw(self)
	return f0b.ui.draw(self.ui)
end

local function vnPreCommon(self)
	local stage = getStage(self.index, self.cur, 0)
	f0b.lisp.push(self.dataStack, stage)
	return advanceVN2(self)
end

local function vnPreInitiated(self, stage)
	if stage then
		local chapter, section = unpack(stage)
		local cur = self.cur
		if cur[1] ~= chapter or cur[2] ~= section then
			stateReset(self, true)

			cur[1], cur[2] = chapter, section
			return vnPreCommon(self)
		end
	end
end

local function vnPreInit(self, stage)
	local logue = require("engine.inst.logue")
	self.dataStack = f0b.lisp.init(logue.typeTable,
		f0b.table.union(logue.instructionTable, instructionTable))

	f0b.ui.add(self.ui, "textboard", self.style)
	f0b.ui.add(self.ui, "select", self.style)

	if stage then
		self.cur[1], self.cur[2] = unpack(stage)
	end
	self.pre = vnPreInitiated
	return vnPreCommon(self)
end

return {
	new = function(index, style)
		local startStage = {1, 1}
		local globalVars = {}
		return {
			draw = vnDraw,
			update = vnUpdate,
			keypressed = vnKeypressed,
			pre = vnPreInit,

			background = {},
			tracks = {},

			style = style,
			index = index,

			unskippable = false,
			textCont = false,
			wait = 0,
			selectTarget = nil,
			returnValue = nil,
			gVars = globalVars,
			vars = setmetatable({}, {
				__index = function(t, k)
					local g = globalVars[k]
					t[k] = g
					return g
				end,
			}),

			ui = {},
			cur = {1,1},
			dataStack = nil, --{},
		}
	end,
}
