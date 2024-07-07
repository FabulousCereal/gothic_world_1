-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local tableGet = function(table, key) return table[key] end

return {
	-- Interpolates arbitrary values
	-- Format: {whatever, control}
	--   control = {where, updateFn, ellapsed, endTime, consume,
	--     index, fn, [index, fn, [...]]}
	interpolate = function(_, fade, dt)
		local control = fade[2]
		local where, updateFn, acc, endTime, consume =
			unpack(control, 1, 5)
		acc = acc + dt
		local ratio = endTime > 0 and math.min(acc / endTime, 1) or 1

		for i = 6, #control, 2 do
			local idx, fn = unpack(control, i, i+1)
			updateFn(where, idx, fn(ratio))
		end
		if acc >= endTime then
			return consume, endTime - acc
		end
		control[3] = acc
	end,

	interpolationLinear = function(args, init)
		if not init then
			init = tableGet
		end
		local where = args[1]
		for i = 6, #args, 2 do
			local idx, diff = args[i], args[i+1]
			local start = init
			if type(init) == "function" then
				start = init(where, idx)
			end
			args[i+1] = function(ratio) return start + diff*ratio end
		end
		return args
	end,

	normalizeSrc = function(loadFn, obj)
		local objType = type(obj)
		if objType == "string" then
			return loadFn(obj)
		elseif objType == "function" then
			return obj()
		end
		return obj
	end,

	update = function(funcs, target, seq, dt, finish)
		if finish then
			dt = math.huge
		end
		while #seq > 0 and seq[1] ~= true do
			local op = seq[1]
			local advance, rem = funcs[op](target, seq, dt, finish)
			if advance then
				f0b.table.moveArray(seq, advance)
			end
			if not finish then
				break
			elseif rem then
				dt = -rem
			end
		end
		return seq[1]
	end,

	fadeParse = function(t, fn, default, ...)
		local n = select("#", ...)
		local fade = select(n, ...)
		if n <= 1 then
			return fn(t, fade, default)
		end
		for i = 1, n-1 do
			fn(t, fade, select(i, ...))
		end
	end,
}
