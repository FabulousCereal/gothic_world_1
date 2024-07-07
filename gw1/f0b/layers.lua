-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")
local fTable = require("f0b.table")

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
	fade[2] = seq.interpolationLinear{args, fTable.set, 0, time, 4,
		2, diffX, 3, diffY}
	return seq.interpolate(layer, fade, dt)
end

-- Fades --
-- Format: {"fadein" | "fadeout", secs}
local function fadeSetup(layer, fade, dt, new, actual)
	layer.color[4] = actual
	fade[1] = "_interpolate"
	fade[2] = seq.interpolationLinear{layer.color, fTable.set, 0, fade[2],
		2, 4, new - actual}
	return seq.interpolate(layer, fade, dt)
end

local fadeOps = {
	_interpolate = seq.interpolate,

	-- Delay --
	-- Format: {"delay", secs}
	delay = function(_, fade, dt)
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
		local int = {layer.color, fTable.set, 0, fade[3], 3}
		for i = 1, #new do
			int[#int+1] = i
			int[#int+1] = new[i] - cur[i]
		end
		fade[1] = "_interpolate"
		fade[2] = seq.interpolationLinear(int)
		return seq.interpolate(layer, fade, dt)
	end,

	-- Replace first argument
	-- Format: {"src", arg}
	src = function(layer, fade, dt)
		layer.args[1] = fade[2]
		return 2, -dt
	end,

	-- Toggle visibility
	toggle = function(layer, _, dt)
		layer.hide = not layer.hide
		return 1, -dt
	end,
}

local isUpdatable = {table=true, userdata=true}
local function layerUpdate(layerTable, layer, i, dt, finish)
	local dyn = false
	if layer.args then
		local drawable = layer.args[1]
		if isUpdatable[type(drawable)] and drawable.update then
			dyn = true
			drawable:update(dt)
		end
	end
	local fade = layer.fade
	if fade and #fade > 0 then
		dyn = true
		local remove = seq.update(fadeOps, layer, fade, dt,
			finish)
		if remove == true then
			table.remove(layerTable, i)
		end
	end
	return dyn
end

local function layerTableUpdate(layerTable, dt, finish)
	local dyn = layerTable.redraw
	for i = #layerTable, 1, -1 do
		local layer = layerTable[i]
		if layer.cnv then
			dyn = layerTableUpdate(layer, dt, finish) or dyn
		else
			dyn = layerUpdate(layerTable, layer, i, dt, finish) or dyn
		end
	end
	layerTable.redraw = layerUpdate(layerTable, layerTable.root, nil, dt, finish)
		or dyn
	return dyn
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
	local m, n = graphics.getBlendMode()
	graphics.setBlendMode(m, layer.alpha or "alphamultiply")
	-- When you manage to leave Lua befuddled and discombobulated
	local dyn = shaderOps[type(shader)](shader);
	(layer.draw or defaultFn)(draw, x, y, ...)
	graphics.setShader()
	graphics.setBlendMode(m, n)
	return dyn
end

local function unpackIfPresent(t)
	if t then
		return unpack(t)
	end
end

local function layerTableDraw(lt, skipDraw)
	local graphics = love.graphics
	local defaultFn = graphics.draw
	local dyn = false
	if lt.redraw then
		local prev = graphics.getCanvas()
		graphics.setCanvas(lt.cnv)
		graphics.clear()
		for i = 1, #lt do
			local ldyn
			local layer = lt[i]
			if not layer.hide then
				if layer.cnv then
					ldyn = layerTableDraw(layer)
				else
					ldyn = layerDraw(layer, defaultFn,
						unpackIfPresent(layer.args))
				end
				dyn = ldyn or dyn
			end
		end
		graphics.setCanvas(prev)
		lt.redraw = dyn
	end
	if not skipDraw then
		layerDraw(lt.root, defaultFn, lt.cnv)
	end
	return dyn
end

local function defaultDefaults(alpha)
	return {color={1,1,1,1}, draw=love.graphics.draw, alpha=alpha}
end

local function unionOrNew(lt, key, force, ...)
	local v = lt[key]
	local new = defaultDefaults(...)
	if not v or force then
		lt[key] = new
	else
		lt[key] = f0b.table.unionInPlace(new, v)
	end
end

local function setDefaults(lt, force)
	unionOrNew(lt, "default", force)
	unionOrNew(lt, "root", force, "premultiplied")
	local graphics = love.graphics
	if lt.cnv then
		local prev = graphics.getCanvas()
		graphics.setCanvas(lt.cnv)
		graphics.clear()
		graphics.setCanvas(prev)
	else
		lt.cnv = graphics.newCanvas()
	end
	lt.redraw = true
	return lt
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
	end
	return op
end

local function normalizeLayerTable(lt)
	setDefaults(lt)
	for i = 1, #lt do
		local l = lt[i]
		if l.cnv then
			normalizeLayerTable(l)
		else
			normalizeLayer(lt, l)
		end
	end
	return lt
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
	start = normalizeIndex(table, start)
	limit = normalizeIndex(table, limit, start)
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
		local l = layers[i]
		if l.cnv then
			layerModRange(l, op, 1, #l)
		else
			layerMod(l, op)
		end
	end
end

local function normalizeStrIdx(layers, idx)
	if type(idx) ~= "string" then
		idx = normalizeIndex(layers, idx)
	end
	return idx
end

local function layerFade(layers, fade, idx)
	idx = normalizeStrIdx(layers, idx)
	local l = layers[idx]
	layerUpdate(layers, l, idx, 0, true)
	l.fade = fTable.deepCopy(fade)
end

local layerOps

local function ops(layerTable, inst, op, ...)
	layerTable.redraw = true
	if type(op) == "number" then
		return ops(layerTable[op], inst, ...)
	end
	return layerOps[op](layerTable, inst, ...)
end

layerOps = {
	add = function(layers, op, idx)
		normalizeLayer(layers, op)
		if idx then
			return table.insert(layers, idx, op)
		end
		return table.insert(layers, op)
	end,

	rm = function(layers, _, start, limit)
		start, limit = getNormalizedRange(layers, start, limit)
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	rmall = fTable.clearArray,

	mod = function(layers, op, ...)
		for i = 1, math.max(select("#", ...), 1) do
			local idx = normalizeStrIdx(layers, select(i, ...))
			local l = layers[idx]
			if l.cnv then
				layerModRange(l, op, 1, #l)
			else
				layerMod(layers[idx], op)
			end
		end
	end,

	modall = function(layers, op)
		return layerModRange(layers, op, 1, #layers)
	end,

	fade = function(layers, _, ...)
		return seq.fadeParse(layers, layerFade, #layers, ...)
	end,

	fn = function(layers, _, idx, fn)
		layers.redraw = true
		return fn(layers[idx])
	end,

	addsub = function(layers, _, idx, sub)
		if not sub then
			sub = idx
			idx = #layers + 1
		end
		return table.insert(layers, idx, normalizeLayerTable(sub))
	end,

	fold = function(layers, op, idx)
		idx = idx or #layers
		local sub = layers[idx]
		layerTableDraw(sub, true)
		layers[idx] = {args={sub.cnv}, alpha=sub.alpha}
		return layerMod(normalizeLayer(layers, layers[idx]), op)
	end,

	sync = function(lt)
		return layerTableUpdate(lt, 0, true)
	end,

	debug = function(layers)
		return print(#layers)
	end,
}

return {
	ops = ops,

	normalize = normalizeLayerTable,

	reset = function(layerTable)
		return setDefaults(fTable.clearArray(layerTable), true)
	end,

	update = function(layerTable, dt)
		return layerTableUpdate(layerTable, dt, false)
	end,

	draw = layerTableDraw,
}
