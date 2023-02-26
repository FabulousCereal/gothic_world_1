local textboard = f0b.ui.widgets.textboard

local function setText(self, str, append, cont)
	self.textCont = cont
	return textboard.setText(self.ui.textboard, str, append)
end

return {
	instructionTable = {
		wait = function(inst, self)
			self.wait, self.unskippable, self.ui.textboard.display =
				unpack(inst, 2)
			return true
		end,

		text = function(inst, self)
			setText(self, unpack(inst, 2))
			return true
		end,

		name = function(inst, self)
			textboard.setName(self.ui.textboard, inst[2])
		end,

		speed = function(inst, self)
			self.ui.textboard.speed = inst[2]
		end,
	},

	typeTable = {
		string = function(inst, self)
			setText(self, inst, false, false)
			return true
		end,

		boolean = function(inst, self)
			if inst == false then
				self.wait = math.huge
				return true
			end
		end,

		number = function(inst, self)
			self.wait = inst
			return true
		end,

		["function"] = function(inst, self)
			f0b.lisp.push(self.dataStack,
				inst(self.vars, self.gVars))
		end,

		["nil"] = function() end,
	},
}
