-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local widgets = {
	select = require('f0b.ui.select'),
	textboard = require('f0b.ui.textboard')
}

local function forEach(fn)
	return function(ui, ...)
		for _, name in ipairs(ui) do
			fn(name, ui[name], ...)
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

	add = function(ui, name, ...)
		if not ui[name] then
			table.insert(ui, name)
			ui[name] = widgets[name].new(...)
		end
	end,
}
