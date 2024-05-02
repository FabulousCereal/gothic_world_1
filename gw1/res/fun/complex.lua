-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense
local function shaderCursor(ctx)
	local x, y = love.mouse.getPosition()
	local w, h = love.graphics.getDimensions()
	local m = ctx.mul
	return {x/w * m[1], y/h * m[2]}
end

local function shaderTime(xm, ym, xa, ya)
	xm = xm or 1
	ym = ym or xm
	xa = xa or 0
	ya = ya or xa
	return function()
		local t = love.timer.getTime()
		return {t*xm + xa, t*ym + ya}
	end
end

return {
	shaderTime = shaderTime,

	comedor = function(cursor, ...)
		return {args={"Flash/day.png"},
			shader=res.shader.radialTex({
				center={2/6,2/6},
				mul={2/3,4/3}, decay=1,
				fg={0,0,0,.25}, bg={0,0,0,.97},
			}, ...)
		}
	end,

	comedor2 = function()
		return {
			--[[El color original es #ffcc00, que es así de simple
			de expresar con fracciones. Me pregunto como es que
			elegí justo esos números el 2009.]]
			color={1, 4/5, 0, 1},
			draw=f0b.draw.screenFill,
		}
	end,

	vignette = function(cursor)
		return {"bg", "add",
			shader=res.shader.radialTex{
				center={0,0},
				mul={2/3,4/3}, decay=2.2,
				fg={0,0,0,0}, bg={0,0,0,.97},
			},
			draw=f0b.draw.screenFill,
		}
	end,

	linterna = function(tex, pos)
		return res.shader[tex and "radialTex" or "radial"]{
			center=pos,
			sub=pos and nil or shaderCursor,
			mul={2,2}, decay=2, bg={0,0,0,.9},
		}
	end,

	cielo = function(col1, col2, cur)
		local draw = f0b.draw.screenFill
		local mul = {2,2}
		local bg1 = {
			draw=draw,
			shader=res.shader.radial{
				center=cur, decay=.5, mul={2,2},
				fg={1,1,1,1}, bg=col1,
			},
		}
		local bg2 = {
			draw=draw, color=col2,
			shader=res.shader.fbmWarp{
				mul={2,2}, rolloff=.5, amplitude=.5,
				add=shaderTime(1/32, 0),
				mv=shaderTime(1/32, 0),
				alphaMask=1,
			},
		}
		return bg1, bg2
	end,

	-- Aproximación barata. Usa mas o menos los coeficientes de YCbCr, pero
	-- priorizando el azul.
	purkinje = function()
		return res.shader.gray{weights={.1, .3, .6}}
	end,
}
