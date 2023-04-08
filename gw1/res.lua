-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local base = f0b.std.dofileOr("res_table.lua", {})

local function setReturn(table, key, arg)
	table[key] = arg
	return arg
end

local function fontLoad(path)
	local cache = {}
	return function(name, size)
		local key = string.format("%s/%u", name, size)
		local seen = cache[key]
		if seen then
			return seen
		else
			name = path .. base.fontAlias[name]
			return setReturn(cache, key,
				love.graphics.newFont(name, size))
		end
	end
end		

local fontCache = fontLoad("res/fonts/")

local specialFallbacks = {
	font = function(style)
		local f = fontCache(style.fontFamily, style.fontSize)
		if style.lineHeight then
			f:setLineHeight(style.lineHeight)
		end
		return f
	end,
}

local defaultStyle = {
	lineHeight = 1,
	textAlign = "left",
	borderRadius = 0,
	borderWidth = 0,
}

local aliases = {
	borderColor = "color"
}

local fallbackMetatable = {
	__index = function(table, key)
		local alias = aliases[key]
		if alias then
			return setReturn(table, key, table[alias])
		end

		local fbFunc = specialFallbacks[key]
		if fbFunc then
			return setReturn(table, key, fbFunc(table))
		end

		local parent = rawget(table, 1)
		if parent then
			return setReturn(table, key, parent[key])
		end

		local default = defaultStyle[key]
		if default then
			return setReturn(table, key, default)
		end

		return nil
	end,
}			

local function setFallbacks(parent)
	local reserved = {"disabled", "unselected"}
	for i = 1, #reserved do
		local subvariant = parent[reserved[i]]
		if subvariant then
			-- Search key in parent table
			setmetatable(subvariant, {
				__index = function(self, key)
					return parent[key]
				end
			})
		end
	end
	return setmetatable(parent, fallbackMetatable)
end

local function setStyles(styleTable)
	if styleTable then
		for _, style in pairs(styleTable) do
			if style[1] then
				style[1] = styleTable[style[1]]
			end
			setFallbacks(style)
		end
		return styleTable
	end
end

local function loaderCurry(fn, path, arg)
	return function(name)
		return fn(path .. name, arg)
	end
end

local function funLoad(path)
	local fun = {}
	for _, file in pairs(love.filesystem.getDirectoryItems(path)) do
		if file:sub(-4) == ".lua" then
			local k = file:sub(0, -5)
			fun[k] = f0b.std.dofile(path .. file)
		end
	end
	return fun		
end

local dataPath = "res/data/"

res = {
	dataPath = dataPath,
	index = f0b.std.dofileOr(dataPath .. "index.lua"),

	font = fontCache,

	fun = funLoad("res/fun/"),

	sfx = loaderCurry(love.audio.newSource, "res/audio/", "static"),

	bgm = loaderCurry(love.audio.newSource, "res/audio/", "stream"),

	img = loaderCurry(love.graphics.newImage, "res/img/"),

	chrono = {
		textSpeed = 1/40,
		keyRepeat = 1/30,
		keyFirstHold = 1/6,
	},

	palette = function(name, alpha, mult)
		local color = base.palette[name]
		if color ~= nil then
			color = {unpack(color)}
			if mult then
				for i = 1, #color do
					color[i] = color[i] * mult
				end
			end
			color[4] = alpha or 1
			return color
		end
		return false
	end,

	style = setStyles(base.style),
}
