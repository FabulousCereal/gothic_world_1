return {
	fontAlias = {
		caption = "caption.pcf.gz",
		dejaVuSans = "DejaVuSans.ttf",
		dseg7 = "DSEG7Classic-Regular.ttf",
		ncentury18 = "ncenR18.pcf.gz",
		takaoMincho = "TakaoMincho.ttf",
		vollkorn = "Vollkorn-Black.ttf",

		kappa = "kappa10x20.pcf.gz",
		ayu = "ayu-mincho9x18m.pcf.gz",
		sony = "sony12x24.pcf.gz",

		teletext1 = "teletext1.pcf.gz",
		teletext2 = "teletext2.pcf.gz",
		teletext4 = "teletext4.pcf.gz",

		biwidth = "efont-biwidth16.pcf.gz",
		helvetica = "helvR14.pcf.gz",

		ncentury14 = "ncenR14.pcf.gz",
		ncentury24 = "ncenR24.pcf.gz",
		proof = "proof9x16_c.pcf.gz",
	},

	palette = {
		repellantYellow = {.35, .35, .3},
		tenpm = {.6, .6, .75},
		redbg = {1, 0, 0},
		fivepm = {1, .75, .45},
		sixpm = {.6, .4, .5},
		softAfternoon = {1, .95, .8},
	},

	style = {
		menu = {
			fontFamily = "ncentury18",
			fontSize = 18,
			color = {1, 0, 0, 1},
			backgroundColor = {0, 0, 0, .5},
			padding = .25,
			borderWidth = 1,
			lineSpacing = 5/3,
			disabled = {
				color = {.5, 0, .5, 1},
			},
		},

		title = {
			"menu",
			fontFamily = "takaoMincho",
			fontSize = 52,
			color = {1, 1, 1, 1},
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
			"clockTint",
			color = {0, 0, 0, 1},
			backgroundColor = {1, 1, 1, 1},
		},

		clockAlarm = {
			fontFamily = "dseg7",
			fontSize = 72,
			color = {1, 0, 0, 1},
			backgroundColor = {1/8, 0, 1/8, 1},
		},

		carClockAlarm = {
			"clockAlarm",
			color = {12/12, 11/12, 12/12, 1},
			backgroundColor = {2/12, 1/12, 2/12, 1},
		},

		vn = {
			fontFamily = "dejaVuSans",
			fontSize = 14,
			color = {1, 1, 1, 1},
			backgroundColor = {.125, .25, .125, .5},
			borderWidth = 2,
	--		borderColor = {.5, .25, .5, 1},
			borderRadius = 6,
			lines = 4,
			lineSpacing = 2,
			margin = 1,
			padding = 1,
			unselected = {
	--			borderColor = {.5, .5, .5, .5},
				backgroundColor = {.125, .125, .125, .5},
			}
		},

		vnMaria = {
			"vn",
			backgroundColor = {.25, 0, .25, .5},
		},

		vnBake = {
			"vn",
			backgroundColor = {0, .25, .1, .5},
		},

		vnFalcon = {
			"vn",
			backgroundColor = {.5, .25, 0, .5},
		},

		vnFab = {
			"vn",
			backgroundColor = {.5, 0, 0, .5},
		},

		vnCroft = {
			"vn",
			backgroundColor = {0, 0, .2, .5},
		},

		vnMartin = {
			"vn",
			backgroundColor = {.5, 0, 0, .5},
		},
	}
}
