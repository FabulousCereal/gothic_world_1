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
