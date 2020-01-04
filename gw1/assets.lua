local stages = {
	"-1",
	"0",
	"1",
	"2",
	"3", "4", "5",
}

local fonts = {
	kappa = "kappa10x20.pcf.gz",
	ayu = "ayu-mincho9x18m.pcf.gz",
	sony = "sony12x24.pcf.gz",
	caption = "caption.pcf.gz",
	biwidth = "efont-biwidth16.pcf.gz",
	helvetica = "helvR14.pcf.gz",
	ncentury = "ncenR14.pcf.gz",
	dejavu = "DejaVuSans.ttf",
	proof = "proof9x16_c.pcf.gz",
	vollkorn = "Vollkorn-Black.ttf",
}

local resources = {
	fonts = "res/fonts/",
	sfx = "res/sfx/",
	bgm = "res/bgm/",
	img = "res/img/",
}

local lib = {
	stages = setmetatable({}, {
		__index = function(_, key)
			if stages[key] then
				return "data." .. stages[key]
			else
				return nil
			end
		end
	}),

	fonts = setmetatable({}, {
		__index = function(self, key)
			local name, size = string.match(key, "(..-)(%d*)$")
			if size then
				size = tonumber(size)
			end
			local source = love.graphics.newFont(
				resources.fonts .. fonts[name], size
			)
			self[key] = source
			return source
		end
	}),

	sfx = setmetatable({}, {
		__index = function(self, key)
			local source = love.audio.newSource(
				resources.sfx .. key, "static"
			)
			return source
		end
	}),

	bgm = setmetatable({}, {
		__index = function(self, key)
			local source = love.audio.newSource(
				resources.bgm .. key, "stream"
			)
			source:setLooping(true)
			return source
		end
	}),

	img = setmetatable({}, {
		__index = function(self, key)
			local source = love.graphics.newImage(
				resources.img .. key
			)
			return source
		end
	}),

	color = {
		redbg = {.8, 0, 0},
		fivepm = {.8, .6, .3},
	},
}

local metastyle = {
	__index = function(self, key)
		local source = lib.style[self[1]][key]
		self[key] = source
		return source
	end
}

lib.style = {
	menu = {
		font = lib.fonts["ayu18"],
		borderWidth = 1,
	},

	subtitles = {
		font = lib.fonts["caption26"],
		color = {1,1,1,1},
		backgroundColor = {0,0,0,.25},
		margin = 2,
	},

	vnDefault = {
		font = lib.fonts["dejavu13"],
		color = {1,1,1,1},
		backgroundColor = {.2, 0, .2, .5},
		borderWidth = 2,
		borderColor = {1,1,1,1},
		borderRadius = 6,
		margin = 1,
		padding = 1,
	},

	vnBake = setmetatable({
		"vnDefault",
		backgroundColor = {0, 1/3, .1, .4},
	}, metastyle),

	vnFab = setmetatable({
		"vnDefault",
		backgroundColor = {.5, 0, 0, .5},
	}, metastyle),

	vnFalcon = setmetatable({
		"vnDefault",
		backgroundColor = {1, .5, 0, .2},
	}, metastyle),

	vnCroft = setmetatable({
		"vnDefault",
		backgroundColor = {0, 0, .2, .5},
	}, metastyle),

	vnMartin = setmetatable({
		"vnDefault",
		backgroundColor = {.5, 0, 0, .2},
	}, metastyle),

	chrono = {
		textSpeed = 1 / 60,
	}
}

for name, style in pairs(lib.style) do
	if not style[1] then
		if style.font then
			style.em = style.font:getHeight()
			if style.lineHeight then
				style.font:setLineHeight(style.lineHeight)
			else
				style.lineHeight = 1
			end
		end
	end
end

return lib
