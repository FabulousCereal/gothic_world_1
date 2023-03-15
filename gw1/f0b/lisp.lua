-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function clearCur(proc, i)
	proc[i] = nil
	proc[i - 1] = nil
	proc[i - 2] = nil
end

local function instructionIter(proc)
	local idx = #proc
	if idx >= 3 then
		local data, loop, pos = proc[idx - 2], proc[idx - 1],
			proc[idx]
		if pos == #data then
			if loop then
				proc[idx] = 1
			else
				clearCur(proc, idx)
			end
		else
			proc[idx] = pos + 1
		end
		return data[pos]
	end
	return nil
end

local function rewindTo(proc, limit)
	for i = #proc, limit, -1 do
		proc[i] = nil
	end
end

local function clear(proc)
	return rewindTo(proc, 1)
end

local function push(proc, data, loop)
	local i = #proc
	proc[i + 1] = data
	proc[i + 2] = loop and true or false
	proc[i + 3] = 1
end

return {
	rewind = function(proc)
		proc[2] = 1
		return rewindTo(proc, 4)
	end,

	clear = clear,

	["break"] = function(proc)
		for i = #proc, 1, -3 do
			local wasLoop = proc[i]
			clearCur(proc, i)
			if wasLoop then
				break
			end
		end
	end,

	pop = function(proc, n)
		local len = #proc
		local limit = len - (n or 1) * 3 + 1
		for i = len, limit, -3 do
			clearCur(proc, i)
		end
	end,

	push = push,

	set = function(proc, ...)
		clear(proc)
		return push(proc, ...)
	end,

	process = function(proc, ...)
		for inst in instructionIter, proc do
			local result = proc[type(inst)](inst, ...)
			if result then
				return result
			end
		end
	end,

	init = function(typeTable, instTable)
		local proc = f0b.table.deepCopy(typeTable)
		if instTable and not proc.table then
			proc.table = function(inst, ...)
				local copy = f0b.table.deepCopy(inst)
				return instTable[copy[1]](copy, ...)
			end
		end
		return proc
	end,
}
