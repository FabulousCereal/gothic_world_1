local function menuKeypressed(self, key)
	if key == "return" then
		local entry = self.entries[self.cur]
		if entry.exec then
			entry.exec(unpack(entry.args))
		elseif entry.to then
			self.stateSwitch(entry.to)
		end
	else
		if key == "up" then
			self.cur = ((self.cur - 2) % #self.entries) + 1
		elseif key == "down" then
			self.cur = ((self.cur) % #self.entries) + 1
		elseif key == "home" then
			self.cur = 1
		elseif key == "end" then
			self.cur = #self.entries
		end
	end
end

local function menuDraw(self)
	local graphics = love.graphics
	local style = self.style
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local rectX = math.ceil(self.x - em * style.padding)
	local rectY = math.floor(self.y + ((self.cur - 1) * lineSpacing))
	f0b.shapes.bordered(graphics.rectangle, style,
		rectX, rectY, self.rectW, self.rectH, style.borderRadius)

	graphics.setColor(1, 1, 1, 1)
	graphics.draw(self.text, self.x, self.y)
end

local function calcText(entries, style)
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local lineY = 0
	local maxW = 0
	local text = love.graphics.newText(style.font)
	for i = 1, #entries do
		local entry = entries[i]
		local colorText
		if entry.disabled then
			colorText = {style.disabled.color, entry.name}
		else
			colorText = {style.color, entry.name}
		end
		text:add(colorText, 0, math.floor(lineY))
		lineY = lineY + lineSpacing
		local w = text:getWidth()
		if w > maxW then
			maxW = w
		end
	end
	return text, maxW
end

local function menuPre(self)
	local style = self.style
	local text, rectW = calcText(self.entries, style)
	local em = style.font:getHeight()

	self.text = text
	self.rectW = math.floor(rectW + em * style.padding * 2)
	self.rectH = em

	self.pre = nil
end

return {
	new = function(entries, style, x, y)
		return {
			draw = menuDraw,
			keypressed = menuKeypressed,
			pre = menuPre,

			cur = 1,
			entries = entries,
			style = style,
			x = x,
			y = y,

			text = nil,
			rectW = nil,
			rectH = nil,
		}
	end,
}
