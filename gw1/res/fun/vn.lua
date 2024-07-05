-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function genFade(fade, idx, ...)
	local ins = table.insert
	local t = {"bg", ...}
	ins(t, "fade")
	if type(idx) == "table" then
		for i = 1, #idx do
			ins(t, idx[i])
		end
	else
		ins(t, idx)
	end
	ins(t, fade)
	return t
end

local function swap(set1, set2, secs, ...)
	return {"read", {
		genFade({"fadein", secs}, set1, ...),
		genFade({"fadeout", secs}, set2, ...),
	}}
end

return {
	swap = swap,

	charSwap = function(s1, s2, secs)
		return swap(s1, s2, secs, 2)
	end,

	mv = function(x, t)
		return {"bg", "mod", 2, 3, fade={"mvabs", x, false, t}}
	end,

	lowpass = function(gain, vol)
		return {setFilter={type="lowpass", volume=vol, highgain=gain}}
	end,
}
