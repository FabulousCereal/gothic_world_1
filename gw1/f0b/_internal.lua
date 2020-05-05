return {
	seqUpdate = function(funcs, target, seq, dt, finish)
		repeat
			local op = seq[1]
			local advance = funcs[op](target, seq, dt, finish)
			if advance then
				for i = advance, 1, -1 do
					table.remove(seq, i)
				end
			end
		until finish ~= true or #seq == 0 or seq[1] == true
		return seq[1]
	end,
}
