-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function fadeShort(args, target)
	local rate = args[2]
	table.insert(args, 3, rate)
	return target, rate
end

local fadeMap = {
	fadeout = function(args)
		return fadeShort(args, 0)
	end,

	fadein = function(args)
		return fadeShort(args, 1)
	end,

	fadeto = function(args)
		return f0b.math.clamp(args[2], 0, 1), args[3]
	end,
}

return {
	fadeCommon = function(val, fadeArgs, dt)
		local rate = fadeArgs[2]
		local newVal = val + rate*dt
		fadeArgs[3] = fadeArgs[3] - dt
		return f0b.math.clamp(newVal, 0, 1)
	end,

	fadeSetup = function(table, fadeArgs, dt, initVal, fn)
		local name = fadeArgs[1]
		local targetVal, rate = fadeMap[name](fadeArgs, initVal)
		fadeArgs[1] = "_fade"
		fadeArgs[2] = (targetVal - initVal) / rate
		return fn(table, fadeArgs, dt)
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
		repeat
			local op = seq[1]
			local advance, rem = funcs[op](target, seq, dt, finish)
			if advance then
				f0b.table.moveArray(seq, advance)
			end
			if rem then
				dt = -rem
			end
		until finish ~= true or #seq == 0 or seq[1] == true
		return seq[1]
	end,
}
