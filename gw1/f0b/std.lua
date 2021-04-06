return {
	dofileOr = function(filename, arg)
		local func = love.filesystem.load(filename)
		if func then
			return func()
		end
		return arg
	end,

	copy = function(val)
		if type(val) == "table" then
			return f0b.table.deepCopy(val)
		end
		return val
	end,
}
			
