return {
	coords = function(x, y, scale)
		if scale then
			x, y = x * scale, y * scale
		end

		local w, h = love.graphics.getDimensions()
		if x < 0 then
			x = x + w
		end
		if y < 0 then
			y = y + h
		end
		return x, y
	end,
}
