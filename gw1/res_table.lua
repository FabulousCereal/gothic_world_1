-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

return {
	fontAlias = {
		dejaVuSans = "DejaVuSans.ttf",
		dseg7 = "DSEG7Classic-Regular.ttf",
		ncentury18 = "ncenR18.pcf.gz",
		takaoMincho = "TakaoMincho.ttf",
		vollkorn = "Vollkorn-Black.ttf",
		terminus = "ter-u28n_unicode.pcf.gz",
	},

	palette = {
		repellantYellow = {.35, .35, .3},
		tenpm = {.6, .6, .75},
		redbg = {1, 0, 0},
		fivepm = {1, .65, .35},
		sixpm = {.55, .35, .5},
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
			margin = .5,
			width = "adapt",
			disabled = {
				color = {.5, 0, .5, 1},
			},
			unselected = {
				borderColor = {0, 0, 0, 0},
			},
		},

		title = {
			"menu",
			fontFamily = "takaoMincho",
			fontSize = 52,
			color = {1, 1, 1, 1},
		},

		subtitles = {
			fontFamily = "terminus",
			fontSize = 28,
			color = {1, 1, 1, 1},
			backgroundColor = {0, 0, 0, 1},
			padding = .2,
			margin = 2,
			disabled = {
				color = {.5, .5, .5, 1},
			}
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
			backgroundColor = {.125, .125, .125, 3/4},
			borderWidth = 2,
	--		borderColor = {.5, .25, .5, 1},
			borderRadius = 6,
			shader = "rect",
			lines = 4,
			lineSpacing = 2,
			margin = 1,
			padding = 1,
			hover = true,
			unselected = {
	--			borderColor = {.5, .5, .5, .5},
				backgroundColor = {.25, .25, .25, 3/4},
			}
		},

		vnMichelle = {
			fontFamily = "takaoMincho",
			fontSize = 24,
			color = {1, 0, 0, 1},
			backgroundColor = {0, 0, 0, 1},
			borderWidth = 0,
			margin = 1,
			padding = 1,
			lines = 4,
		},

		vnMaria = {
			"vn",
			backgroundColor = {1/3, 0, 1/3, 3/4},
		},

		vnBake = {
			"vn",
			backgroundColor = {0, .2, 0, 3/4},
		},

		vnFalcon = {
			"vn",
			backgroundColor = {.5, .25, 0, 3/4},
		},

		vnFab = {
			"vn",
			backgroundColor = {.5, 0, 0, 3/4},
		},

		vnCroft = {
			"vn",
			backgroundColor = {0, 0, .25, 3/4},
		},

		vnMartin = {
			"vn",
			backgroundColor = {.5, 0, 0, 3/4},
		},
	},

	shader = {
		rect = [[
			uniform float style_borderRadius;
			uniform float style_borderWidth;
			uniform vec4 style_borderColor;
			uniform vec4 style_backgroundColor;

			float sdf(vec2 pos, vec2 size, float radius) {
				vec2 d = abs(pos) - size + vec2(radius);
				return clamp(d.x, d.y, 0.0)
					+ length(max(d, vec2(0.0))) - radius;
			}
			float aliasing(float dist) {
				const float aliasing = 1.0;

				float d = abs(dist) - style_borderWidth;
				return smoothstep(-aliasing, aliasing, d);
				//return = step(0, d);
			}
			vec4 get_color(float dist) {
				const vec4 outside_color = vec4(0.0);

				vec4 side_color = dist < 0.0
					? style_backgroundColor
					: outside_color;
				return mix(style_borderColor, side_color,
					aliasing(dist));
			}
			vec4 effect(vec4 color, Image _tex, vec2 tex_coord, vec2 _screen_coord) {
				vec2 texSize = vec2(1.0) / fwidth(tex_coord);
				vec2 size = texSize - vec2(style_borderWidth);
				vec2 normal_coord = tex_coord * texSize * vec2(2.0) - texSize;
				float dist = sdf(normal_coord, size, style_borderRadius*2.0);
				return color * get_color(dist);
			}
		]],
	},
}
