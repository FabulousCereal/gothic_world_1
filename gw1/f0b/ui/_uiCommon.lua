return {
	multiRepl = function(str, repl)
		local gsub = string.gsub
		str = gsub(str, "\n+%s*", " ")
		for k, v in pairs(repl) do
			str = gsub(str, k, v)
		end
		return str
	end,
}
