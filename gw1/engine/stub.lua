-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Apache-2.0

local function stubInput()
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
