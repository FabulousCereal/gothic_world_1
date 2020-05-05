local flatRequire = function()
	local files = {
		"sub",
		"clocks",
		"titleCard",
	}

	local all = {}
	for i = 1, #files do
		local funcs = require("res.code." .. files[i])
		for name, func in pairs(funcs) do
			all[name] = func
		end
	end

	return all
end

return flatRequire()
