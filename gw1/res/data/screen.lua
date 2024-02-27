-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local function center(text, w, h, textW, textH)
	return {text,
		math.floor(w / 2 - textW / 2),
		math.floor(h / 2 - textH / 2)}
end

return {
	help = function(style, w, h)
		local c = style.color
		local dc = style.disabled.color
		local font = res.font("takaoMincho", 30)
		local em = font:getWidth(" ")
		local sep = ""

		local help = {
			{"Controles",
				{"Seleccionar, avanzar", "Enter"},
				{"Avanzar texto", "Espacio"},
				{"Mover selección", "←", "↑", "→", "↓"},
				{"Sección previa/siguiente", "RePág", "AvPág"},
				{"Ir al inicio/final", "Home", "End"},
				{"Volver al menú previo", "←  "},
				{"Escapar", "ESC"},
			},
			{"Secretos",
				{"Guardar estado", "Ctrl+S"},
				{"Cargar estado", "Ctrl+L"},
				{"Disminuir rojo/verde/azul", "r", "g", "b"},
				{"Aumentar rojo/verde/azul", "R", "G", "B"},
			},
		}

		local text = love.graphics.newText(font)
		local y = 0
		local maxX = 0
		local ins = table.insert
		for i = 1, #help do
			local section = help[i]
			local desc = {c, "\n"}
			local keys = {c, section[1] .. "\n"}
			for k = 2, #section do
				local line = section[k]
				ins(desc, c)
				ins(desc, line[1] .. "\n")
				for m = 2, #line do
					ins(keys, dc)
					ins(keys, "[")
					ins(keys, c)
					ins(keys, line[m])
					ins(keys, dc)
					ins(keys, "]")
				end
				ins(keys, c)
				ins(keys, sep .. "\n")
			end
			text:addf(keys, w, "left", 0, y)
			local textW, textH = text:getDimensions()
			textW = textW + em
			text:addf(desc, w, "left", textW, y)
			y = y + textH
			maxX = math.max(maxX, textW + text:getWidth())
		end
		return center(text, w, h, maxX, y)
	end,

	credit = function(style, w, h)
		local c, dc = style.color, style.disabled.color
		local credit = {dc, "Basada en una historia original\npor el ",
			c, "G", dc, "rupo\n\t\t\t\t",
			c, "W", dc, "arominutes.\n\nGráficos adicionales por ",
			c, "Z", dc, "eh ", c, "R", dc, "oh."}
		local text = love.graphics.newText(style.font, credit)
		return center(text, w, h, text:getDimensions())
	end,

	menu = function(style, w, h)
		local text = love.graphics.newText(style.font, "Gothic World 1")
		local textW, textH = text:getDimensions()
		return {text,
			math.floor(w * 1/2 - textW / 2),
			math.floor(h * 5/6 - textH / 2)}
	end,
}
