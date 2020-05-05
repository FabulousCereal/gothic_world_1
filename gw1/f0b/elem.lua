local function starRegular(sides)
	local segs = sides * 2
	local angle = math.pi * 2 / segs
	local cos, sin = math.cos, math.sin
	local star = {{0, 0}}
	for i = 2, segs + 2 do
		local pos = angle * i
		local dist = (i % 2 + 1) / 2
		star[i] = {cos(pos) * dist, sin(pos) * dist}
	end
	return love.graphics.newMesh(star, "fan", "static")
end

local function polyRegular(sides)
	local graphics = love.graphics
	local segs = sides or math.max(graphics.getDimensions())
	local angle = math.pi * 2 / segs
	local cos, sin = math.cos, math.sin
	local unit = {}
	for i = 1, segs do
		local pos = angle * i
		unit[i] = {cos(pos), sin(pos)}
	end
	return graphics.newMesh(unit, "fan", "static")
end

local function elemMetatable(func)
	return setmetatable({}, {
		__index = function(self, key)
			local val = func(key)
			self[key] = val
			return val
		end,
	})
end

return {
	poly = elemMetatable(polyRegular),
	star = elemMetatable(starRegular),

	circle = polyRegular(),
}
