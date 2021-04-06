local base = {
	fonts = f0b.std.dofileOr("res/fonts/alias.lua"),

	palette = f0b.std.dofileOr("res/palette.lua"),
}

local function setReturn(table, key, arg)
	table[key] = arg
	return arg
end

local fontCache = setmetatable({}, {
	__index = function(self, key)
		local name, size = string.match(key, "([^_]+)_(%d+)$")
		name = "res/fonts/" .. base.fonts[name]
		size = tonumber(size)

		return setReturn(self, key, love.graphics.newFont(name, size))
	end,

	__call = function(self, name, size)
		local key = string.format("%s_%u", name, size)
		if self[key] then
			return self[key]
		else
			name = "res/fonts/" .. base.fonts[name]
			return setReturn(self, key,
				love.graphics.newFont(name, size))
		end
	end
})

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

local function setStyles(filename)
	local styleTable = f0b.std.dofileOr(filename)
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

local function resLoader(fn, path, arg)
	return setmetatable({}, {
		__call = function(_, key)
			return fn(path .. key, arg)
		end,

		__index = function(table, key)
			local val = fn(path .. key, arg)
			table[key] = val
			return val
		end,
	})
end

res = {
	index = f0b.std.dofileOr("data/index.lua"),

	font = fontCache,

	sfx = resLoader(love.audio.newSource, "res/sfx/", "static"),

	bgm = resLoader(love.audio.newSource, "res/bgm/", "stream"),

	img = resLoader(love.graphics.newImage, "res/img/"),

	gen = f0b.std.dofileOr("res/code/all.lua"),

	chrono = {
		textSpeed = 1/60,
		keyRepeat = 1/30,
		keyFirstHold = 1/6,
	},

	palette = function(name, alpha, mult)
		local color = {unpack(base.palette[name])}
		if mult then
			for i = 1, #color do
				color[i] = color[i] * mult
			end
		end
		color[4] = alpha or 1
		return color
	end,

	style = setStyles("res/styles.lua"),
}
