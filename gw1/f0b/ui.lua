-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local widget = {}
local widgetNames = {"select", "textboard"}
for _, name in ipairs(widgetNames) do
	widget[name] = require("f0b.ui." .. name)
end

local function forEachWidget(fn)
	return function(ui, ...)
		for name, val in pairs(ui) do
			fn(widget[name], val, ...)
		end
	end
end

return {
	widget = widget,

	regen = forEachWidget(function(w, target, style)
		return w.regen(target, style)
	end),

	draw = forEachWidget(function(w, target)
		if target.display then
			return w.draw(target)
		end
	end),

	add = function(ui, name, ...)
		ui[name] = widget[name].new(...)
	end,
}
