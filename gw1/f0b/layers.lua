-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")
local fTable = require("f0b.table")

-- Varies arbitrary variables --
-- Format: {"_generic", directives, timeRemaining}
--   directives = {control, [control, [...]]}
--     control = {component, index, delta, [index, delta, [...]]}
local function genericVary(layer, fade, dt, finish)
	local remaining = fade[3]
	local mult = math.min(dt, remaining)
	remaining = remaining - dt

	local directives = fade[2]
	for i = 1, #directives do
		local control = directives[i]

		local component = layer[control[1]]
		for i = 2, #control, 2 do
			local idx = control[i]
			local delta = control[i + 1]
			component[idx] = component[idx] + delta * mult
		end
	end

	if remaining <= 0 then
		return 3, remaining
	end
	fade[3] = remaining
end		

-- Turns handwriten movement into "_generic"
-- Format: {type, x, y, rate}
local function mvCommon(layer, fade, dt, ...)
	local args = layer.args
	if not args[2] then
		args[2] = 0
	end
	if not args[3] then
		args[3] = 0
	end

	local mult = layer.distance or 1
	local type, deltaX, deltaY, rate = unpack(fade, 1, 4)
	if type == "mvabs" then
		deltaX = deltaX - (args[2] / mult)
		deltaY = deltaY - (args[3] / mult)
	end

	local rate = math.max(dt, rate) --Allow rate=0
	local control = {"args"}
	if deltaX ~= 0 then
		table.insert(control, 2)
		table.insert(control, deltaX / rate * mult)
	end
	if deltaY ~= 0 then
		table.insert(control, 3)
		table.insert(control, deltaY / rate * mult)
	end
	fade[1] = "_generic"
	fade[2] = {control}
	table.remove(fade, 3)
	return genericVary(layer, fade, dt, ...)
end

local function layerFade(layer, fade, dt)
	layer.color[4] = seq.fadeCommon(layer.color[4], fade, dt)
	if fade[3] <= 0 then
		return 3, fade[3]
	end
end

local function fadeSetup(layer, fade, dt)
	layer.color[4] = (fade[1] == "fadein") and 0 or 1
	return seq.fadeSetup(layer, fade, dt, layer.color[4], layerFade)
end

local fadeOps = {
	-- Generic --
	_generic = genericVary,
	_fade = layerFade,

	-- Delay --
	-- Format: {"delay", secs}
	delay = function(layer, fade, dt)
		local secs = fade[2] - dt
		if secs <= 0 then
			return 2, secs
		end
		fade[2] = secs
	end,

	-- Fades --
	-- Format: {"fadein" | "fadeout", secs}
	fadein = fadeSetup,
	fadeout = fadeSetup,

	-- Movement --
	mvdiff = mvCommon,
	mvabs = mvCommon,
}

local function layerUpdate(layerTable, dt, finish)
	for i = #layerTable, 1, -1 do
		local layer = layerTable[i]
		local drawable = layer.args[1]
		if drawable.update then
			drawable:update(dt)
		end
		local fade = layer.fade
		if fade and #fade > 0 then
			local remove = seq.update(fadeOps, layer, fade, dt,
				finish)
			if remove == true then
				table.remove(layerTable, i)
			end
		end
	end
end

local function layerDraw(layerTable)
	local graphics = love.graphics
	local default = layerTable.default
	for i = 1, #layerTable do
		local layer = layerTable[i]
		local drawFn = layer.exec or default.exec
		local shader = layer.shader
		local color = layer.color
		graphics.setColor(color)
		if shader then
			graphics.setShader(shader)
		end
		drawFn(unpack(layer.args))
		if shader then
			graphics.setShader()
		end
	end
end

local function defaultDefaults()
	return {color={1,1,1,1}, exec=love.graphics.draw}
end

local function setDefaults(layerTable)
	if not layerTable.default then
		layerTable.default = defaultDefaults()
	end
end

local function normalizeLayer(layerTable, op)
	local graphics = love.graphics
	local default = layerTable.default
	if not op.color then
		op.color = fTable.deepCopy(default.color)
	end
	if not op.shader then
		op.shader = default.shader
	end
	if not op.exec then
		op.exec = default.exec
	end

	if op.exec == graphics.draw then
		local arg = op.args[1]
		if type(arg) == "table" then
			arg.default = fTable.deepCopy(default)
			for i = 1, #arg do
				normalizeLayer(layerTable, arg[i])
			end

			op.args = {graphics.newCanvas()}
			graphics.setCanvas(op.args[1])
			layerDraw(arg)
			graphics.setCanvas()
		else
			op.args[1] = seq.normalizeSrc(res.img, arg)
		end
	end
end

local function normalizeIndex(table, idx, default)
	if not idx then
		return default or #table
	elseif idx < 1 then
		return #table + idx
	end
	return idx
end

local function getNormalizedRange(table, start, limit)
	local start = normalizeIndex(table, start)
	local limit = normalizeIndex(table, limit, start)
	return start, limit
end

local function layerMod(layer, op)
	local deepCopy = fTable.deepCopy
	for key, val in pairs(op) do
		local valType = type(val)
		if valType == "table" then
			local copy = deepCopy(val)
			if key == "args" then
				copy[1] = seq.normalizeSrc(res.img,
					copy[1])
			end
			layer[key] = copy
		elseif valType ~= "number" then
			layer[key] = val
		end
	end
end

local function layerModRange(layers, op, start, limit)
	for i = start, limit do
		layerMod(layers[i], op)
	end
end	

local layerOps
layerOps = {
	add = function(layers, op)
		setDefaults(layers)
		normalizeLayer(layers, op)
		local idx = op[1]
		if idx then
			table.insert(layers, idx, op)
		else
			table.insert(layers, op)
		end
	end,

	set = function(layers, op)
		setDefaults(layers)
		normalizeLayer(layers, op)
		local idx = normalizeIndex(layers, op[1])
		layers[idx] = op
	end,

	rm = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	rmall = fTable.clearArray,

	mod = function(layers, op)
		local start, limit = unpack(op)
		if type(start) == "string" then
			layerMod(layers[start], op)
		else
			start, limit = getNormalizedRange(layers, start, limit)
			layerModRange(layers, op, start, limit)
		end
	end,

	modall = function(layers, op)
		layerModRange(layers, op, 1, #layers)
	end,

	fold = function(layers, op)
		local graphics = love.graphics
		local cnv = graphics.newCanvas()
		graphics.setCanvas(cnv)
		layerDraw(layers)
		graphics.setCanvas()
		layerOps.rmall(layers)
		layers[1] = {args={cnv}}
	end,

	sync = function(layers)
		layerUpdate(layers, 0, true)
	end,

	debug = function(layers)
		print(#layers)
	end,
}

return {
	ops = function(layerTable, op, directive)
		return layerOps[op](layerTable, directive)
	end,

	normalize = function(layerTable)
		setDefaults(layerTable)
		for i = 1, #layerTable do
			normalizeLayer(layerTable, layerTable[i])
		end
		return layerTable
	end,

	reset = function(layerTable)
		layerTable.default = defaultDefaults()
		return fTable.clearArray(layerTable)
	end,

	update = function(layerTable, dt)
		return layerUpdate(layerTable, dt, false)
	end,

	draw = layerDraw,
}
