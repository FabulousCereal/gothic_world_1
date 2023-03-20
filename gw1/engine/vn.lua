-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local widgets = f0b.ui.widgets

local function initVars(vn)
	local c1, c2 = unpack(vn.cur)
	local chap = vn.index[c1]
	vn.vars["_idx1"] = c1 - vn.index.offset
	vn.vars["_idx2"] = c2
	vn.vars["_title1"] = chap.name
	vn.vars["_title2"] = chap[c2][1]
end	

local function stateReset(vn, keepRes)
	vn.wait = 0
	vn.returnValue = nil
	vn.textCont = false
	vn.unskippable = false
	vn.selectTarget = false
	f0b.table.clear(vn.vars)
	f0b.table.clear(vn.settings)
	initVars(vn)

	local ui = vn.ui
	ui.select.display = false
	ui.textboard.display = false
	widgets.textboard.setName(ui.textboard, false)
	if not keepRes then
		f0b.jukebox.ops(vn.tracks, "rmall")
		f0b.layers.ops(vn.background, "rmall")
	end
end

local function loadStage(dir, file, style)
	local path = {res.dataPath}
	if dir then
		table.insert(path, dir)
		table.insert(path, "/")
	end
	table.insert(path, file)
	table.insert(path, ".lua")

	name = table.concat(path)
	local ok, result = pcall(f0b.std.dofile, name)
	if ok then
		return result
	end

	result = name .. ": Load failed\n\n" .. result
	local graphics = love.graphics
	local text = graphics.newText(style.font)
	text:setf(result, graphics.getWidth(), "left")
	return {
		{"bg", "add", args={text}},
		[[Carga fallida. El documento podría estar mal escrito.]],
		{"bg", "rm"},
		{"return", false}
	}
end

local function getStage(self, offset)
	local index, cur = self.index, self.cur
	cur[2] = cur[2] + offset

	-- Implement test as a loop to handle empty chapters
	while cur[2] > #index[cur[1]] do
		cur[1] = cur[1] + 1
		if cur[1] > #index then
			return nil
		end
		cur[2] = 1
	end

	local chapter = index[cur[1]]
	local dir = chapter.dir
	local file = chapter[cur[2]][2]
	return loadStage(dir, file, self.style)
end

local function externalOps(opFunc, target, inst)
	local copy = f0b.table.deepCopy(inst)
	local op = table.remove(copy, 2)
	local _ = table.remove(copy, 1)
	return opFunc.ops(target, op, copy)
end

local instructionTable = {
	nop = function() end,

	style = function(line, vn)
		vn.style = res.style[line[2]]
		f0b.ui.regen(vn.ui, vn.style)
	end,

	sfx = function(line)
		local sfx = res.sfx(line[2])
		sfx:setVolume(line[3] or 1)
		love.audio.play(sfx)
	end,

	bg = function(line, vn)
		externalOps(f0b.layers, vn.background, line)
	end,

	bgm = function(line, vn)
		externalOps(f0b.jukebox, vn.tracks, line)
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
		vn.selectTarget = line[2]
		widgets.select.set(vn.ui.select, line[3])
		return true
	end,

	case = function(line, vn)
		local name = line[2]
		local var
		if name == nil then
			var = table.remove(vn.vars)
		else
			var = vn.vars[name]
		end

		local cases = line[3]
		local default = line[4]

		local data = cases[var]
		if not data and default then
			data = default
		end

		if data then
			f0b.lisp.push(vn.dataStack, data)
		end
	end,

	map = function(line, vn)
		vn.vars[line[2]] = line[3][line[2]]
	end,

	macro = function(line, vn)
		f0b.lisp.push(vn.dataStack,
			line[2](vn.vars, vn.gVars, unpack(line, 3)))
	end,

	read = function(line, vn)
		f0b.lisp.push(vn.dataStack, line[2], line[3])
	end,

	retear = function(line, vn)
		f0b.lisp.pop(vn.dataStack, line[2])
	end,

	["break"] = function(_, vn)
		f0b.lisp["break"](vn.dataStack)
	end,

	["return"] = function(line, vn)
		f0b.lisp.clear(vn.dataStack)
		vn.returnValue = line[2]
	end,

	settings = function(line, vn)
		vn.settings[line[2]] = line[3]
	end,
}

local function advanceVN2(self)
	self.ui.textboard.display = false
	if f0b.lisp.process(self.dataStack, self) then
		return
	end

	if self.returnValue == false then
		f0b.lisp.rewind(self.dataStack)
	else
		local stage = getStage(self, 1)
		if stage then
			f0b.lisp.set(self.dataStack, stage)
			stateReset(self, self.settings.keepRes)
			return advanceVN2(self)
		end
	end
	stateReset(self, false)
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
		local tb = self.ui.textboard
		if tb.display then
			if tb.finished then
				self.unskippable = false
				if self.textCont then
					return advanceVN2(self)
				end
			else
				return widgets.textboard.update(tb, dt)
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

local function vnPreCommon(self, fullReset)
	local stage = getStage(self, 0)
	f0b.lisp.set(self.dataStack, stage)
	stateReset(self, fullReset)
	return advanceVN2(self)
end

local function vnPreInitiated(self, stage)
	if stage then
		local chapter, section = unpack(stage)
		local cur = self.cur
		self.cur[1], self.cur[2] = chapter, section
		return vnPreCommon(self, false)
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
	return vnPreCommon(self, false)
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
			settings = f0b.table.struct({keepRes = true}),
			gVars = globalVars,
			vars = setmetatable({}, {
				__index = function(t, k)
					local v = globalVars[k]
					t[k] = v
					return v
				end,
			}),

			ui = {},
			cur = {1,1},
			dataStack = nil, --{},
		}
	end,
}
