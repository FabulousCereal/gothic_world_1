-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense
local function shaderCursor(ctx)
	local pos = {love.mouse.getPosition()}
	local size = {love.graphics.getDimensions()}
	local mul = ctx.infoMul
	for i = 1, #pos do
		pos[i] = (pos[i] / size[i] - 0.5)*mul[i]
	end
	return pos
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
				infoCursor=cursor and shaderCursor or {-1/6,-1/6},
				infoMul={2/3,4/3}, infoPow=2.2,
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
				infoCursor=cursor and shaderCursor or {0,0},
				infoMul={2/3,4/3}, infoPow=2.2,
				fg={0,0,0,0}, bg={0,0,0,.97},
			},
			draw=f0b.draw.screenFill,
		}
	end,

	linterna = function(tex, pos)
		return res.shader[tex and "radialTex" or "radial"]{
			infoCursor = pos or shaderCursor,
			infoMul={2,2}, infoPow=4, bg={0,0,0,.9},
		}
	end,

	cielo = function(col1, col2, cur)
		--local args={f0b.draw.unitSquare, 40, 40, 0, 560, 560}
		local draw = f0b.draw.screenFill
		local bg1 = {
			draw=draw,
			shader=res.shader.radial{
				infoCursor = cur, infoPow=1, infoMul={2,2},
				fg={1,1,1,1}, bg=col1,
			},
		}
		local bg2 = {
			draw=draw, color=col2,
			shader=res.shader.fbmWarp{
				mul={3,3}, rolloff=.5, amplitude=0.5,
				add=shaderTime(1/64, 0),
				alphaMask=1,
			},
		}
		return bg1, bg2
	end
}
