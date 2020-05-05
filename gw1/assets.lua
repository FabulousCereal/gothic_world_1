local base = {
	fonts = {
		kappa = "kappa10x20.pcf.gz",
		ayu = "ayu-mincho9x18m.pcf.gz",
		sony = "sony12x24.pcf.gz",
		caption = "caption.pcf.gz",

		teletext1 = "teletext1.pcf.gz",
		teletext2 = "teletext2.pcf.gz",
		teletext4 = "teletext4.pcf.gz",

		biwidth = "efont-biwidth16.pcf.gz",
		helvetica = "helvR14.pcf.gz",

		ncentury14 = "ncenR14.pcf.gz",
		ncentury18 = "ncenR18.pcf.gz",
		ncentury24 = "ncenR24.pcf.gz",

		dejavuSans = "DejaVuSans.ttf",
		dejavuSerif = "DejaVuSerif.ttf",

		dseg7 = "DSEG7Classic-Regular.ttf",

		proof = "proof9x16_c.pcf.gz",
		vollkorn = "Vollkorn-Black.ttf",
		takaoMincho = "TakaoMincho.ttf",
		libertineM = "LinLibertine_M.otf",
		compagnonRoman = "Compagnon-Roman.otf",
		ebGaramond08 = "EBGaramond08-Regular.otf",
		ebGaramond12 = "EBGaramond12-Regular.otf",
	},

	palette = {
		repellantYellow = {.35, .35, .3},
		tenpm = {.55, .55, .7},

		-- Bake
		redbg = {1, 0, 0},
		fivepm = {1, .75, .45},
		sixpm = {.6, .4, .5},
		hardPurple = {.8, 0, 1},

		-- Fab
		softAfternoon = {1, .95, .8},
		tungsten = {1, .5, .25},
	},
}

local fontCache = setmetatable({}, {
	__index = function(self, key)
		local name, size = string.match(key, "([^_]+)_(%d+)$")
		name = "res/fonts/" .. base.fonts[name]
		size = tonumber(size)

		local font = love.graphics.newFont(name, size)
		self[key] = font
		return font
	end,

	__call = function(self, name, size)
		local key = string.format("%s_%u", name, size)
		if self[key] then
			return self[key]
		else
			local font = love.graphics.newFont(
				"res/fonts/" .. base.fonts[name], size)
			self[key] = font
			return font
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
}

local aliases = {
	borderColor = "color"
}

local fallbackMetatable = {
	__index = function(table, key)
		local alias = aliases[key]
		if alias then
			local val = table[alias]
			table[key] = val
			return val
		end

		local fbFunc = specialFallbacks[key]
		if fbFunc then
			local val = fbFunc(table)
			table[key] = val
			return val
		end

		local parent = rawget(table, 1)
		if parent then
			local val = lib.style[parent][key]
			table[key] = val
			return val
		end

		local default = defaultStyle[key]
		if default then
			table[key] = default
			return default
		end

		return nil
	end,
}			

local function setFallbacks(style)
	local reserved = {"disabled", "unselected"}
	for i = 1, #reserved do
		local descent = style[reserved[i]]
		if descent then
			-- Fetches key from parent table
			setmetatable(descent, {
				__index = function(self, key)
					return style[key]
				end
			})
		end
	end

	return setmetatable(style, fallbackMetatable)
end

local function setStyles(styleTable)
	for key, style in pairs(styleTable) do
		styleTable[key] = setFallbacks(style)
	end
	return styleTable
end

return {
	index = {
		{name = "Prefacio", noNumbers = true, segue = true,
			{"por Michelle", "-1"}},

		{name = "Prólogo",
			{"El Sueño de Morfeo", "0"},
			{"Bakeritsu, el Espadachín Romántico", "1"},
			{"Fabian llega a la Ciudad", "2"},
			{"FÃ¶¬â¡¢", "3"},
			{"Fin del Primer Día", "4"}},

		{name = "Gothic World",
			{"María, la heroína", "5"},
			{"heroína, lol", "6"},
			{"420, blaze it", "7"},
			{"María Juana le decían", "8"}},

		{name = "pruebas de función", noNumbers = true,
			{"texto", "test1"},
			{"selección", "test2"}},

		{name = "¿por que te agradaron más mis lágrimas, Daphne mía?"},

	},

	font = fontCache,

	sfx = setmetatable({}, {
		__index = function(self, key)
			local source = love.audio.newSource(
				"res/sfx/" .. key, "static"
			)
			return source
		end
	}),

	bgm = setmetatable({}, {
		__index = function(self, key)
			local source = love.audio.newSource(
				"res/bgm/" .. key, "stream"
			)
			return source
		end
	}),

	img = setmetatable({}, {
		__index = function(self, key)
			local source = love.graphics.newImage(
				"res/img/" .. key
			)
			return source
		end
	}),

	gen = require("res.code.all"),

	chrono = {
		textSpeed = 1/60,
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

	style = setStyles({
		menu = {
			fontFamily = "ncentury18",
			fontSize = 18,
			color = {1, 0, 0, 1},
			backgroundColor = {0, 0, 0, 1},
			padding = .25,
			borderWidth = 1,
			lineSpacing = 5/3,
			disabled = {
				color = {.5, 0, .5, 1},
			},
		},

		subtitles = {
			fontFamily = "caption",
			fontSize = 26,
			color = {1, 1, 1, 1},
			backgroundColor = {0, 0, 0, 1},
			padding = .25,
			margin = 2,
		},

		clockTint = {
			fontFamily = "takaoMincho",
			fontSize = 48,
			color = {1/12, 1/12, 1/12, 1},
			backgroundColor = {11/12, 11/12, 11/12, 1},
			borderWidth = 12
		},

		clockMono = {
			fontFamily = "takaoMincho",
			fontSize = 48,
			color = {0, 0, 0, 1},
			backgroundColor = {1, 1, 1, 1},
			borderWidth = 12
		},

		clockAlarm = {
			fontFamily = "dseg7",
			fontSize = 72,
			color = {1, 0, 0, 1},
			backgroundColor = {1/8, 0, 1/8, 1},
		},

		carClockAlarm = {
			fontFamily = "dseg7",
			fontSize = 72,
			color = {12/12, 11/12, 12/12, 1},
			backgroundColor = {2/12, 1/12, 2/12, 1},
		},

		titleCard = {
			fontFamily = "takaoMincho",
			fontSize = 72,
			color = {1, 1, .8, 1},
		},

		vnMaria = {
			fontFamily = "dejavuSans",
			fontSize = 14,
			color = {1, 1, 1, 1},
			backgroundColor = {.25, 0, .25, .5},
			borderWidth = 2,
--			borderColor = {.5, .25, .5, 1},
			borderRadius = 6,
			lineSpacing = 2,
			margin = 1,
			padding = 1,
			unselected = {
				borderColor = {.5, .5, .5, .75},
				backgroundColor = {.25, .25, .25, .5},
			}
		},

		vnBake = {
			"vnMaria",
			backgroundColor = {0, .25, .1, .5},
		},

		vnFab = {
			"vnMaria",
			backgroundColor = {.5, 0, 0, .5},
		},

		vnFalcon = {
			"vnMaria",
			backgroundColor = {1, .5, 0, .2},
		},

		vnCroft = {
			"vnMaria",
			backgroundColor = {0, 0, .2, .5},
		},

		vnMartin = {
			"vnMaria",
			backgroundColor = {.5, 0, 0, .2},
		},
	})
}
