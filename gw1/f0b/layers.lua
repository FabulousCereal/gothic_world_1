-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")

-- Varies arbitrary variables --
-- Format: {"_generic", directives, timeRemaining}
--   directives = {control, [control, [...]]}
--     control = {component, index, delta, [index, delta, [...]]}
local function genericVary(layer, tween, dt, finish)
	local remaining = tween[3]
	local mult = math.min(dt, remaining)
	remaining = remaining - dt

	local directives = tween[2]
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
	tween[3] = remaining
end		

-- Turns handwriten movement into "_generic"
-- Format: {type, x, y, rate}
local function mvCommon(layer, tween, dt, ...)
	local args = layer.args
	if not args[2] then
		args[2] = 0
	end
	if not args[3] then
		args[3] = 0
	end

	local mult = layer.distance or 1
	local type, deltaX, deltaY, rate = unpack(tween, 1, 4)
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
	tween[1] = "_generic"
	tween[2] = {control}
	table.remove(tween, 3)
	return genericVary(layer, tween, dt, ...)
end

local function layerFade(layer, tween, dt)
	layer.color[4] = seq.fadeCommon(layer.color[4], tween, dt)
	if tween[3] <= 0 then
		return 3, tween[3]
	end
end

local function fadeSetup(layer, tween, dt)
	if not layer.color then
		layer.color = {1, 1, 1, (tween[1] == "fadein") and 0 or 1}
	end
	return seq.fadeSetup(layer, tween, dt, layer.color[4], layerFade)
end

local tweenOps = {
	-- Generic --
	_generic = genericVary,
	_fade = layerFade,

	-- Delay --
	-- Format: {"delay", secs}
	delay = function(layer, tween, dt, finish)
		local secs = tween[2] - dt
		if secs <= 0 then
			return 2, secs
		end
		tween[2] = secs
	end,

	-- Fades --
	-- Format: {"fadein" | "fadeout", secs}
	fadein = fadeSetup,
	fadeout = fadeSetup,

	-- Movement --
	mvdiff = mvCommon,
	mvabs = mvCommon,
}

local function layerUpdate(layerTable, dt, endTween)
	for i = #layerTable, 1, -1 do
		local layer = layerTable[i]
		local drawable = layer.args[1]
		if drawable.update then
			drawable:update(dt)
		end
		local tween = layer.tween
		if tween and #tween > 0 then
			local remove = seq.update(tweenOps, layer, tween, dt,
				endTween)
			if remove == true then
				table.remove(layerTable, i)
			end
		end
	end
end

local function layerDraw(layerTable)
	local graphics = love.graphics
	for i = 1, #layerTable do
		local layer = layerTable[i]
		local drawFunc = layer.exec or graphics.draw
		graphics.setColor(layer.color or {1, 1, 1, 1})
		drawFunc(unpack(layer.args))
	end
end

local function normalizeLayer(op)
	if op.tween and op.tween[1] == "fadein" and not op.color then
		op.color = {1,1,1,0}
	end

	local graphics = love.graphics
	if not op.exec or op.exec == graphics.draw then
		local arg = op.args[1]
		if type(arg) == "table" then
			for i = 1, #arg do
				normalizeLayer(arg[i])
			end

			op.args = {graphics.newCanvas()}
			graphics.setCanvas(op.args[1])
			--f0b.table.print(arg, 10)
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
	else
		return idx
	end
end

local function getNormalizedRange(table, start, limit)
	local start = normalizeIndex(table, start)
	local limit = normalizeIndex(table, limit, start)
	return start, limit
end

local function layerMod(layers, op, start, limit)
	local deepCopy = f0b.table.deepCopy
	for key, value in pairs(op) do
		local valType = type(value)
		for i = start, limit do
			if valType == "table" then
				local copy = deepCopy(value)
				if key == "args" then
					copy[1] = seq.normalizeSrc(res.img,
						copy[1])
				end
				layers[i][key] = copy
			elseif valType ~= "number" then
				layers[i][key] = value
			end
		end
	end
end	

local layerOps
layerOps = {
	add = function(layers, op)
		normalizeLayer(op)
		local idx = op[1]
		if idx then
			table.insert(layers, idx, op)
		else
			table.insert(layers, op)
		end
	end,

	set = function(layers, op)
		normalizeLayer(op)
		local idx = normalizeIndex(layers, op[1])
		layers[idx] = op
	end,

	rm = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	rmall = function(layers)
		for i = #layers, 1, -1 do
			layers[i] = nil
		end
	end,

	mod = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		layerMod(layers, op, start, limit)
	end,

	modall = function(layers, op)
		layerMod(layers, op, 1, #layers)
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
		for i = 1, #layerTable do
			normalizeLayer(layerTable[i])
		end
		return layerTable
	end,

	update = layerUpdate,

	draw = layerDraw,
}
