-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local widgets = require("f0b.ui").widgets

local function initVars(vn)
	local vars = f0b.table.struct.new({"_idx1", "_idx2", "_title1", "_title2"})
	local c1, c2 = unpack(vn.cur)
	local chap = vn.index[c1]
	vars["_idx1"] = c1 - vn.index.offset
	vars["_idx2"] = c2
	vars["_title1"] = chap.name
	vars["_title2"] = chap[c2][1]
	vn.vars = vars
end	

local function stateReset(vn, keepRes)
	vn.wait = 0
	vn.returnValue = nil
	vn.textCont = false
	vn.unskippable = false
	vn.selectTarget = false
	vn.style = vn.initStyle
	f0b.table.clear(vn.settings)
	vn.stackVars = {}
	initVars(vn)

	local ui = vn.ui
	ui.select.display = false
	ui.textboard.display = false
	widgets.textboard.setName(ui.textboard, false)
	widgets.textboard.regen(ui.textboard, vn.initStyle)
	widgets.select.regen(ui.select, vn.initStyle)
	if not keepRes then
		f0b.jukebox.ops(vn.tracks, "rmall")
		f0b.layers.ops(vn.background, "rmall")
	end
end

local function errorStage(pre, errmsg, font)
	errmsg = pre .. "\n\n" .. errmsg
	local graphics = love.graphics
	local text = graphics.newText(font)
	text:setf(errmsg, graphics.getWidth(), "left")
	return {
		{"bg", "add", exec=graphics.rectangle,
			color={0, 0, 0, 1},
			args={"fill", 0, 0, text:getDimensions()}},
		{"bg", "add", args={text}},
		{"text", "", true},
		{"bg", "rmall"},
		{"return", false}
	}
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
	return errorStage(name .. ": Load failed", result, style.font)
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

local function setStage(self, stage, keepRes)
	stateReset(self, fullReset)
	f0b.lisp.set(self.dataStack, stage)
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

	let = function(line, vn)
		f0b.table.struct.addField(vn.vars, line[2], line[3])
	end,

	["="] = function(line, vn)
		vn.vars[line[2]] = line[3]
	end,

	map = function(line, vn)
		local key = line[2]
		vn.vars[key] = line[3][key]
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
		vn.ui.select.display = true
		return true
	end,

	case = function(line, vn)
		local name = line[2]
		local var
		if name == nil then
			var = table.remove(vn.stackVars)
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

	macro = function(line, vn)
		f0b.lisp.push(vn.dataStack,
			line[2](vn.vars, vn.gVars, unpack(line, 3)))
	end,

	read = function(line, vn)
		f0b.lisp.push(vn.dataStack, line[2], line[3])
	end,

	["break"] = function(_, vn)
		f0b.lisp["break"](vn.dataStack)
	end,

	["return"] = function(line, vn)
		vn.returnValue = line[2]
	end,

	settings = function(line, vn)
		vn.settings[line[2]] = line[3]
	end,
}

local function advanceVN2(self)
	self.ui.textboard.display = false
	local status, val = pcall(f0b.lisp.process, self.dataStack, self)
	if not status then
		local trace = f0b.lisp.trace(self.dataStack)
		trace[0] = "Processing error:\n\n"
		local render = table.concat(trace, "", 0)
		return setStage(self, errorStage(render, val, self.style.font),
			false)
	end
	if val then
		return
	end

	if self.returnValue ~= false then
		local stage = getStage(self, 1)
		if stage then
			setStage(self, stage, self.settings.keepRes)
			return advanceVN2(self)
		end
	end
	return gamestate:stateSwitch(true)
end

local function commonInput(self, fallbackKey, selectInputFn, ...)
	local ui = self.ui
	if ui.select.display then
		local val = selectInputFn(ui.select, ...)
		if val then
			ui.select.display = false
			if self.selectTarget == nil then
				table.insert(self.stackVars, val)
			else
				self.vars[self.selectTarget] = val
			end
			return advanceVN2(self)
		end
	elseif not ui.textboard.finished then
		return widgets.textboard.keypressed(ui.textboard, fallbackKey)
	elseif not self.unskippable and (fallbackKey == "space" or fallbackKey == "return") then
		self.wait = 0
		return advanceVN2(self)
	end
end	

local function vnMousepressed(self, x, y, button, ...)
	if button == 2 then
		return gamestate:stateSwitch(true)
	end
	return commonInput(self, "return", f0b.buttons.mousepressed, x, y, button, ...)
end

local function vnKeypressed(self, key)
	return commonInput(self, key, f0b.buttons.keypressed, key)
end

local function vnMousemoved(self, ...)
	local select = self.ui.select
	if select.display then
		return f0b.buttons.mousemoved(select, ...)
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

local function vnPreCommon(self)
	setStage(self, getStage(self, 0), false)
	return advanceVN2(self)
end

local function vnPreInitiated(self, stage)
	if stage then
		self.cur[1], self.cur[2] = unpack(stage)
	end
	return vnPreCommon(self)
end

local function vnPreInit(self, stage)
	local logue = require("engine.inst.logue")
	self.dataStack = f0b.lisp.init(logue.typeTable,
		f0b.table.union(logue.instructionTable, instructionTable))

	f0b.ui.add(self.ui, "textboard", self.style)
	f0b.ui.add(self.ui, "select", self.style)

	self.pre = vnPreInitiated
	return vnPreInitiated(self, stage or self.cur)
end

return {
	new = function(index, style)
		return {
			draw = vnDraw,
			update = vnUpdate,
			keypressed = vnKeypressed,
			mousemoved = vnMousemoved,
			mousepressed = vnMousepressed,
			pre = vnPreInit,

			background = {},
			tracks = {},

			initStyle = style,
			style = style,
			index = index,

			unskippable = false,
			textCont = false,
			wait = 0,
			selectTarget = nil,
			returnValue = nil,
			settings = f0b.table.struct.new({"keepRes"}),
			gVars = {},
			stackVars = {},
			vars = nil,

			ui = {},
			cur = {1,1},
			dataStack = nil,
		}
	end,
}
