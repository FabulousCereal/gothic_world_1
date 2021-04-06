local tocCmp = {
	eq = function(c, s)
		return c[1] == s[1] and c[2] == s[2]
	end,

	lt = function(c, s)
		return c[1] < s[1] or (c[1] == s[1] and c[2] < s[2])
	end,

	gt = function(c, s)
		return c[1] > s[1] or (c[1] == s[1] and c[2] > s[2])
	end,
}

local function tocRecalc(fText, toc, style, cur, sub)
	fText:clear()
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing - em

	local screenH = love.graphics.getHeight()
	local sectionX = math.floor(em * 2)
	local selected = true
	local future = false
	local entryReached
	local entryHeight
	local localStyle = style

	local sectionStart = cur[2]
	local loopPos = {0, 0}
	local lineY = 0
	for i = cur[1], #toc do
		loopPos[1] = i
		if not future and i > sub[1] then
			localStyle = style.disabled
			future = true
		end

		local chapter = toc[i]
		fText:add({localStyle.color, chapter.name}, 0, math.floor(lineY))
		lineY = lineY + fText:getHeight() + lineSpacing

		for j = sectionStart, #chapter do
			loopPos[2] = j
			if tocCmp.eq(loopPos, sub) then
				fText:add({localStyle.color, "*"}, em, lineY)
			elseif not future and tocCmp.gt(loopPos, sub) then
				localStyle = style.disabled
				future = true
			end

			local section = chapter[j]
			local title = {nil, nil}
			if selected then
				title[1] = localStyle.backgroundColor
			else
				title[1] = localStyle.color
			end
			if chapter.noNumbers then
				title[2] = section[1]
			else
				title[2] = string.format("%u.%u %s",
					i + toc.offset, j, section[1])
			end

			fText:add(title, sectionX, math.floor(lineY))
			local textHeight = fText:getHeight()
			if selected then
				entryReached = not future
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
	return entryReached, entryHeight
end

local function updateParallax(self)
	local toc, cur, layers = self.toc, self.cur, self.background

	local offset = 0
	for i = 1, cur[1] - 1 do
		offset = offset + #toc[i] + 1
	end
	offset = offset + cur[2]
		
	f0b.layers.ops(layers, "modall", {tween={"mvabs", 0, -offset, 2/3}})
end

local function runStage(self, allow)
	local cur = self.cur
	local sub = self.indexee.cur

	if #self.toc[cur[1]] < 1 then
		return ":)"
	end

	if allow == "current" and not tocCmp.eq(cur, sub) then
		if tocCmp.lt(cur, sub) then
			return "No puedes cambiar el pasado."
		else
			return "No puedes ver el futuro."
		end
	elseif allow == "past" and tocCmp.gt(cur, sub) then
		return "No puedes ver el futuro."
	end
	return false
end

local function mvTocPos(toc, cur, mag)
	cur[2] = cur[2] + mag
	if cur[2] < 1 or cur[2] > #toc[cur[1]] then
		cur[1] = cur[1] + math.max(-1, math.min(1, mag))
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

local function tocKeypressed(self, key)
	local cur = self.cur
	local sub = self.indexee.cur

	if self.forbiddenChoice then
		self.forbiddenChoice = false
		return
	elseif key == "return" or key == "space" then
		self.forbiddenChoice = runStage(self, "any")
		if not self.forbiddenChoice then
			gamestate:stateSwitch(self.indexee.id, cur)
		end
		return
	elseif key == "up" then
		mvTocPos(self.toc, self.cur, -1)
	elseif key == "down" then
		mvTocPos(self.toc, self.cur, 1)
	elseif key == "pageup" then
		cur[1], cur[2] = math.max(1, cur[1] - 1), 1
	elseif key == "pagedown" then
		cur[1], cur[2] = math.min(cur[1] + 1, #self.toc), 1
	elseif key == "home" then
		cur[1], cur[2] = 1, 1
	elseif key == "end" then
		cur[1], cur[2] = #self.toc, 1
	end

	self.entryReached, self.entryHeight = tocRecalc(self.tocRender,
		self.toc, self.style, cur, sub)
	if self.background then
		updateParallax(self)
	end
end

local function tocDraw(self)
	local style = self.style

	local em = style.font:getHeight()

	local floor = math.floor
	local graphics = love.graphics
	local screenW, screenH = graphics.getDimensions()
	local lineSpacing = em * style.lineSpacing
	local tocMargin = em * 2

	if self.forbiddenChoice then
--		graphics.clear(style.color)
--		graphics.setColor(0, 0, 0, 1)
--		graphics.draw(self.tocRender, floor(tocMargin),
--			floor(lineSpacing))

		local width = style.font:getWidth(self.forbiddenChoice)
		local x = screenW / 2 - width / 2
		local y = screenH / 2 - em / 2
		f0b.shapes.text(self.forbiddenChoice,
			floor(x), floor(y), width, "left", style)
	else
		if self.entryHeight then
			if self.entryReached == true then
				graphics.setColor(style.color)
			else
				graphics.setColor(style.disabled.color)
			end

			local padding = em * style.padding
			graphics.rectangle("fill",
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
	self.forbiddenChoice = false
	self.entryReached, self.entryHeight = tocRecalc(self.tocRender,
		self.toc, self.style, self.cur, self.indexee.cur)
end

local function tocPreInit(self)
	for i = 1, #self.toc do
		self.tocLen = self.tocLen + #self.toc[i] + 1
	end
	self.tocRender = love.graphics.newText(self.style.font)
	self.pre = tocPreStarted

	return tocPreStarted(self)
end

return {
	new = function(toc, style, indexeeID)
		return {
			draw = tocDraw,
			keypressed = tocKeypressed,
			pre = tocPreInit,

			toc = toc,
			tocLen = 0,
			indexee = gamestate[indexeeID],
			style = style,

			cur = {1, 1},
			tocRender = nil,
			entryReached = nil,
			forbiddenChoice = false,
			entryHeight = nil,
		}
	end,
}
