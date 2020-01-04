local function nameChange(self, style, name)
	if name and #name ~= 0 then
		local pad = style.padding * style.em + style.borderWidth
		self.name[1]:set(name)
		self.namebox[3] = self.name[1]:getWidth() + pad
	else
		self.namebox[3] = 0
	end
end

local function calcSelectSpacing(self, style, n)
	local y = self.textbox[4] + style.margin * 2
	local height = love.graphics.getHeight() - y * 2 - style.em
	local step = math.floor(height / style.em * style.lineHeight * 2)
	return y, step
end

local function setSelect(self, style, lines)
	local _, step = calcSelectSpacing(self, style, #lines)
	local text = self.select[1]
	text:clear()
	local wrap, align = unpack(self.select.format)
	for i = 1, #lines do
		local posY = step * (i - 1)
		text:addf(lines[i], wrap, align, 0, posY)
	end
	self.select.options = lines
	self.select.cur = 0
end

local function drawBoard(self, style)
	local graphics = love.graphics

	f0b.shapes.draw(self.textbox, style, graphics.rectangle)
	graphics.setColor(style.color)
	graphics.draw(unpack(self.text))

	if self.namebox[3] ~= 0 then
		f0b.shapes.draw(self.namebox, style, graphics.rectangle)
		graphics.setColor(style.color)
		graphics.draw(unpack(self.name))
	end

	if self.select.options then
		local n = #self.select.options
		local lh = style.em * style.lineHeight
		local y, step = calcSelectSpacing(self, style, n)
		for i = 1, n do
			local posY = y + step * (i - 1) - lh / 3
			self.selectbox[2] = posY - style.borderWidth
			if i == self.select.cur + 1 then
				f0b.shapes.draw(self.selectbox, style,
					graphics.rectangle)
			else
				graphics.setColor(style.backgroundColor)
				graphics.rectangle("fill",
					unpack(self.selectbox))
				graphics.setColor(style.color)
			end
		end
		self.select[3] = y
		graphics.draw(unpack(self.select))
	end
end

local textboard = {}

textboard.recalc = function(board, style, lines)
	local lh = style.lineHeight * style.em
	local padding = style.em * style.padding
	local margin = style.em * style.margin
	local screenW, screenH = love.graphics.getDimensions()

	local textboxH = lh * lines + padding * 2
	local borderPad = padding + style.borderWidth

	board.textbox = {
		margin,                      -- X
		screenH - margin - textboxH, -- Y
		screenW - margin * 2,        -- Width
		textboxH,                    -- Height
		style.borderRadius           -- Radius
	}

	board.namebox = {
		margin + borderPad,                     -- X
		board.textbox[2] - borderPad,           -- Y
		0,                                      -- Width. Set with name.
		lh + math.ceil(style.borderWidth / 2),  -- Height
		math.floor(style.borderRadius / 2 + 1), -- Radius
	}

	board.selectbox = {
		margin + style.borderWidth + padding * 2, -- X
		0,                                        -- Y. Set when drawn.
		board.textbox[3] - padding * 4,           -- Width
		lh * 2,                                   -- Height
		style.borderRadius                        -- Radius
	}

	board.text = {
		love.graphics.newText(style.font),
		margin + borderPad,                             -- X
		board.textbox[2] + padding - style.borderWidth, -- Y
		format = {
			board.textbox[3] - borderPad * 2,
			"left",
		}
	}

	board.name = {
		love.graphics.newText(style.font),
		board.namebox[1] + math.floor(borderPad / 2), -- X
		board.namebox[2],                             -- Y
	}

	board.select = {
		love.graphics.newText(style.font),
		board.selectbox[1] + padding,      -- X
		0,                                 -- Y
		format = {
			board.selectbox[3] - padding * 2,
			"center",
		},
	}
end

textboard.newBoard = function(style, lines)
	local board = {
		draw = drawBoard,
		updateName = nameChange,
		setSelect = setSelect,
		show = false,
	}

	textboard.recalc(board, style, lines)
	return board
end

return textboard
