local function textboardRecalc(board, style, lines)
	local em = style.font:getHeight()
	local lh = em * style.lineHeight
	local padding = em * style.padding
	local margin = em * style.margin
	local screenW, screenH = love.graphics.getDimensions()

	local floor = math.floor

	local tbox = board.textbox
	local nbox = board.namebox
	local sbox = board.selectbox
	local text = board.text
	local name = board.name
	local select = board.select

	local textboxH = lh * lines + padding + style.borderWidth
	tbox[1] = floor(margin)                      -- X
	tbox[2] = floor(screenH - margin - textboxH) -- Y
	tbox[3] = floor(screenW - margin * 2)        -- Width
	tbox[4] = floor(textboxH)                    -- Height
	tbox[5] = style.borderRadius                 -- Radius


	local nameboxH = em + style.borderWidth / 2
	nbox[1] = floor(tbox[1] + padding)   -- X
	nbox[2] = floor(tbox[2] - nameboxH)  -- Y 
	-- Width is set with name.
	nbox[4] = floor(nameboxH)            -- Height
	nbox[5] = style.borderRadius / 2 + 1 -- Radius


	sbox[1] = floor(margin + style.borderWidth + padding * 2) -- X
	-- Y is modified during drawing.
	sbox[3] = floor(tbox[3] - padding * 4)                    -- Width
	sbox[4] = floor(em + padding / 2)                         -- Height
	sbox[5] = style.borderRadius                              -- Radius


	text[1]:setFont(style.font)
	text[2] = floor(tbox[1] + padding)     -- X
	text[3] = floor(tbox[2] + padding / 2) -- Y
	text.format[1] = floor(tbox[3] - (padding + style.borderWidth) * 2)


	name[1]:setFont(style.font)
	name[2] = floor(nbox[1] + padding / 2) -- X
	name[3] = nbox[2]                      -- Y


	select[1]:setFont(style.font)
	select[2] = floor(sbox[1] + padding)               -- X
	select[3] = floor(tbox[4] + em * style.margin * 2) -- Y
	select.format[1] = sbox[3] - padding * 2           -- Max text width

	return board
end

return {
	setSelect = function(board, style, lines)
		local lineSpacing = style.font:getHeight() * style.lineSpacing
		local lineY = 0

		local select = board.select
		local text = select[1]
		local wrap, align = unpack(select.format)
		text:clear()
		for i = 1, #lines do
			text:addf(lines[i], wrap, align, 0, math.floor(lineY))
			lineY = lineY + lineSpacing
		end
		select.options = lines
		select.cur = 1
	end,

	setName = function(board, style, name)
		if name and #name > 0 then
			local em = style.font:getHeight()
			local pad = style.padding * em + style.borderWidth
			board.name[1]:set(name)
			board.namebox[3] = math.floor(
				board.name[1]:getWidth() + pad)
		else
			board.namebox[3] = 0
		end
	end,

	setText = function(board, ...)
		return board.text[1]:set(...)
	end,

	keypress = function(board, key)
		local select = board.select
		if key == "return" then
			select.options = nil
			return select.cur
		elseif key == "up" then
			select.cur = ((select.cur - 2) % #select.options) + 1
		elseif key == "down" then
			select.cur = ((select.cur) % #select.options) + 1
		elseif key == "home" then
			select.cur = 1
		elseif key == "end" then
			select.cur = #select.options
		end
	end,

	draw = function(board, style)
		local graphics = love.graphics

		f0b.shapes.bordered(graphics.rectangle, style,
			unpack(board.textbox))
		graphics.setColor(style.color)
		graphics.draw(unpack(board.text))

		if board.namebox[3] > 0 then
			f0b.shapes.bordered(graphics.rectangle, style,
				unpack(board.namebox))
			graphics.setColor(style.color)
			graphics.draw(unpack(board.name))
		end

		if board.select.options then
			local em = style.font:getHeight()
			local lineSpacing = em * style.lineSpacing
			local padding = em * style.padding

			local floor = math.floor
			local select, selectbox = board.select, board.selectbox
			selectbox[2] = floor(select[3] - padding / 4)
			for i = 1, #select.options do
				local lStyle
				if i == select.cur then
					lStyle = style
				else
					lStyle = style.unselected
				end
				f0b.shapes.bordered(graphics.rectangle, lStyle,
					unpack(selectbox))
				selectbox[2] = floor(selectbox[2] + lineSpacing)
			end
			graphics.setColor(style.color)
			graphics.draw(unpack(select))
		end
	end,

	recalc = textboardRecalc,

	new = function(style, lines)
		local newText = love.graphics.newText
		local board = {
			show = false,

			textbox = {0, 0, 0, 0, 0},
			namebox = {0, 0, 0, 0, 0},
			selectbox = {0, 0, 0, 0, 0},
			text = {
				newText(style.font), 0, 0,
				format={0, "left"}
			},
			name = {
				newText(style.font), 0, 0
			},
			select = {
				newText(style.font), 0, 0,
				format={0, "center"},
				options=nil,
				cur=1
			},
		}

		return textboardRecalc(board, style, lines)
	end,
}
