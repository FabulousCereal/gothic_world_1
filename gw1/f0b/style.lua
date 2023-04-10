local function getUnits(style)
	local em = style.font:getHeight()
	return em, em * style.padding, em * style.margin, em * style.lineHeight
end	

return {
	getUnits = getUnits,

	textLimit = function(style, maxW)
		local _, pad, margin = getUnits(style)
		return maxW - (pad + margin)*2 + style.borderWidth
	end,
}
