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

local function newTocPos(toc, cur, mag)
	local section, chapter = unpack(cur)
	chapter = chapter + mag
	if chapter < 1 or chapter > #toc[section] then
		section = section + mag
		if section < 1 then
			cur[1], cur[2] = 1, 1
		elseif section > #toc then
			cur[1], cur[2] = #toc, 1--#toc[#toc]
		elseif mag > 0 then
			cur[1], cur[2] = section, 1
		else
			cur[1], cur[2] = section, math.max(1, #toc[section])
		end
	else
		cur[1], cur[2] = section, chapter
	end
end

local function tocRecalc(fText, toc, style, cur, sub)
	local em = style.font:getHeight()
	local lineSpacing = em * style.lineSpacing

	local screenH = love.graphics.getHeight()
	local lineY = 0
	local sectionX = math.floor(em * 2)
	local selected = true
	local disabled = false
	local selectState = nil
	local localStyle = style

	local sectionStart = cur[2]
	local iterCur = {0, 0}
	fText:clear()
	for i = cur[1], #toc do
		iterCur[1] = i
		if not disabled and i > sub[1] then
			localStyle = style.disabled
			disabled = true
		end

		local chapter = toc[i]
		fText:add({localStyle.color, chapter.name}, 0, math.floor(lineY))
		lineY = lineY + lineSpacing

		for j = sectionStart, #chapter do
			iterCur[2] = j
			if tocCmp.eq(iterCur, sub) then
				fText:add({localStyle.color, "*"}, em, lineY)
			elseif not disabled and tocCmp.gt(iterCur, sub) then
				localStyle = style.disabled
				disabled = true
			end

			local section = chapter[j]
			local title = {nil, nil}
			if selected then
				title[1] = localStyle.backgroundColor
				selectState = not disabled
				selected = false
			else
				title[1] = localStyle.color
			end
			if chapter.noNumbers then
				title[2] = section[1]
			else
				title[2] = string.format("%u.%u %s",
					i - 1, j, section[1])
			end

			fText:add(title, sectionX, math.floor(lineY))

			lineY = lineY + lineSpacing
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

	return selectState
end

local function tocKeypressed(self, key)
	local cur = self.cur
	local sub = self.indexee.cur

	if self.displayError then
		self.displayError = false
		return
	elseif key == "return" or key == "space" or key == "right" then
		if #self.toc[cur[1]] == 0 then
			self.displayError = ":)"
		else
			self.stateSwitch(self.indexee.id, cur)
			return
		end
--		if tocCmp.eq(cur, sub) then
--			self.stateSwitch(self.indexee.id)
--		else
--			if #self.toc[cur[1]] == 0 then
--				self.displayError = ":)"
--			elseif tocCmp.lt(cur, sub) then
--				self.displayError =
--					"No puedes cambiar el pasado."
--			else
--				self.displayError = "No puedes ver el futuro."
--			end
--		end
	elseif key == "up" then
		newTocPos(self.toc, self.cur, -1)
	elseif key == "down" then
		newTocPos(self.toc, self.cur, 1)
	elseif key == "pageup" then
		cur[1], cur[2] = math.max(1, cur[1] - 1), 1
	elseif key == "pagedown" then
		cur[1], cur[2] = math.min(cur[1] + 1, #self.toc), 1
	elseif key == "home" then
		cur[1], cur[2] = 1, 1
	elseif key == "end" then
		cur[1], cur[2] = #self.toc, 1 --#self.toc[#self.toc]
	end

	self.displaySelect = tocRecalc(self.tocRender, self.toc, self.style,
		cur, sub)
end

local function tocDraw(self)
	local style = self.style

	local em = style.font:getHeight()

	local floor = math.floor
	local graphics = love.graphics
	local screenW, screenH = graphics.getDimensions()
	local lineSpacing = em * style.lineSpacing
	local tocMargin = em * 2

	if self.displayError then
--		graphics.clear(style.color)
--		graphics.setColor(0, 0, 0, 1)
--		graphics.draw(self.tocRender, floor(tocMargin),
--			floor(lineSpacing))

		local width = style.font:getWidth(self.displayError)
		local x = screenW / 2 - width / 2
		local y = screenH / 2 - em / 2
		f0b.shapes.text(self.displayError,
			floor(x), floor(y), width, "left", style)
	else
		if self.displaySelect ~= nil then
			if self.displaySelect == true then
				graphics.setColor(style.color)
			else
				graphics.setColor(style.disabled.color)
			end

			local padding = em * style.padding
			graphics.rectangle("fill",
				floor(em * 4 - padding),
				floor(lineSpacing * 2 - padding / 2),
				floor(screenW - em * 6 + padding * 2),
				floor(em + padding))
		end
		graphics.setColor(1, 1, 1, 1)
		graphics.draw(self.tocRender, floor(tocMargin),
			floor(lineSpacing))
	end
end

local function tocPreStarted(self, endOfData)
	self.displayError = nil
	self.displaySelect = tocRecalc(self.tocRender, self.toc, self.style,
		self.cur, self.indexee.cur)
end

local function tocPreInit(self)
	local sub = self.indexee.cur
	self.cur = {1, 1}
	self.tocRender = love.graphics.newText(self.style.font)
	self.displaySelect = tocRecalc(self.tocRender, self.toc, self.style,
		self.cur, sub)

	self.pre = tocPreStarted
end

return {
	new = function(toc, style, indexee)
		return {
			draw = tocDraw,
			keypressed = tocKeypressed,
			pre = tocPreInit,
--			post = tocExit,

			toc = toc,
			indexee = indexee,
			style = style,

			cur = nil,
			tocRender = nil,
			displaySelect = nil,
			displayError = nil,
		}
	end,
}
