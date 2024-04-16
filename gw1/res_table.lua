-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function fbm(wrap)
	local code = string.format([[
			uniform vec2 tune;
			uniform float rolloff;
			uniform float amplitude;
			uniform float value;
			uniform vec2 mv;

			uniform float alphaMask;
			uniform vec2 mul;
			uniform vec2 add;

			float hash(vec2 f) {
				// Adapted from https://www.shadertoy.com/view/4djSRW
				// These constants aren't special, they just
				// look ok.
				const vec2 i = vec2(19.0/31.0);
				const vec2 h = vec2(23.0/7.0);
				f = fract(f * i);
				f += dot(f.xyxy, (f + h).xxyy);
				return fract(dot(f.xy, f.xx));
			}

			float fnoise2(vec2 pos) {
				vec2 i = floor(pos);
				vec2 f = pos - i;
				vec2 c = vec2(0.0, 1.0);
				vec4 h = vec4(
					hash(i),
					hash(i + c.yx),
					hash(i + c.xy),
					hash(i + c.yy)
				);
				//vec2 s = f*f*(3.0-2.0*f);
				vec2 s = sin(f * %.10f);
				vec2 m = vec2(1.0 - s.x, s.x);
				float a = dot(h.xy, m);
				return (dot(h.zw, m) - a)*s.y + a;
			}

			float fbm(vec2 pos) {
				float val = value;
				float amp = amplitude;
				for (int i = 0; i < 8; ++i) {
					val += amp * fnoise2(pos);
					amp *= rolloff;
					pos *= tune;
				}
				return val;
			}

			vec2 fbm2(vec2 x) {
				const vec2 r = vec2(2.0);
				return vec2(fbm(x - r), fbm(x + r));
			}

			float fbmThirdDegree(vec2 p) {
				// How does this work, this is magic or smth
				vec2 q = fbm2(p);
				vec2 r = fbm2(p - mv + q);
				return fbm(p + mv + r);
			}

			%s

			vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _) {
				vec4 g = vec4(generate((texCoord+add)*mul));
				g.a = mix(1.0, g.a, alphaMask);
				return color * Texel(tex, texCoord) * g;
			}
		]], math.pi/2, wrap[1])
	local base = {code,
		value=0, amplitude=.5, tune={1.99,1.99}, rolloff=.5,
		alphaMask=0, mul={1,1}, add={-.5,-.5}, mv={0,0},
	}
	return f0b.table.union(wrap, base)
end

local function sdf(sdf, interpolation)
	local fn = {
		sin="sin(clamp(d*pi, -pi/2, pi/2)) * 0.5 + 0.5",
		linear="clamp(d + 0.5, 0, 1)",
		step="step(0, d)",
	}
	return {string.format([[
		varying vec2 actualRes;
#ifdef VERTEX
		uniform vec2 resolution;
		vec4 position(mat4 xform, vec4 pos) {
			if (min(resolution.x, resolution.y) < 0.0) {
				vec4 scr = vec4(love_ScreenSize.xy, 0.0, 1.0);
				actualRes = (TransformMatrix * scr).xy;
			} else {
				actualRes = resolution;
			}
			return xform*pos;
		}
#endif
#ifdef PIXEL
		uniform float margin;
		uniform float borderRadius;
		uniform float borderWidth;
		uniform vec4 borderColor;
		uniform vec4 backgroundColor;

		%s
		float alias(float d) {
			const float pi = %.10f;
			return %s;
		}
		vec4 getColor(float dist) {
			// When bw == 0, some color is still rendered
			float bw = borderWidth == 0.0 ? -1.0 : borderWidth;
			vec4 bg = mix(borderColor, backgroundColor,
				alias(-dist - bw));
			bg.a *= alias(-dist);
			return bg;
		}
		vec4 effect(vec4 color, Image _tex, vec2 texCoord, vec2 _) {
			// Convert coords from [0,1] to [-res/2,res/2]
			vec2 halfRes = actualRes * vec2(0.5);
			vec2 normalCoord = texCoord * actualRes - halfRes;

			float dist = sdf(normalCoord, halfRes);
			return color * getColor(dist + margin);
		}
#endif
	]], sdf, math.pi, fn[interpolation or "linear"]),
		resolution={-1,-1},
		borderWidth=0, borderColor={0,0,0,0}, borderRadius=0,
		backgroundColor={1,1,1,1},
		margin=0,
	}
