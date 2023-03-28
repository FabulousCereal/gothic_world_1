return {
	{"bgm", "set", source="Nostalgia.ogg"},
	{"name"},
	{"style", "vnMaria"},
	[[Me desperté.]],

	res.fun.macro.title,
	{"macro", res.fun.macro.date, {2011, 11, 11, 10, 0}},

	{"name", "María"},
	[[El cielo se pintaba de un color gris abismal. Me levanté, casi sin
ánimos de nada. Creía ilusa que podía aguantar muchas cosas, pero parecía que
hasta quedarme en un hotel mas de dos días resultaba demasiado.]],

	{"bg", "add", args=f0b.elem.screenFill,
		color=res.palette("repellantYellow", 1, 3/4)},
	{"bg", "add", args={{res.fun.clock.wall(
			res.style.clockTint, 10, 00, "Saikō", nil, "line"
		)}, 12, 12},
		exec=f0b.shapes.dropShadow,
		color=res.palette("repellantYellow")},
	{"bg", "add", args=f0b.elem.screenFill, color={0, 0, 0, 1},
		tween={"fadeout", 1/3}},

	[[El reloj marcaba las 10am justas, su molesto tick-tack reverberando
de un lado a otro en el cuarto ante el silencio sepulcrural en que me hayaba.]],

	{"bg", "mod", 1, 2, tween={"delay", 1/3, true}},
	{"bg", "mod", tween={"fadein", 1/3, true}},

	{"bg", "add", 1, color=res.palette("repellantYellow", 0),
		tween={"delay", 2/3, "fadein", 2/3},
		args={{
			{args={"Flash/i die/Nube.png", 0, -50}},
			{args={"Flash/la-guagua.png", 0, 137}},
			{args={"ventana.png"}, color={1, 1, 1, .5}},
		}},
	},

	[[La ciudad había muerto en el intervalo de dos días. Era irreal, mi
única vista al exterior era la ventana que daba al patio del hotel. Aquello de
la gente mutada, los muertos, el humo, pertenecían a la televisión. O eso
deseaba.]],

	{"bg", "mod", 1, tween={"fadeout", 2/3, true}},
	[[Fui a prender la luz para ir al baño, tomar algo de agua, pero
entonces descubrí que no andaba.]],

	[["¡Maldita sea!" pensé. "¿Quién me habrá mandado a hospedarme en este
hotel?"]],

	[[Claro... había sido yo.]],

--	{"bg", "add", args={"maria/bath.png"}, tween={"fadein", 2/3},
--		color=res.palette("repellantYellow", 0)},
	[[Mi nombre es María. Solo diré que tengo 18 años. No me parece que sea
el momento para hablar sobre mí. Tampoco es que quiera, ni que importe.]],

--	{"bg", "mod", tween={"fadeout", 2/3, true}},
	[[Me tragué mi frustración y, guardando una navaja en mi bolsillo, salí
por fín de mi cuarto. Muy cómodo y seguro será, pero ningún humano podía vivir
por mucho ahí. Me volvería loca si seguía una hora mas.]],

	{"bg", "add", args={"hotel.jpg", 0, 0, 0, .8},
		tween={"fadein", 1/3},
		color=res.palette("repellantYellow", 0)},
	[[Nadie en los pasillos, nadie en las escaleras, nadie en el comedor.
La falta de luz hacía difícil ver lejos de las ventanas, ¿pero que
importaba? Estaba sola.]],

	[[Si no hubiera tenido ya una crisis de pánico la noche que comenzó
todo, quizás estaría al borde de otra... O quizás, solo quizás, me encontraría
en donde sea que se haya ido toda la gente.]],

	[[Tuvieron que haberse ido a algún lado, ¿verdad? Evacuar.]],

	{"bg", "mod", tween={"fadeout", 1/3, true}},
	[[Sin comida ni gente que restara, salí a la calle. Sin saber que
hacer, me puse a caminar.]],

	{"bg", "add", color=res.palette("tenpm", 0),
		tween={"delay", 1/3, "fadein", 2/3},
		args={{
			{args={"Flash/i die/Nube.png", 0, -50}},
			{args={"Flash/i die/Montañas.png", 40, 160}},
			{args={"Flash/until.png", 0, 136}},
		}},
	},
	[[Era un día especialmente frío hoy. En las calles no se veía a nadie
ni nada.]],

	[[La nieve de dos días se había acumulado en las calles y en las
veredas, entorpeciéndome el paso. El viento polar se colaba por las ventanas de
las casas, silbaba entre las ramas de los árboles que muertos sin sus hojas
asemejaban--]],

	{"bgm", "mod", fade={"fadeout", 1/3, true}},
	{"sfx", "sfx/sombra.flac", 1/3},
	{"name"},
	[[...*ffff*]],

	{"name", "María"},
	[["¿Q-Que fue eso?" El extraño sonido detuvo en un segundo todos mis
pensamientos.]],

	{"sfx", "sfx/sombra.flac", 2/3},
	{"name"},
	[[*ffff*]],

	{"name", "María"},
	[[Se oyó el ruido una vez mas. Asustada, me giré para buscarlo, pero
las calles se seguían viendo vacias. No sabía lo que era.]],

	{"sfx", "sfx/sombra.flac"},
	{"name"},
	[[*FFFF*]],

	{"name", "María"},
	{"bg", "mod", tween={"fadeout", 2/3, true}},
	{"bg", "add", color=res.palette("tenpm", 0),
		tween={"delay", 1, "fadein", 2/3},
		args={{
			{args={"Flash/i die/Nube.png", 640, 480, 0, -1}},
			{args={"Flash/the.png", 0, 136}},
		}},
	},

	[[Creí ver de reojo algo moverse, pero me puse a correr en vez de
quedarme a mirar. El ruido me siguió. Me buscaba.]],

	{"bg", "sync"},
	{"bg", "mod", tween={"fadeout", 2/3, true}},
	{"bg", "add", args={"streetlamps.png", 0, 0, 0, .8},
		color=res.palette("tenpm", 0),
		tween={"delay", 1, "fadein", 2/3}},
	[[No conocía el barrio, apenas y había llegado la tarde del día del
evento. El ruido se hacía cada vez mas intenso, y por alguna estupidez mía, por
miedo, giré sin pensarlo en un callejón.]],

	{"bg", "rm"}, --tween={"fadeout", 2/3, true}},
	{"wait", 2/3},
	[[Sin salida.]],

	{"bg", "add", args={"yssm.png", -80},
		color=res.palette("tenpm", 0, 1.5),
		tween={"fadein", 2/3}},
	[[Corrí a tratar de trepar la malla apoyándome en un bote de
basura, pero cuando estaba por alcanzar el borde, algo me tomó. El bote se
movió bajo mis pies.]],

	{"sfx", "freesound/377888__usernamemoe__trash-can-falling_edit.flac"},
	{"bg", "mod", tween={"fadeout", 1/6, true}},
	[[Caí.]],

	{"bg", "sync"},
	[[Solo alcancé a ver por un momento la forma borrosa de la criatura
antes de golpearme la cabeza en el suelo. Oí ladridos, y el mundo se fue.]],
}
