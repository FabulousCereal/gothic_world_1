-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function getUnits(style)
	local em = style.font:getHeight()
	return em, em * style.padding, em * style.margin, em * style.lineHeight,
		style.borderWidth
end	

local function setupShader(ctx, style, invert)
	local names = {
		"borderWidth", "borderRadius", "borderColor",
		"backgroundColor",
		["color"] = "backgroundColor",
		["borderColor"] = "backgroundColor",
		["backgroundColor"] = "color"
	}
	local ctx = ctx{}
	for alt, key in pairs(names) do
		local type = type(alt)
		if invert and type == "string" then
			ctx[alt] = style[key]
		elseif type == "number" then
			ctx[key] = style[key]
		end
	end
	return ctx
end

return {
	getUnits = getUnits,

	setupShader = setupShader,

	getShader = function(style, invert)
		return setupShader(res.shader[style.shader or "rect"], style,
			invert)
	end,
}
