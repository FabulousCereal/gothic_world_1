return {
	new = function(table)
		local idx = 0
		return function()
			idx = idx + 1
			if idx <= #table then
				return table[idx]
			end
			return nil
		end
	end,
}
