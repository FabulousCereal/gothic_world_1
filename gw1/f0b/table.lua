-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function basicDeepCopy(orig)
	local copy = {}
	for key, val in pairs(orig) do
		if type(val) == "table" then
			copy[key] = basicDeepCopy(val)
		else
			copy[key] = val
		end
	end
	return copy
end

local function tablePrint(table, depth, pad)
	if not depth then
		depth = math.huge
	end
	if depth > 0 then
		if not pad then
			pad = 0
		end

		local padding = string.rep(" ", pad * 2)
		for key, val in pairs(table) do
			local valType = type(val)
			local base = padding .. key .. "="
			if valType == "table" then
				print(base .. "{")
				tablePrint(val, depth - 1, pad + 1)
				print(padding .. "}")
			elseif valType == "userdata" then
				print(base .. "userdata")
			else
				print(base .. tostring(val))
			end
		end
	end
end

return {
	print = tablePrint,

	deepCopy = basicDeepCopy,

	clear = function(table)
		for k, _ in pairs(table) do
			table[k] = nil
		end
		return table
	end,

	union = function(...)
		local t = {}
		for i = 1, select("#", ...) do
			for k, v in pairs(select(i, ...)) do
				t[k] = v
			end
		end
		return t
	end,
}
