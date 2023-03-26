-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

return {
	clamp = function(n, min, max)
		return math.min(math.max(n, min), max)
	end,

	tau = math.pi * 2,

	oneMod = function(n, div) -- Fuck one-based indexing
		return (n-1)%div + 1
	end,
}
