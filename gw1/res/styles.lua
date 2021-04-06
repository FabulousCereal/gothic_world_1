return {
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

	vnMaria = {
		fontFamily = "dejavuSans",
		fontSize = 14,
		color = {1, 1, 1, 1},
		backgroundColor = {.25, 0, .25, .5},
		borderWidth = 2,
--		borderColor = {.5, .25, .5, 1},
		borderRadius = 6,
		lines = 4,
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

	vnFalcon = {
		"vnMaria",
		backgroundColor = {1, .5, 0, .2},
	},

	vnFab = {
		"vnMaria",
		backgroundColor = {.5, 0, 0, .5},
	},

	vnCroft = {
		"vnMaria",
		backgroundColor = {0, 0, .2, .5},
	},

	vnMartin = {
		"vnMaria",
		backgroundColor = {.5, 0, 0, .2},
	},
}
