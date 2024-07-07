-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function tocDiff(c, s)
	local prim = c[1] - s[1]
	return prim ~= 0 and prim or c[2] - s[2]
end

local function pushText(text, style, str, x, y)
	return text:getHeight(text:add({style.color, str}, x, math.floor(y)))
end

local function tocRecalc(fText, toc, style, cur, sub)
	fText:clear()
	local em = style.font:getHeight()
	local lineSpacing = em * style.margin

	local screenH = love.graphics.getHeight()
	local selected = true
	local entryStyle = style.disabled
	local entryHeight

	local sectionStart = cur[2]
	local loopPos = {0, 0}
	local lineY = 0
	for i = cur[1], #toc do
		loopPos[1] = i
		local localStyle = (i > sub[1] and style.disabled or style).unselected

		local chapter = toc[i]
		lineY = lineY + lineSpacing
			+ pushText(fText, localStyle, chapter.name, 0, lineY)

		for j = sectionStart, #chapter do
			loopPos[2] = j
			local diff = tocDiff(loopPos, sub)
			if diff > 0 then
				localStyle = style.disabled
			else
				localStyle = style
			end
			if diff == 0 then
				entryStyle = localStyle
				pushText(fText, localStyle.unselected, "*", em, lineY)
			end
			if not selected then
				localStyle = localStyle.unselected
			end

			local title
			local section = chapter[j]
			if chapter.noNumbers then
				title = section[1]
			else
				title = string.format("%u.%u %s",
					i + toc.offset, j, section[1])
			end

			local textHeight = pushText(fText, localStyle, title,
				em*2, lineY)
			if selected then
				entryHeight = textHeight
				selected = false
			end

			lineY = lineY + textHeight + lineSpacing
			if lineY > screenH then
				break
			end
		end
		if lineY > screenH then
			break
		end

		sectionStart = 1
		selected = false
	end
	return entryStyle, entryHeight
end

local function updateParallax(self)
	local toc, cur = self.toc, self.cur

	local offset = 0
	for i = 1, cur[1] - 1 do
		offset = offset + #toc[i] + 1
	end
	offset = offset + cur[2]

	local em, _, margin = f0b.style.getUnits(self.style)
	local pos = -offset * (margin*2 + em)
	f0b.layers.ops(self.background, {fade={"mvabs", false, pos, 2/3}},
		"modall")
end

local function runStage(self)
	local cur = self.cur
	local sub = self.indexee.cur

	if #self.toc[cur[1]] < 1 then
		return ":)"
	elseif not self.toc[cur[1]][cur[2]][2] then
		return "Esta parte aún no existe..."
	end

	local allow = self.allow
	local diff = tocDiff(cur, sub)
	if allow == "current" and diff ~= 0 then
		return diff < 0
			and "No puedes cambiar el pasado."
			or "No puedes ver el futuro."
	elseif allow == "past" and diff > 0 then
		return "No puedes ver el futuro."
	end
	return false
end

local function mvTocPos(toc, cur, mag)
	cur[2] = cur[2] + mag
	if cur[2] < 1 or cur[2] > #toc[cur[1]] then
		cur[1] = cur[1] + f0b.math.clamp(mag, -1, 1)
		if cur[1] < 1 then
			cur[1], cur[2] = 1, 1
		elseif cur[1] > #toc then
			cur[1], cur[2] = #toc, #toc[#toc]
		elseif mag > 0 then
			cur[2] = 1
		else
			cur[2] = math.max(1, #toc[cur[1]])
		end
	end
end

local keyMap = f0b.table.dispatch({
	["return"] = function(self)
		self.forbidden = runStage(self, "any")
		if self.forbidden then
			local msg = self.forbiddenMsg
			local button = f0b.button
			local screenW, screenH = love.graphics.getDimensions()
			local w = button.setTextAdapt(msg, self.forbidden, screenW)
			button.regen(msg)
			button.setPos(msg,
				f0b.math.centerRect(screenW, screenH,
					w, button.getHeight(msg)
				)
			)
		else
			gamestate:stateSwitch(self.indexee.id, self.cur)
		end
		return self.forbidden
	end,

	up = function(self)
		mvTocPos(self.toc, self.cur, -1)
	end,

	down = function(self)
		mvTocPos(self.toc, self.cur, 1)
	end,

	pageup = function(self)
		self.cur[1], self.cur[2] = math.max(self.cur[1] - 1, 1), 1
	end,

	pagedown = function(self)
		self.cur[1], self.cur[2] = math.min(self.cur[1] + 1, #self.toc), 1
	end,

	home = function(self)
		self.cur[1], self.cur[2] = 1, 1
	end,

	["end"] = function(self)
		self.cur[1], self.cur[2] = #self.toc, 1
	end
})

local function tocKeypressed(self, key)
	if self.forbidden then
		self.forbidden = false
		return
	elseif keyMap[key](self) then
		return
	end

	self.entryStyle, self.entryHeight = tocRecalc(self.tocRender,
		self.toc, self.style, self.cur, self.indexee.cur)
	if self.background then
		updateParallax(self)
	end
end

local function tocWheelmoved(self, _x, y)
	y = f0b.math.clamp(math.floor(y), -1, 1)
	if y ~= 0 then
		return tocKeypressed(self, y > 0 and "up" or "down")
	end
end

local function tocDraw(self)
	local style = self.style

	local em = style.font:getHeight()

	local floor = math.floor
	local graphics = love.graphics
	local screenW = graphics.getWidth()
	local lineSpacing = em * style.margin + em
	local tocMargin = em * 2

	if self.forbidden then
		f0b.button.draw(self.forbiddenMsg)
	else
		if self.entryHeight then
			style = self.entryStyle

			local padding = em * style.padding
			f0b.draw.rect(style,
				floor(em * 4 - padding),
				floor(lineSpacing * 2 - padding / 2),
				floor(screenW - em * 6 + padding * 2),
				floor(self.entryHeight + padding))
		end
		graphics.setColor(1, 1, 1, 1)
		graphics.draw(self.tocRender, floor(tocMargin),
			floor(lineSpacing))
	end
end

local function tocPreStarted(self)
	self.forbidden = false
	self.entryStyle, self.entryHeight = tocRecalc(self.tocRender,
		self.toc, self.style, self.cur, self.indexee.cur)
end

local function tocPreInit(self)
	self.tocRender = love.graphics.newText(self.style.font)
	self.pre = tocPreStarted
	return tocPreStarted(self)
end

return {
	new = function(toc, style, indexeeID, allow)
		return {
			draw = tocDraw,
			keypressed = tocKeypressed,
			wheelmoved = tocWheelmoved,
			pre = tocPreInit,

			toc = toc,
			indexee = gamestate[indexeeID],
			style = style,

			cur = {1, 1},
			tocRender = nil,
			entryStyle = nil,
			entryHeight = nil,
			forbidden = false,
			forbiddenMsg = f0b.button.stub(style.unselected),
			prevOff = 0,
			allow = allow,
		}
	end,
}
