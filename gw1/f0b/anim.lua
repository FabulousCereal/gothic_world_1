-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

-- {image, secondsPerFrame, tilesX, tilesY, timeOffset}
return {
	draw = function(anim, ...)
		local quads = anim.quads
		if quads then
			local i = math.floor((anim[5] / anim[2]) % #quads)
			love.graphics.draw(anim[1], quads[i + 1], ...)
		end
	end,

	update = function(anim, dt)
		local quads = anim.quads
		if quads then
			anim[5] = dt + (anim[5] or 0)
		else
			anim[1] = res.img(anim[1])
			local w, h = anim[1]:getDimensions()
			local tw = w / anim[3]
			local th = h / anim[4]
			local newQuad = love.graphics.newQuad
			quads = {}
			for y = 0, anim[4] - 1 do
				for x = 0, anim[3] - 1 do
					quads[#quads + 1] = newQuad(x*tw, y*th,
						tw, th, w, h)
				end
			end
			anim.quads = quads
		end
	end,
}
