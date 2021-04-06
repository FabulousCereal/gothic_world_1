local seq = require("f0b._seqCommon")

-- Varies arbitrary variables --
-- Format: {"_generic", directives, timeRemaining}
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
		if not layer.color then
			layer.color = {1,1,1,0}
		end
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
		if not layer.color then
			layer.color = {1,1,1,1}
		end
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

local function normalizeArgs(args)
	local t = type(args[1])
	if t == "string" then
		args[1] = res.img[args[1]]
	elseif t == "function" then
		args[1] = args[1]()
	end
end

local function normalizeLayer(op)
	if op.tween and op.tween[1] == "fadein" and not op.color then
		op.color = {1,1,1,0}
	end
	op.args[1] = seq.normalizeSrc(res.img, op.args[1])
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

local function getNormalizedRange(table, defaultStart, defaultLimit)
	local start = normalizeIndex(table, defaultStart)
	local limit = normalizeIndex(table, defaultLimit, start)
	return start, limit
end

local function layerMod(layers, op, start, limit)
	local deepCopy = f0b.table.deepCopy
	for key, value in pairs(op) do
		local valType = type(value)
		for i = start, limit do
			if valType == "table" then
				local copy = deepCopy(value)
				layers[i][key] = copy
				if key == "args" then
					copy[1] = seq.normalizeSrc(res.img,
						copy[1])
				end
			elseif valType ~= "number" then
				layers[i][key] = value
			end
		end
	end
end	

local layerOps = {
	add = function(layers, op)
		normalizeLayer(op)
		local idx = op[1]
		if idx then
			table.insert(layers, idx, op)
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
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		for i = limit, start, -1 do
			table.remove(layers, i)
		end
	end,

	mod = function(layers, op)
		local start, limit = getNormalizedRange(layers, op[1], op[2])
		layerMod(layers, op, start, limit)
	end,

	modall = function(layers, op)
		layerMod(layers, op, 1, #layers)
	end,

	finish = function(layers)
		layerUpdate(layers, 0, true)
	end,

	clear = function(layers)
		for i = #layers, 1, -1 do
			layers[i] = nil
		end
	end,

	debug = function(layers)
		print(#layers)
	end,
}

return {
	ops = function(layerTable, op, directive)
		return layerOps[op](layerTable, directive)
	end,

	update = layerUpdate,

	draw = function(layerTable)
		local graphics = love.graphics
		for i = 1, #layerTable do
			local layer = layerTable[i]
--			normalizeArgs(layer.args)
			local drawFunc = layer.exec or graphics.draw
			graphics.setColor(layer.color or {1, 1, 1, 1})
			drawFunc(unpack(layer.args))
		end
	end,
}
