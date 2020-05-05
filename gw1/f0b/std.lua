function basicDeepCopy(orig)
	local copy = {}
	for key, val in pairs(orig) do
		if type(val) == "table" then
			copy[key] = basicDeepCopy(val)
		else
			copy[key] = val
		end
	end
	return copy
end

return {
	basicDeepCopy = basicDeepCopy,

	next = function(iter)
		local func, value, idx = unpack(iter)
		local result = {func(value, idx)}
		iter[3] = result[1]
		return unpack(result, 2)
	end,
}
			
