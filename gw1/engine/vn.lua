-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local widgets = require("f0b.ui").widgets

local function initVars(vn)
	local vars = f0b.table.struct.new({"_idx1", "_idx2", "_title1", "_title2"})
	local c1, c2 = unpack(vn.cur)
	local chap = vn.index[c1]
	vars["_idx1"] = c1 + vn.index.offset
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
	vn.stackVars = {}
	vn.path = {}
	f0b.table.clear(vn.settings)
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

local function errorStage(font, ...)
	local errmsg = table.concat({...})
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

local function getStage(self, offset)
	local index, cur = self.index, self.cur
	cur[2] = cur[2] + offset

	-- Implement test as a loop to handle empty chapters
	while cur[2] > #index[cur[1]] do
		cur[1] = cur[1] + 1
		if cur[1] > #index then
			return false
		end
		cur[2] = 1
	end

	local chapter = index[cur[1]]
	local file = chapter[cur[2]][2]
	if file then
		local path = {res.dataPath}
		local dir = chapter.dir
		if dir then
			table.insert(path, dir)
			table.insert(path, "/")
		end
		table.insert(path, file)
		table.insert(path, ".lua")

		local name = table.concat(path)
		return name, pcall(f0b.std.dofile, name)
	end
	return false
end

local function setErrorStage(self, ...)
	f0b.lisp.set(self.dataStack, errorStage(self.style.font, ...))
end

local function loadStage(self, offset, keepRes)
	local name, ok, result = getStage(self, offset)
	if name then
		if ok then
			f0b.lisp.set(self.dataStack, result)
		else
			setErrorStage(self, name, ": load failed\n\n", result)
		end
	end
	stateReset(self, keepRes)
	return name, ok
end

local function curStage(self)
	local name, ok = loadStage(self, 0, false)
	if not name then
		setErrorStage(self, "no file associated with index (",
			tostring(self.cur[1]), ", ", tostring(self.cur[2]), ")")
	end
	return name and ok
end

local function nextStage(self)
	return (loadStage(self, 1, self.settings.keepRes))
end

local function externalOps(opFunc, target, inst)
	local copy = f0b.table.deepCopy(inst)
	local op = copy[2]
	return opFunc.ops(target, op, f0b.table.moveArray(copy, 2))
end

local instructionTable = {
	nop = function() end,

	style = function(line, vn)
		vn.style = res.style[line[2]]
		f0b.ui.regen(vn.ui, vn.style)
	end,

	sfx = function(line, vn)
		local fade = {"delay", "remaining", true}
		if line[5] then
			fade = {"delay", line[5], "cmd", {play=true},
				unpack(fade)}
		end
		local inst = {
			line[2], line[3],
			source=res.sfx(line[2]), fade=fade,
			setup={setPitch=line[4], setLooping=false, play=not line[5]},
		}
		f0b.jukebox.ops(vn.tracks, "set", inst)
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

local function processVN(self)
	self.ui.textboard.display = false
	local success, val = pcall(f0b.lisp.process, self.dataStack, self)
	if not success then
		local trace = f0b.lisp.trace(self.dataStack)
		trace[0] = "Processing error:\n\n"
		local render = table.concat(trace, "", 0)
		setErrorStage(self, render, val)
	end
	return success, val
end

local function advanceVN2(self)
	local success, val = processVN(self)
	if success then
		if val == nil then
			if self.returnValue ~= false and nextStage(self) then
				return advanceVN2(self)
			end
			gamestate:stateSwitch(true)
		end
	end
	return success
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
				widgets.textboard.update(tb, dt)
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

local function selectChosen(self, val)
	self.ui.select.display = false
	if self.selectTarget == nil then
		table.insert(self.stackVars, val)
	else
		self.vars[self.selectTarget] = val
	end
	table.insert(self.path, val)
end

local function commonInput(self, fallbackKey, selectInputFn, ...)
	local ui = self.ui
	if ui.select.display then
		local val = selectInputFn(ui.select, ...)
		if val then
			selectChosen(self, val)
			return advanceVN2(self)
		end
	elseif not ui.textboard.finished then
		widgets.textboard.keypressed(ui.textboard, fallbackKey)
	elseif not self.unskippable and (fallbackKey == "space" or fallbackKey == "return") then
		self.wait = 0
		return advanceVN2(self)
	end
end

local function commonKeypress(self, key)
	return commonInput(self, key, f0b.buttons.keypressed, key)
end

local function endLoadState(self, dt)
	self.update = vnUpdate
	f0b.layers.ops(self.background, "sync")
	f0b.jukebox.ops(self.tracks, "sync")
	love.audio.setVolume(1)
	return vnUpdate(self, dt)
end

local function vnUpdateLoad(self, dt)
	local start = love.timer.getTime()
	repeat
		local save = self.saveState
		local p1, p2 = f0b.lisp.getPos(self.dataStack)
		if #save == #self.path
		and (p1 > save.pos[1] or (p1 == save.pos[1] and p2 >= save.pos[2])) then
			return endLoadState(self, dt)
		elseif self.ui.select.display then
			selectChosen(self, save[#self.path + 1])
		else
			local success = commonKeypress(self, "return")
				and vnUpdate(self, math.huge)
			if success == false then
				return endLoadState(self, dt)
			end
		end
	until love.timer.getTime() - start > dt/2
end

local function loadState(self)
	local save = self.saveState
	if save.cur then
		self.cur[1], self.cur[2] = unpack(save.cur)
		if curStage(self) then
			self.update = vnUpdateLoad
			love.audio.setVolume(0)
		end
	end
end

local function saveState(self)
	local save = f0b.table.deepCopy(self.path)
	save.cur = {unpack(self.cur)}
	save.pos = {f0b.lisp.getPos(self.dataStack)}
	self.saveState = save
end

local function vnKeypressed(self, key)
	local isDown = love.keyboard.isDown
	if isDown("lctrl", "rctrl") then
		if key == "s" then
			saveState(self)
		elseif key == "l" then
			loadState(self)
		end
	else
		return commonKeypress(self, key)
	end
end

local function vnMousepressed(self, x, y, button, ...)
	local key = button == 1 and "return"
	return commonInput(self, key, f0b.buttons.mousepressed, x, y, button, ...)
end

local function vnWheelmoved(self, ...)
	return commonInput(self, "", f0b.buttons.wheelmoved, ...)
end

local function vnMousemoved(self, ...)
	local select = self.ui.select
	if select.display then
		return f0b.buttons.mousemoved(select, ...)
	end
end

local function vnPreCommon(self)
	curStage(self)
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
	self.settings = f0b.table.struct.new({"keepRes"})

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
			wheelmoved = vnWheelmoved,
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
			settings = nil,
			gVars = f0b.table.struct.new(index.globals),
			stackVars = {},
			vars = nil,

			ui = {},
			cur = {1,1},
			dataStack = nil,

			path = {},
			saveState = {},
		}
	end,
}
