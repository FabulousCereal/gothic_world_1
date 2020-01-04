-- Varies arbitrary variables --
-- Format: {"_generic", directives, (time) remaining, remove}
--   directives = {control, [control, [...]]}
--     control = {component, index, delta, [index, delta, [...]]}
local function genericVary(layer, dt, finish)
	local tween = layer.tween
	local remaining = tween[3]
	if finish or dt > remaining then
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
	if remaining <= 0 then
		local remove = tween[4]
		if remove then
			layer.remove = true
		else
			tween[1] = false
		end
	else
		tween[3] = remaining
	end
end		

-- Internal movement --
-- Format: {"_mv", deltaX, deltaY, (time) remaining, remove}
local function internalMV(layer, dt, finish)
	local tween, args = layer.tween, layer.args
	local remaining = tween[4]
	if finish or dt > remaining then
		dt = remaining
	end
	local deltaX, deltaY = tween[2], tween[3]
	args[2] = args[2] + deltaX * dt
	args[3] = args[3] + deltaY * dt
	remaining = remaining - dt
	if remaining <= 0 then
		if tween[5] then
			layer.remove = true
		else
			tween[1] = false
		end
	else
		tween[4] = remaining
	end
end

local function mvCommon(layer, dt, finish)
	local tween = layer.tween
	local type, deltaX, deltaY, rate = unpack(tween)
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
	return genericVary(layer, dt, finish)
	
--	tween[1] = "_mv"
--	tween[2] = diffX / rate
--	tween[3] = diffY / rate
--	return internalMV(layer, dt, finish)
end

local tweenOps = {
	-- Generic --
	_generic = genericVary,

	-- Delay --
	-- Format: {"delay", secs, (true || nextOp), [...]}
	delay = function(layer, dt, finish)
		local tween = layer.tween
		local secs = tween[2]
		if secs > 0 and not finish then
			tween[2] = secs - dt
		else
			table.remove(tween, 1)
			table.remove(tween, 1)
			if tween[1] == true then
				layer.remove = true
			end
		end
	end,

	-- Fades --
	-- Format: {type, rate, remove}
	fadein = function(layer, dt, finish)
		local alpha = layer.color[4]
		if alpha < 1 and not finish then
			local rate = layer.tween[2]
			layer.color[4] = alpha + dt / rate
		else
			if layer.tween[3] then
				layer.remove = true
			else
				layer.color[4] = 1
				layer.tween[1] = false
			end
		end
	end,

	fadeout = function(layer, dt, finish)
		local alpha = layer.color[4]
		if alpha > 0 and not finish then
			local rate = layer.tween[2]
			layer.color[4] = alpha - dt / rate
		else
			if layer.tween[3] then
				layer.remove = true
			else
				layer.color[4] = 0
				layer.tween[1] = false
			end
		end
	end,

	-- Movement --
	-- Format: {type, x, y, rate, remove}
	mvdiff = mvCommon,

	mvabs = mvCommon,

	_mv = internalMV,
}

local function normalizeLayer(op)
	if not op.color then
		if op.tween and op.tween[1] == "fadein" then
			op.color = {1,1,1,0}
		else 
			op.color = {1,1,1,1}
		end
	elseif type(op.color[1]) == "table" then
		local alpha = op.color[2]
		op.color = {
			unpack(op.color[1])
		}
		op.color[4] = alpha
	end
end

local function normalizeIndex(tab, idx)
	if not idx then
		return #tab
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
		if op[2] then
			local start = normalizeIndex(layers, op[1])
			local limit = normalizeIndex(layers, op[2])
			for i = limit, start, -1 do
				table.remove(layers, i)
			end
		else
			table.remove(layers, normalizeIndex(layers, op[1]))
		end
	end,

	mod = function(layers, op)
		local idx = normalizeIndex(layers, op[1])
		for key, value in pairs(op) do
			layers[idx][key] = value
		end
	end,

	finish = function(layers, op)
		for i = #layers, 1, -1 do
			local ly = layers[i]
			if ly.tween and ly.tween[1] then
				tweenOps[ly.tween[1]](ly, 0, true)
				if ly.remove then
					table.remove(layers, i)
				end
			end
		end
	end,

	clear = function(layers, op)
		for i = #layers, 1, -1 do
			layers[i] = nil
		end
	end,
}

return {
	ops = function(layerTable, directive)
		local op = table.remove(directive, 1)
		return layerOps[op](layerTable, directive)
	end,

	update = function(layerTable, dt, endTween)
		for i = #layerTable, 1, -1 do
			local layer = layerTable[i]
			if layer.remove then
				table.remove(layerTable, i)
			elseif layer.tween and layer.tween[1] then
				local op = layer.tween[1]
				tweenOps[op](layer, dt, endTween)
				if endTween and op == "delay" then
					tweenOps[op](layer, dt, endTween)
				end
			end
		end
	end,

	draw = function(layerTable)
		for i = 1, #layerTable do
			local layer = layerTable[i]
			local drawFunc = layer.exec
			if not drawFunc then
				drawFunc = love.graphics.draw
			end
			love.graphics.setColor(layer.color)
			drawFunc(unpack(layer.args))
		end
	end,
}
