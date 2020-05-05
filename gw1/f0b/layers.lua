local f0b_internal = require("f0b._internal")

local seqUpdate = f0b_internal.seqUpdate

-- Varies arbitrary variables --
-- Format: {"_generic", directives, (time)remaining}
--   directives = {control, [control, [...]]}
--     control = {component, index, delta, [index, delta, [...]]}
local function genericVary(layer, tween, dt, finish)
	local remaining = tween[3]
	if dt > remaining or finish then
		dt = remaining
	end

	local directives = tween[2]
	for i = 1, #directives do
		local control = directives[i]

		local component = layer[control[1]]
		for i = 2, #control, 2 do
			local idx = control[i]
			local delta = control[i + 1]
			component[idx] = component[idx] + delta * dt
		end
	end

	remaining = remaining - dt
	if remaining > 0 then
		tween[3] = remaining
	else
		return 3
	end
end		

-- Turns handwriten movement into "_generic"
-- Format: {type, x, y, rate}
local function mvCommon(layer, tween, dt, finish)
	local type, deltaX, deltaY, rate = unpack(tween, 1, 4)
	if type == "mvabs" then
		deltaX = deltaX - layer.args[2]
		deltaY = deltaY - layer.args[3]
	end

	local control = {"args"}
	if deltaX ~= 0 then
		table.insert(control, 2)
		table.insert(control, deltaX / rate)
	end
	if deltaY ~= 0 then
		table.insert(control, 3)
		table.insert(control, deltaY / rate)
	end
	tween[1] = "_generic"
	tween[2] = {control}
	table.remove(tween, 3)
	return genericVary(layer, tween, dt, finish)
end

local tweenOps = {
	-- Generic --
	_generic = genericVary,

	-- Delay --
	-- Format: {"delay", secs}
	delay = function(layer, tween, dt, finish)
		local secs = tween[2]
		if secs > 0 and not finish then
			tween[2] = secs - dt
		else
			return 2
		end
	end,

	-- Fades --
	-- Format: {"fadein" | "fadeout", rate}
	fadein = function(layer, tween, dt, finish)
		local alpha = layer.color[4]
		if alpha < 1 and not finish then
			local rate = tween[2]
			layer.color[4] = alpha + dt / rate
		else
			layer.color[4] = 1
			return 2
		end
	end,

	fadeout = function(layer, tween, dt, finish)
		local alpha = layer.color[4]
		if alpha > 0 and not finish then
			local rate = tween[2]
			layer.color[4] = alpha - dt / rate
		else
			layer.color[4] = 0
			return 2
		end
	end,

	-- Movement --
	mvdiff = mvCommon,
	mvabs = mvCommon,
}

local function layerUpdate(layerTable, dt, endTween)
	for i = #layerTable, 1, -1 do
		local layer = layerTable[i]
		local tween = layer.tween
		if tween and #tween > 0 then
			local remove = seqUpdate(tweenOps, layer, tween, dt,
				endTween)
			if remove == true then
				table.remove(layerTable, i)
			end
		end
	end
end

local function normalizeLayer(op)
	if not op.color then
		if op.tween and op.tween[1] == "fadein" then
			op.color = {1,1,1,0}
		else 
			op.color = {1,1,1,1}
		end
	end
end

local function normalizeIndex(tab, idx, default)
	if not idx then
		return default or #tab
	elseif idx < 1 then
		return #tab + idx
	else
		return idx
	end
end

local layerOps = {
	add = function(layers, op)
		normalizeLayer(op)
		if op[1] then
			table.insert(layers, op[1], op)
		else
			layers[#layers + 1] = op
		end
	end,

	set = function(layers, op)
		normalizeLayer(op)
		local idx = normalizeIndex(layers, op[1])
		layers[idx] = op
	end,

	rm = function(layers, op)
		local start = normalizeIndex(layers, op[1])
		local limit = normalizeIndex(layers, op[2], start)
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	mod = function(layers, op)
		local start = normalizeIndex(layers, op[1])
		local limit = normalizeIndex(layers, op[2], start)
		local bdc = f0b.std.basicDeepCopy
		for i = start, limit do
			for key, value in pairs(op) do
				if type(value) == "table" then
					layers[i][key] = bdc(value)
				elseif type(value) ~= "number" then
					layers[i][key] = value
				end
			end
		end
	end,

	finish = function(layers, _)
		return layerUpdate(layers, 0, true)
	end,

	clear = function(layers, _)
		for i = #layers, 1, -1 do
			layers[i] = nil
		end
	end,

	debug = function(layers, _)
		print(#layers)
	end,
}

return {
	ops = function(layerTable, directive)
		local op = table.remove(directive, 1)
		return layerOps[op](layerTable, directive)
	end,

	update = layerUpdate,

	draw = function(layerTable)
		for i = 1, #layerTable do
			local layer = layerTable[i]
			local drawFunc = layer.exec or love.graphics.draw
			love.graphics.setColor(layer.color)
			drawFunc(unpack(layer.args))
		end
	end,
}
