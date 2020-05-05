local function genScreenCover()
	local w, h = love.graphics.getDimensions()
	return setmetatable({f0b.elem.poly[4], w/2, h/2, math.pi/4, w, h},
		{
			__call = function(self, scale)
				return {self[1], self[2], self[3], self[4],
					self[5] * scale, self[6] * scale}
			end,
		})
end

return {
	screenCover = genScreenCover()
}
