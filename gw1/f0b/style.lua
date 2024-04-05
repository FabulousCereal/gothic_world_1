-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function getUnits(style)
	local em = style.font:getHeight()
	return em, em * style.padding, em * style.margin, em * style.lineHeight
end	

local function setupShader(shader, style, invert)
	local names = {"borderWidth", "borderRadius", "borderColor",
		"backgroundColor"}
	for _, n in ipairs(names) do
		local sname = "style_" .. n
		if shader:hasUniform(sname) then
			local key = (invert and n == "backgroundColor")
				and "color" or n
			shader:send(sname, style[key])
		end
	end
	return shader
end

return {
	getUnits = getUnits,

	textLimit = function(style, maxW)
		local _, pad, margin = getUnits(style)
		return maxW - (pad + margin + style.borderWidth)*2
	end,

	setupShader = setupShader,

	getShader = function(style, invert)
		return setupShader(style.shader or res.shader.rect, style, invert)
	end,
}
