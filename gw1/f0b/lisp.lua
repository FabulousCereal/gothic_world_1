local function getInstruction(dataStack)
	local idx = #dataStack
	if idx > 2 then
		local data, pos, loop = dataStack[idx - 2], dataStack[idx - 1],
			dataStack[idx]
		if pos == #data then
			if loop then
				dataStack[idx - 1] = 1
			else
				dataStack[idx] = nil
				dataStack[idx - 1] = nil
				dataStack[idx - 2] = nil
			end
		else
			dataStack[idx - 1] = pos + 1
		end
		return data[pos]
	end
	return nil
end

local function rewind(dataStack, limit)
	for i = #dataStack, limit, -1 do
		dataStack[i] = nil
	end
end

return {
	restart = function(dataStack)
		dataStack[2] = 1
		return rewind(dataStack, 4)
	end,

	unwind = function(dataStack)
		return rewind(dataStack, 1)
	end,

	["break"] = function(dataStack)
		for i = #dataStack, 1, -3 do
			local wasLoop = dataStack[i]
			dataStack[i] = nil
			dataStack[i - 1] = nil
			dataStack[i - 2] = nil
			if wasLoop then
				break
			end
		end
	end,

	pop = function(dataStack, n)
		local len = #dataStack
		local limit = len - (n or 1) * 3 + 1
		for i = len, limit, -3 do
			dataStack[i] = nil
			dataStack[i - 1] = nil
			dataStack[i - 2] = nil
		end
	end,

	push = function(dataStack, data, loop)
		local i = #dataStack
		dataStack[i + 1] = data
		dataStack[i + 2] = 1
		dataStack[i + 3] = loop and true or false
	end,

	process = function(dataStack, ...)
		for inst in getInstruction, dataStack do
			local result = dataStack[type(inst)](inst, ...)
			if result then
				return result
			end
		end
	end,

	init = function(typeTable, instTable)
		local dataStack = f0b.table.deepCopy(typeTable)
		if instTable and not dataStack.table then
			dataStack.table = function(inst, ...)
				local copy = f0b.table.deepCopy(inst)
				return instTable[copy[1]](copy, ...)
			end
		end
		return dataStack
	end,
}
