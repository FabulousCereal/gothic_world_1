local function titleMacro()
	local font = res.fonts("vollkorn", 48)
	local x = 200
	local y = 60
	local width = 440
	local height = font:getHeight() * 2 * font:getLineHeight()

	local canvas = love.graphics.newCanvas(
		width, height, {format = "rgba4"}
	)
	love.graphics.setCanvas(canvas)
	love.graphics.setFont(font)
	love.graphics.printf({
		{0, 0.5, 0.5, 1}, "Готика Дүние\n",
		{0.5, 0.5, 0, 1}, "/киял/"
	}, 0, 0, width, "center")
	love.graphics.setCanvas()
	return {
		{"bg", "add", args={canvas, x, y}, tween={"fadein", 3}}
	}
end

return {
	{"style", "vnMaria"},
	{"name", "María"},
	[[Eran las cuatro de la mañana cuando desperté.]],

	[[Visiones terroríficas plagaban mis sueños. Siempre que cerraba mis
ojos era lo mismo. Tormentas, susurros, los ecos de las olas de un pasado
perdido.

Inmemorable. Condenado.]],

	[[Me senté en la cama abrazando fuertemente la almohada. Tenía un nudo
en la garganta, y mi cabeza y mi pecho parecian que fueran a estallar. Tenía
ganas de gritar, de llorar, pero las lágrimas no salían.]],

	[[Lo que sentía era demasiado para siquiera reaccionar... pero quizás
debía ser así. Era inaceptable que pudiera aliviar esta pena. Olvidar la
lluvia. Los botes. El Ziggurat...]],

	[[Lo sabía, de alguna forma. Yo viví en aquel tiempo turbulento. Morí
en el, bajo el diluvio.]],

	[[Me levanté vacilante y caminé hasta el baño, dejando caer la almohada
a medio camino. Busqué la luz con el tacto, pero pronto desistí. Las luces de
la calle se filtraban entre las rejillas de la ventana y me dejaban verme en el
espejo, mostrando que seguía siendo yo.]],

	[[Yo fuí una mujer en aquel tiempo. Mi nombre fue Elena, nacida hace
5783 años.]],

	[[De mi pueblo, como tantos, ya no queda ni el nombre. Ninguna prueba
de que alguna vez caminamos por esta tierra. Nuestras creencias, nuestras
historias y nuetras vidas...]],

	titleMacro,
	[[Las aguas negras borraron todo.

Las olas nunca dejan de oirse...]],

	{"bg", "add",
		args=res.fun.card.subtitle(
			{{1,1,1,1}, "Gothic World\n/fantasía/"},
			"center"
		)
	},
	{"sfx", "gw.wav"},
	false,
	{"bg", "mod", 1, tween={"fadeout", 3, true}},
	false,
	{"bg", "rm"},
}
