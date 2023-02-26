-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function stubKeypressed(self)
	return gamestate:stateSwitch(true)
end

return {
	new = function()
		return {
			keypressed = stubKeypressed,
		}
	end,
}
