-- Prints text codepoint by codepoint.
-- Assumes valid UTF-8
local function nextCodePoint(text, start)
	local byte = string.byte(text, start)
	if byte > 0xf0 then
		finish = start + 3
	elseif byte > 0xe0 then
		finish = start + 2
	elseif byte > 0xc0 then
		finish = start + 1
	else
		finish = start
	end
	return finish, string.sub(text, start, finish)
end

return {
	finish = function(board, style)
		board[1]:setf(board.text, unpack(board.format))
		board.finished = true
	end,

	advance = function(board, style)
		if #board.text >= board.pos then
			local newPos, char = nextCodePoint(board.text, board.pos)
			board[1]:setf(
				string.sub(board.text, 1, newPos),
				unpack(board.format)
			)
			board.pos = newPos + 1
			return char
		else
			board.finished = true
			return nil
		end
	end,

	setup = function(board, style, text, keep)
		local text = string.gsub(
			string.gsub(text, "([^\n])\n%s*([^\n])", "%1 %2"),
			"\n+%s*", "\n"
		)
		local _, text = style.font:getWrap(text, board.format[1])
		board.text = table.concat(text, "\n")
		board.pos = 1
		board.finished = false
		board[1]:clear()
	end,
}
