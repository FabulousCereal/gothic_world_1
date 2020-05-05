return {
	rotate = function(x, y, r)
		local rC, rS = math.cos(r), math.sin(r)
		return x * rC - y * rS, x * rS + y * rC
	end,

--	rotate = function(coords, r)
--		local cosR, sinR = math.cos(r), math.sin(r)
--		for i = 1, #coords, 2 do
--			local x, y = coords[i], coords[i+1]
--			coords[i] = x * cosR - y * sinR
--			coords[i+1] = x * sinR + y * cosR
--		end
--		return coords
--	end,

	translate = function(x, y, offsetX, offsetY)
		return x + offsetX, y + offsetY
	end
}
