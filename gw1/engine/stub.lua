-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function stubInput(self)
	return gamestate:stateSwitch(true)
end

return {
	new = function()
		return {
			keypressed = stubInput,
			mousepressed = stubInput,
		}
	end,
}
