-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")
local fTable = require("f0b.table")

-- Varies arbitrary variables --
-- Format: {"_generic", control, ellapsed, endTime}
--   control = {where, index, fn, [index, fn, [...]]}
local function genericVary(layer, fade, dt)
	local control, acc, endTime = unpack(fade, 2, 4)
	acc = acc + dt
	local ratio = endTime > 0 and math.min(acc / endTime, 1) or 1

	local where = control[1]
	for i = 2, #control, 2 do
		local idx, fn = unpack(control, i, i+1)
		where[idx] = fn(ratio)
	end

	if acc >= endTime then
		return 4, endTime - acc
	end
	fade[3] = acc
end		

local function setLinear(control, tgt, diff)
	local start = control[1][tgt]
	table.insert(control, tgt)
	table.insert(control, function(ratio) return start + diff*ratio end)
end

-- Turns handwriten movement into "_generic"
-- Format: {type, x, y, rate}
local function mvCommon(layer, fade, dt, ...)
	local args = layer.args
	for i = 2, 3 do
		args[i] = args[i] or 0
	end

	local type, diffX, diffY, time = unpack(fade, 1, 4)
	local dist = layer.distance or 1
	if type == "mvabs" then
		diffX = diffX and diffX / dist - args[2] or 0
		diffY = diffY and diffY / dist - args[3] or 0
	else
		diffX = diffX and diffX / dist or 0
		diffY = diffY and diffY / dist or 0
	end

	local control = {args}
	setLinear(control, 2, diffX)
	setLinear(control, 3, diffY)
	fade[1] = "_generic"
	fade[2] = control
	fade[3] = 0
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
		if type(drawable) == "table" and drawable.update then
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
	["table"] = function(shaderArgs)
		local shader = shaderArgs[1]
		for k, v in pairs(shaderArgs) do
			if type(k) == "string" and shader:hasUniform(k) then
				shader:send(k, v)
			end
		end
		love.graphics.setShader(shader)
	end,
}

local function layerDraw(layer, defaultFn, ...)
	local graphics = love.graphics
	graphics.setColor(layer.color or {1,1,1,1})
	local shader = layer.shader
	-- When you manage to leave Lua befuddled and discombobulated
	shaderOps[type(shader)](shader);
	(layer.draw or defaultFn)(...)
	graphics.setShader()
end

local function layerDrawRange(lt, cnv, start, limit)
	local graphics = love.graphics
	local defaultFn = lt.default.draw
	local prev = graphics.getCanvas()
	graphics.setCanvas(cnv)
	graphics.clear()
	for i = start, limit do
		layerDraw(lt[i], defaultFn, unpack(lt[i].args))
	end
	graphics.setCanvas(prev)
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
	add = function(layers, op)
		normalizeLayer(layers, op)
		local idx = op[1]
		if idx then
			table.insert(layers, idx, op)
		else
			table.insert(layers, op)
		end
	end,

	rm = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	rmall = fTable.clearArray,

	mod = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		layerModRange(layers, op, start, limit)
	end,

	modall = function(layers, op)
		layerModRange(layers, op, 1, #layers)
	end,

	conf = function(layers, op)
		layerMod(layers[op[1]], op)
	end,

	fold = function(layers, op)
		local start = normalizeIndex(layers, op[1], 1)
		local limit = normalizeIndex(layers, op[2], #layers)

		local cnv = love.graphics.newCanvas()
		layerDrawRange(layers, cnv, start, limit)
		layerOps.rm(layers, {start+1, limit})
		layers[start] = {args={cnv}}
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
		layerTable.drawn = false
		return layerOps[op](layerTable, directive)
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
			layerDrawRange(lt, cnv, 1, #lt)
			lt.drawn = true
		end
		love.graphics.setBlendMode("alpha", "premultiplied")
		layerDraw(lt.root, defaultFn, cnv)
		love.graphics.setBlendMode("alpha", "alphamultiply")
	end,
}
