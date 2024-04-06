-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function sendAll(shader, ctx)
	for k, v in pairs(ctx) do
		if shader:hasUniform(k) then
			shader:send(k, type(v) == "function" and v(ctx) or v)
		end
	end
end

return {
	prepare = function(ctx)
		local prev = love.graphics.getShader()
		local shader = ctx[1]
		sendAll(shader, ctx)
		return shader, prev
	end,
}
