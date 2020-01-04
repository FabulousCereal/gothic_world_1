local function menuKeypressed(self, key)
	if key == "up" then
		if self.cur == 1 then
			self.cur = #self.entries
		else
			self.cur = self.cur - 1
		end
	elseif key == "down" then
		if self.cur == #self.entries then
			self.cur = 1
		else
			self.cur = self.cur + 1
		end
	elseif key == "return" then
		local entry = self.entries[self.cur]
		if entry.exec then
			entry.exec(unpack(entry.args))
		elseif entry.to then
			self.stateSwitch = entry.to
		end
	end
end

local function menuDraw(self)
	local lineY = self.y
	love.graphics.setFont(self.style.font)
	for i, entry in ipairs(self.entries) do
		love.graphics.setColor(self.colors[entry.color])
		love.graphics.print(entry.name, self.x, lineY)
		lineY = lineY + self.rect[2] * self.lh
	end
	local rectX = math.ceil(self.x - self.ch * 0.5)
	local rectY = self.y + ((self.cur - 1) * self.rect[2] * self.lh)
	love.graphics.setLineWidth(self.style.borderWidth)
	love.graphics.setColor(self.colors[1])
	love.graphics.rectangle("line", rectX, rectY, unpack(self.rect))
end

return {
	newMenu = function(entries, style, colors, lineHeight, pos)
		local rectW = 0
		local rectH = style.font:getHeight()
		local ch = style.font:getWidth("0")

		for i = 1, #entries do
			local w = style.font:getWidth(entries[i].name)
			if w > rectW then
				rectW = w
			end
		end

		return {
			draw = menuDraw,
			keypressed = menuKeypressed,

			cur = 1,
			entries = entries,
			style = style,
			colors = colors,
			lh = lineHeight,
			rect = {rectW + ch, rectH},
			ch = ch,
			x = pos[1],
			y = pos[2],
		}
	end,
}
