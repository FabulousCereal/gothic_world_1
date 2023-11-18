-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function getUnits(style)
	local em = style.font:getHeight()
	return em, em * style.padding, em * style.margin, em * style.lineHeight
end	

return {
	getUnits = getUnits,

	textLimit = function(style, maxW)
		local _, pad, margin = getUnits(style)
		return maxW - (pad + margin + style.borderWidth)*2
	end,

	setupShader = function(style)
		local shader = res.shader[style.shader]

		local names = {"borderWidth", "borderRadius", "borderColor",
			"backgroundColor"}
		for _, n in ipairs(names) do
			local sname = "style_" .. n
			if shader:hasUniform(sname) then
				shader:send(sname, style[n])
			end
		end

		return shader
	end,
}
