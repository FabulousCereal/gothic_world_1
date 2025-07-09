-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

local base = f0b.std.dofileOr("res_table.lua", {})

local setReturn = f0b.table.set

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

	em = function(style)
		local f = fontCache(style.fontFamily, style.fontSize)
		return f:getHeight()
	end,
}

local defaultStyle = {
	lineHeight = 1,
	textAlign = "left",
	borderRadius = 0,
	borderWidth = 0,
	color = {1, 1, 1, 1},
	backgroundColor = {0, 0, 0, 0},
}

local aliases = {
	borderColor = "color"
}

local fallbackMetatable = {
	__index = function(style, key)
		local alias = aliases[key]
		if alias then
			return setReturn(style, key, style[alias])
		end

		local fbFunc = specialFallbacks[key]
		if fbFunc then
			return setReturn(style, key, fbFunc(style))
		end

		local parent = rawget(style, 1)
		if parent then
			return setReturn(style, key, parent(key))
		end
		return setReturn(style, key, defaultStyle[key])
	end,
}

local function indirectAccess(table)
	-- Protect against recursion
	return function(key) return table[key] end
end

local function setFallbacks(parent)
	local reserved = {"disabled", "unselected"}
	for i = 1, #reserved do
		local subvariant = parent[reserved[i]]
		if subvariant then
			subvariant[1] = indirectAccess(parent)
			-- Search key in parent table
			setFallbacks(subvariant)
		end
	end
	return setmetatable(parent, fallbackMetatable)
end

local function setStyles(styleTable)
	if styleTable then
		for _, style in pairs(styleTable) do
			if style[1] then
				style[1] = indirectAccess(styleTable[style[1]])
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

local ctxMetatable = {
	__call = f0b.table.union,
}

local function shaderCtx(ctx)
	return setmetatable(f0b.table.deepCopy(ctx), ctxMetatable)
end

local shaderAccess = {
	userdata = function(shader, src, key)
		return setReturn(src, key, {shader})
	end,
	string = function(str, src, key)
		return setReturn(src, key, {love.graphics.newShader(str)})
	end,
	table = function(ctx, _, _)
		local shader = ctx[1]
		if type(shader) == "string" then
			ctx[1] = love.graphics.newShader(shader)
		end
		return ctx
	end,
}

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

	shader = setmetatable({}, {
		__index = function(_, key)
			local src = base.shader
			local shader = src[key]
			return shaderCtx(shaderAccess[type(shader)](shader, src, key))
		end,
	}),

	doll = setmetatable({}, {
		__index = function(table, key)
			local info = base.doll[key]
			local img = res.img(info[1] .. key .. ".png")
			return setReturn(table, key, {img, unpack(info, 2)})
		end,
	})
}
