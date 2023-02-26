return {
	dofile = function(filename)
		return love.filesystem.load(filename)()
	end,

	dofileOr = function(filename, arg)
		local func = love.filesystem.load(filename)
		if func then
			return func()
		end
		return arg
	end,
}
			
