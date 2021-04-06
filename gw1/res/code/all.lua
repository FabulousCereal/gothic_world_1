local fload = love.filesystem.load
return {
	clock = fload("res/code/clocks.lua")(),
	sub = fload("res/code/sub.lua")(),
	titleCard = fload("res/code/titleCard.lua")(),
}
