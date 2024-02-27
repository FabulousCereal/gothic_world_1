-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function clearArray(table)
	for i = #table, 1, -1 do
		table[i] = nil
	end
	return table
end

local function basicDeepCopy(orig)
	local copy = {}
	for key, val in pairs(orig) do
		if type(val) == "table" then
			copy[key] = setmetatable(basicDeepCopy(val), getmetatable(val))
		else
			copy[key] = val
		end
	end
	return copy
end

local function typeFormat(val)
	if type(val) == "string" then
		return string.format("%q", val)
	end
	return tostring(val)
end

local function tableFormatFull(tab, depth, text, sep)
	local ins = table.insert
	ins(text, "{")
	local len = #text
	for key, val in pairs(tab) do
		ins(text, typeFormat(key))
		ins(text, "=")
		if type(val) == "table" and depth > 0 then
			tableFormatFull(val, depth - 1, text, sep)
		else
			ins(text, typeFormat(val))
		end
		ins(text, sep)
	end
	text[#text + (len == #text and 1 or 0)] = "}"
	return text
end

local function tableFormat(tab, depth, text, sep)
	return tableFormatFull(tab, depth or 0, text or {}, sep or ", ")
end

return {
	print = function(tab, depth)
		local sep = ","
		local text = tableFormat(tab, depth, nil, sep)
		local level = 0
		local pad = ""
		for i = 1, #text do
			local newline = true
			local s = text[i]
			if s == "{" then
				level = level + 1
				pad = string.rep(" ", level)
			elseif s == "}" then
				level = level - 1
				pad = string.rep(" ", level)
				io.stdout:write("\n")
				io.stdout:write(pad)
				newline = false
			elseif s ~= sep then
				newline = false
			end
			io.stdout:write(s)
			if newline then
				io.stdout:write("\n")
				io.stdout:write(pad)
			end
		end
		io.stdout:write("\n")
	end,

	format = tableFormat,

	deepCopy = basicDeepCopy,

	struct = {
		addField = function(struct, name, val)
			local defs = getmetatable(struct)
			defs[name] = true
			struct[name] = val
		end,

		new = function(keys)
			local defs = {}
			for _, val in ipairs(keys) do
				defs[val] = true
			end
			return setmetatable({}, {
				__name = "f0b.table.struct",
				__metatable = defs,

				__index = function(table, key)
					assert(defs[key],
						"tried to get undefined struct field: " .. typeFormat(key))
				end,

				__newindex = function(table, key, val)
					assert(defs[key],
						"tried to set undefined struct field: " .. typeFormat(key))
					rawset(table, key, val)
				end,
			})
		end,
	},

	dispatch = function(fnTable, defaultFn)
		if not defaultFn then
			defaultFn = function() end
		end
		return setmetatable(fnTable, {
			__index = function()
				return defaultFn
			end
		})
	end,

	clearArray = clearArray,

	clear = function(table)
		for k, _ in pairs(table) do
			table[k] = nil
		end
		return table
	end,

	moveArray = function(table, n)
		local len = #table - n
		if len > 0 then
			for i = 1, len do
				table[i] = table[i + n]
			end
			for i = #table, len + 1, -1 do
				table[i] = nil
			end
			return table
		end
		return clearArray(table)
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

	map = function(t, fn)
		for k, v in pairs(t) do
			t[k] = fn(v)
		end
		return t
	end,
}
