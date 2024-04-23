-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")
local fTable = require("f0b.table")

local function setVal(table, key, val)
	table[key] = val
end

-- Turns handwriten movement into "_interpolate"
-- Format: {type, x, y, rate}
local function mvCommon(layer, fade, dt)
	local args = layer.args
	for i = 2, 3 do
		args[i] = args[i] or 0
	end

	local type, diffX, diffY, time = unpack(fade, 1, 4)
	if type == "mvabs" then
		diffX = diffX and diffX - args[2] or 0
		diffY = diffY and diffY - args[3] or 0
	else
		diffX = diffX and diffX or 0
		diffY = diffY and diffY or 0
	end

	fade[1] = "_interpolate"
	fade[2] = seq.interpolationLinear{args, setVal, 0, fade[4], 4,
		2, diffX, 3, diffY}
	return seq.interpolate(layer, fade, dt)
end

-- Fades --
-- Format: {"fadein" | "fadeout", secs}
local function fadeSetup(layer, fade, dt, new, actual)
	layer.color[4] = actual
	fade[1] = "_interpolate"
	fade[2] = seq.interpolationLinear{layer.color, setVal, 0, fade[2], 2,
		4, new - actual}
	return seq.interpolate(layer, fade, dt)
end

local fadeOps = {
	_interpolate = seq.interpolate,

	-- Delay --
	-- Format: {"delay", secs}
	delay = function(layer, fade, dt)
		local secs = fade[2] - dt
		if secs <= 0 then
			return 2, secs
		end
		fade[2] = secs
	end,

	fadein = function(l, f, dt)
		return fadeSetup(l, f, dt, 1, 0)
	end,
	fadeout = function(l, f, dt)
		return fadeSetup(l, f, dt, 0, 1)
	end,

	-- Movement --
	mvdiff = mvCommon,
	mvabs = mvCommon,

	-- Color interpolation --
	-- Format: {"color", {r,g,b,a}, secs}
	color = function(layer, fade, dt)
		local cur = layer.color
		local new = fade[2]
		local int = {layer.color, setVal, 0, fade[3], 3}
		for i = 1, #new do
			int[#int+1] = i
			int[#int+1] = new[i] - cur[i]
		end
		fade[1] = "_interpolate"
		fade[2] = seq.interpolationLinear(int)
		return seq.interpolate(layer, fade, dt)
	end,
}

local function layerUpdate(layerTable, dt, finish)
	isUpdatable = {table=true, userdata=true}
	for i = #layerTable, 1, -1 do
		local layer = layerTable[i]
		local drawable = layer.args[1]
		if isUpdatable[type(drawable)] and drawable.update then
			layerTable.drawn = false
			drawable:update(dt)
		end
		local fade = layer.fade
		if fade and #fade > 0 then
			layerTable.drawn = false
			local remove = seq.update(fadeOps, layer, fade, dt,
				finish)
			if remove == true then
				table.remove(layerTable, i)
			end
		end
	end
end

local shaderOps = {
	["nil"] = function() end,
	["boolean"] = function(bool)
		if bool then
			error("shader cannot be 'true'")
		end
	end,
	["userdata"] = love.graphics.setShader,

	["table"] = function(ctx)
		local shader = f0b.shader.prepare(ctx)
		love.graphics.setShader(shader)
		return true
	end,
}

local function layerDraw(layer, defaultFn, draw, x, y, ...)
	local graphics = love.graphics
	graphics.setColor(layer.color or {1,1,1,1})
	local shader = layer.shader
	local scale = layer.scale
	if scale then
		x = x and x * scale or 0
		y = y and y * scale or 0
	end
	-- When you manage to leave Lua befuddled and discombobulated
	local dyn = shaderOps[type(shader)](shader);
	(layer.draw or defaultFn)(draw, x, y, ...)
	graphics.setShader()
	return dyn
end

local function layerDrawRange(lt, cnv, start, limit)
	local graphics = love.graphics
	local defaultFn = lt.default.draw
	local prev = graphics.getCanvas()
	graphics.setCanvas(cnv)
	graphics.clear()
	local dyn = false
	for i = start, limit do
		dyn = layerDraw(lt[i], defaultFn, unpack(lt[i].args))
			or dyn
	end
	graphics.setCanvas(prev)
	return dyn
end

local function defaultDefaults()
	return {color={1,1,1,1}, draw=love.graphics.draw}
end

local function setDefaults(lt, force)
	if not lt.default or force then
		lt.default = defaultDefaults()
	end
	if not lt.root or force then
		lt.root = defaultDefaults()
	end
	local graphics = love.graphics
	if lt.cnv then
		local prev = graphics.getCanvas()
		graphics.setCanvas(lt.cnv)
		graphics.clear()
		graphics.setCanvas(prev)
	else
		lt.cnv = graphics.newCanvas()
	end
end

local function normalizeLayer(lt, op)
	local default = lt.default
	if not op.color then
		op.color = fTable.deepCopy(default.color)
	end
	if op.draw == nil then
		op.draw = default.draw
	end
	if op.shader == nil then
		op.shader = default.shader
	end
	if op.fade and op.fade[1] == "fadein" then
		op.color[4] = 0
	end

	if op.draw == love.graphics.draw then
		op.args[1] = seq.normalizeSrc(res.img, op.args[1])
	elseif not op.args then
		op.args = {} --FIXME
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
		if type(val) == "table" then
			local copy = deepCopy(val)
			if key == "args" then
				copy[1] = seq.normalizeSrc(res.img,
					copy[1])
			end
			layer[key] = copy
		elseif type(key) ~= "number" then
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
	add = function(layers, op, idx)
		normalizeLayer(layers, op)
		if idx then
			table.insert(layers, idx, op)
		else
			table.insert(layers, op)
		end
	end,

	rm = function(layers, op, start, limit)
		start, limit = getNormalizedRange(layers, start, limit)
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	rmall = fTable.clearArray,

	mod = function(layers, op, start, limit)
		local start, limit = getNormalizedRange(layers, start, limit)
		layerModRange(layers, op, start, limit)
	end,

	modall = function(layers, op)
		layerModRange(layers, op, 1, #layers)
	end,

	conf = function(layers, op, name)
		layerMod(layers[name], op)
	end,

	fold = function(layers, op, start, limit)
		start = normalizeIndex(layers, start, 1)
		limit = normalizeIndex(layers, limit, #layers)

		local cnv = love.graphics.newCanvas()
		layerDrawRange(layers, cnv, start, limit)
		layerOps.rm(layers, {start+1, limit})
		layers[start] = {args={cnv}}
	end,

	fn = function(layers, op, idx, fn)
		idx = normalizeIndex(layers, idx, #layers)
		fn(layers[idx])
	end,

	sync = function(layers)
		layerUpdate(layers, 0, true)
	end,

	debug = function(layers)
		print(#layers)
	end,
}

return {
	ops = function(layerTable, inst, op, ...)
		layerTable.drawn = false
		return layerOps[op](layerTable, inst, ...)
	end,

	normalize = function(lt)
		setDefaults(lt)
		for i = 1, #lt do
			normalizeLayer(lt, lt[i])
		end
		return lt
	end,

	reset = function(layerTable)
		setDefaults(layerTable, true)
		return fTable.clearArray(layerTable)
	end,

	update = function(layerTable, dt)
		return layerUpdate(layerTable, dt, false)
	end,

	draw = function(lt)
		local cnv = lt.cnv
		if not lt.drawn then
			lt.drawn = not layerDrawRange(lt, cnv, 1, #lt)
		end
		love.graphics.setBlendMode("alpha", "premultiplied")
		layerDraw(lt.root, defaultFn, cnv)
		love.graphics.setBlendMode("alpha", "alphamultiply")
	end,
}
