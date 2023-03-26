-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local clearArray = require("f0b.table").clearArray

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

local function push(proc, data, loop)
	assert(type(data) == "table", "pushed data is not a list")
	local i = #proc
	proc[i + 1] = data
	proc[i + 2] = loop and true or false
	proc[i + 3] = 1
end

return {
	["break"] = function(proc)
		for i = #proc, 1, -3 do
			local wasLoop = proc[i]
			clearCur(proc, i)
			if wasLoop then
				break
			end
		end
	end,

	push = push,

	set = function(proc, ...)
		clearArray(proc)
		return push(proc, ...)
	end,

	trace = function(proc)
		local text = {}
		for i = #proc, 1, -3 do
			local data, pos = proc[i-2], proc[i]
			pos = pos - 1
			if pos == 0 then
				pos = #data
			end
			local inst = data[pos]
			if type(inst) == "table" then
				f0b.table.format(inst, 0, text)
			else
				table.insert(text, tostring(inst))
			end
			table.insert(text, "\n")
		end
		return text
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
