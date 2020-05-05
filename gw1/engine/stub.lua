local function stubKeypressed(self)
	return self.stateSwitch(true)
end

return {
	new = function()
		return {
			keypressed = stubKeypressed,
		}
	end,
}