end

local function grayWeight(weights)
	return {
		[[
			uniform vec3 weights;
			vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _) {
				vec4 pxl = Texel(tex, texCoord);
				pxl.rgb = vec3(dot(pxl.rgb, weights));
				return color * pxl;
			}
		]], weights=weights
	}
end

local function dither_o2x2(preColor)
	local output = preColor
		and [[
			vec4 pxl = txl * color + vec4(offset);
			return floor(pxl);
		]] or [[
			vec4 pxl = txl + vec4(offset);
			return color * floor(pxl);
		]]

	return string.format(
		[[vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _scr_coord) {
			const mat2 weight = mat2(
				1./16., 9./16.,
				13./16., 5./16.
			);
			vec2 texSize = vec2(1.0) / fwidth(texCoord);
			ivec2 pos = ivec2(mod(texCoord * texSize, 2.0));
			float offset = weight[pos.x][pos.y];
			vec4 txl = Texel(tex, texCoord);
			%s
		}]], output)
end

local vnAlpha = 7/8

return {
	fontAlias = {
		dejaVuSans = "DejaVuSans.ttf",
		dseg7 = "DSEG7Classic-Regular.ttf",
		ncentury18 = "ncenR18.pcf.gz",
		ncentury18i = "ncenI18.pcf.gz",
		takaoMincho = "TakaoMincho.ttf",
		vollkorn = "Vollkorn-Black.ttf",
		terminus = "ter-u28n_unicode.pcf.gz",
	},

	palette = {
		repellantYellow = {.35, .35, .3},
		tenpm = {.5, .5, .75},
		redbg = {1, 0, 0},
		fivepm = {1, .7, .3},
		sixpm = {.55, .35, .5},
		sevenpm = {.3, .4, .5},
		flashlight = {1, .6, 1/4},
		tungsten = {1, 7/8, 6/8},
		softAfternoon = {1, .95, .8},
	},

	style = {
		menu = {
			fontFamily = "ncentury18",
			fontSize = 18,
			color = {1, 0, 0, 1},
			backgroundColor = {0, 0, 0, 2/3},
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

		toc = {
			"menu",
			fontFamily = "ncentury18i",
			color = {0, 0, 0, 1},
			backgroundColor = {1, 0, 0, 1},
			borderWidth = 0,
			disabled = {
				unselected = {
					color = {.5, 0, .5, 1},
					backgroundColor = {0, 0, 0, 1},
				}
			},
			unselected = {
				fontFamily = "ncentury18",
				color = {1, 0, 0, 1},
				backgroundColor = {0, 0, 0, 2/3},
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
			borderRadius = 6,
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
			borderWidth = 1,
			margin = 1,
			padding = 1,
			lines = 4,
		},

		vnMaria = {
			"vn",
			backgroundColor = {1/3, 0, 1/3, vnAlpha},
		},

		vnBake = {
			"vn",
			backgroundColor = {0, .2, 0, vnAlpha},
		},

		vnFalcon = {
			"vn",
			backgroundColor = {.5, .25, 0, vnAlpha},
		},

		vnFab = {
			"vn",
			backgroundColor = {.5, 0, 0, vnAlpha},
		},

		vnCroft = {
			"vn",
			backgroundColor = {0, 0, .25, vnAlpha},
		},

		vnMartin = {
			"vn",
			backgroundColor = {.5, 0, 0, vnAlpha},
		},
	},

	shader = {
		rect = sdf([[
			float sdf(vec2 pos, vec2 size) {
				vec2 d = abs(pos) - size + vec2(borderRadius);
				return clamp(d.x, d.y, 0.0)
					+ length(max(d, vec2(0.0))) - borderRadius;
			}
		]]),
		circle = sdf([[
			float sdf(vec2 pos, vec2 size) {
				return length(pos) - min(size.x, size.y);
			}
		]]),
		triangle = sdf([[
			float det(vec2 x, vec2 y) {
				return x.x*y.y - x.y*y.x;
			}
			float segmentDist(vec2 x, vec2 y) {
				float project = dot(x,y)/dot(y,y);
				vec2 reject = x - y*clamp(project, 0.0, 1.0);
				return dot(reject, reject);
			}
			float vmin(vec3 x) {
				return min(min(x.x, x.y), x.z);
			}
			float sdf(vec2 pos, vec2 size) {
				size -= vec2(borderRadius);
				// Keep vertices clockwise...
				vec2 t[3] = vec2[](
					vec2(-1,1)*size,
					vec2(1,0)*size,
					vec2(-1,-1)*size
				);
				vec2 segment[3] = vec2[](
					t[1] - t[0], t[2] - t[1], t[0] - t[2]
				);
				vec3 dist;
				vec3 c;
				for (int i = 0; i < 3; ++i) {
					vec2 v = pos - t[i];
					dist[i] = segmentDist(v, segment[i]);
					c[i] = det(v, segment[i]);
				}
				// ... so that this isn't needed
				float s = 1; //det(segment[1], segment[0]);
				return sqrt(vmin(dist)) * -sign(vmin(c*vec3(s)))
					- borderRadius;
			}
		]]),

		edgy = [[
			vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _) {
				float off = abs(dFdx(texCoord.x));
				vec4 cur = Texel(tex, texCoord);
				vec4 right = Texel(tex, vec2(texCoord.x + off, texCoord.y));
				float d = distance(cur.rgb, right.rgb);
				return color * vec4(d, d, d, cur.a);
			}
		]],

		contrast = [[
			vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _) {
				vec4 pxl = Texel(tex, texCoord);
				pxl.rgb *= pxl.rgb;
				return pxl * color;
			}
		]],

		dither_o2x2 = dither_o2x2(false),
		dither_o2x2_pre = dither_o2x2(true),

		-- Mas o menos como YCbCr.
		gray = grayWeight{.3, .6, .1},

		-- Una pésima aproximación del efecto Purkinje
		-- https://es.wikipedia.org/wiki/Efecto_Purkinje
		purkinje = grayWeight{.1, .3, .6},

		radial = {[[
			uniform vec2 infoCursor;
			uniform vec2 infoMul;
			uniform float infoPow;
			uniform vec4 fg;
			uniform vec4 bg;

			vec2 norm(vec2 coord) {
				return coord - vec2(.5);
			}
			vec4 effect(vec4 color, Image tex, vec2 texCoord, vec2 _) {
				float dist = clamp(
					distance(infoCursor, norm(texCoord)*infoMul),
					0, 1
				);
				vec4 r = mix(fg, bg, pow(dist, infoPow));
				vec4 pxl = Texel(tex, texCoord);
				vec4 over = r + pxl*vec4(1.0 - r.a);
				return over * color;
			}
		]], fg={0,0,0,0}, bg={0,0,0,1},
			infoCursor={.5,.5}, infoPow=2, infoMul={1,1},
		},

		fbm = fbm{[[
			float generate(vec2 p) {
				return fbm(p);
			}
		]]},

		fbmWarp = fbm{[[
			float generate(vec2 p) {
				return fbmThirdDegree(p);
			}
		]]},

		fbmRipple = fbm{[[
			uniform vec2 time;
			uniform float waves;
			float generate(vec2 p) {
				p = p;
				float ripple = max(time.x-length(-p*waves), 0);
				ripple = mod(ripple, 3.1415926);
				p *= 1 + .0625*sin(ripple);
				p += .25*fbm(vec2(sin(ripple)));

				return fbmThirdDegree(p);
			}
		]], time={0,0}, waves=16},
	},
}
