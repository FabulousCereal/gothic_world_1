local widgets = setmetatable({}, {
	__index = function(table, key)
		table[key] = require("f0b.ui." .. key)
		return table[key]
	end,
})

local function forEach(fn)
	return function(ui, ...)
		for i = 1, #ui do
			local name = ui[i]
			local target = ui[name]
			fn(name, target, ...)
		end
	end
end

return {
	widgets = widgets,

	regen = forEach(function(name, target, style)
		return widgets[name].regen(target, style)
	end),

	draw = forEach(function(name, target)
		if target.display then
			return widgets[name].draw(target)
		end
	end),

--[[	draw = function(ui)
		for i = 1, #ui do
			local name = ui[i]
			local target = ui[name]
			if target.display then
				widgets[name].draw(target)
			end
		end
	end,]]

	add = function(ui, name, ...)
		if not ui[name] then
			ui[#ui + 1] = name
			ui[name] = widgets[name].new(...)
		end
	end,
}
