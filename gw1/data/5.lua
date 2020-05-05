return {
	{"name"},
	{"style", lib.style.vnMaria},
	[[Me desperté.]],

	{"bgm", "set", "Nostalgia", 1, source=lib.bgm["Nostalgia.ogg"]},
	{"gen", exec=lib.gen.dateSubs, args={2011, 11, 11, 10, 0}},

	{"name", "María"},
	[[El cielo de pintaba de un color gris abismal. Me levanté, casi sin
ánimos de nada. Creía ilusa que podía aguantar muchas cosas, pero parecía que
hasta quedarme en un hotel mas de dos días resultaba demasiado.]],

	{"bg", "add", args=common.screenCover,
		color=lib.palette("repellantYellow")},
	{"bg", "add", args={12, 12, lib.gen.wallClock(lib.style.clockTint,
		10, 00, "Saikō", nil, "line")},
		exec=f0b.shapes.dropShadow,
		color=lib.palette("repellantYellow", 1, 4/3)},
	{"bg", "add", args=common.screenCover, color={0, 0, 0, 1},
		tween={"fadeout", 1/3}},

	[[El reloj marcaba las 10am justas, su molesto tick-tack reverberando
de un lado a otro en el cuarto ante el silencio sepulcrural en que me hayaba.]],

	{"bg", "mod", 1, 2, tween={"delay", 1/3, true}},
	{"bg", "mod", tween={"fadein", 1/3, "delay", 1/3, "fadeout", 2/3}},

	{"bg", "add", 1, args={lib.img["Flash/i die/Nube.png"], 0, -50},
		color=lib.palette("repellantYellow")},
	{"bg", "add", 2, args={lib.img["la-guagua.png"], 0, 137},
		color=lib.palette("repellantYellow")},
	{"bg", "add", 3, args={lib.img["ventana.png"]},
		color=lib.palette("repellantYellow", .5, 1.1)},
	[[La ciudad había muerto en el intervalo de dos días. Era irreal, mi
única vista al exterior era la ventana que daba al patio del hotel. Aquello de
la gente mutada, los muertos, el humo, pertenecían a la televisión. O eso
deseaba.]],

	{"bg", "mod", tween={"fadein", 2/3, "delay", 1/3, true}},
	{"bg", "mod", 1, 3, tween={"delay", 2/3, true}},
	[[Fui a prender la luz para ir al baño, tomar algo de agua, pero
entonces descubrí que no andaba.]],

	[["¡Maldita sea!" pensé. "¿Quién me habrá mandado a hospedarme en este
hotel?"]],

	[[Claro... había sido yo.]],

	[[Mi nombre es María. Solo diré que tengo 18 años. No me parece que sea
el momento para hablar sobre mí. Tampoco es que quiera, ni que importe.]],

	[[Dejé pasar mi frustración y salí de mi cuarto. Muy cómodo y seguro
será, pero ningún humano podría vivir por mucho ahí. Me volvería loca mirando
el papel amarillo de las paredes.]],

	{"bg", "add", args={lib.img["hotel.jpg"], 0, 0, 0, .8},
		tween={"fadein", 1/3},
		color=lib.palette("repellantYellow", 0)},
	[[Nadie en los pasillos, nadie en las escaleras, nadie en el comedor.
La falta de luz hacía difícil ver lejos de las ventanas, ¿pero que importaba?
Estaba sola.]],

	[[Si no hubiera tenido ya una crisis de pánico tremenda el primer día,
quizás estaría teniendo otra... O quizás, solo quizás, estaría en donde sea que
se haya ido toda la gente.]],

	[[Tuvieron que haberse ido a algún lado, ¿verdad? Evacuar.]],

	{"bg", "mod", tween={"fadeout", 1/3, true}},
	[[Sin comida ni gente que restara, salí a la calle. Sin saber que
hacer, me puse a caminar.]],

	{"bg", "add", args={lib.img["Flash/i die/Nube.png"], 0, -50},
		color=lib.palette("tenpm")},
	{"bg", "add", args={lib.img["Flash/i die/Montañas.png"], 40, 160},
		color=lib.palette("tenpm")},
	{"bg", "add", args={lib.img["Flash/until.png"], 0, 136},
		color=lib.palette("tenpm")},
	{"bg", "add", args=common.screenCover, color={0, 0, 0, 1},
		tween={"fadeout", 1/3}},
	[[Era un día especialmente frío hoy. En las calles no se veía a nadie
ni nada.]],

	[[La nieve de dos días se había acumulado en las calles y en las
veredas, entorpeciéndome el paso. El viento polar se colaba por las ventanas de
las casas, silbaba entre las ramas de los árboles que muertos sin sus hojas
asemejaban--]],

	{"sfx", "maquinaman.ogg", 1/3},
	{"bgm", "mod", "Nostalgia", fade={"fadeout", 1/3, true}},
	{"name"},
	[[......*ffff*]],

	{"name", "María"},
	[["¿Q-Que fue eso?" El extraño sonido detuvo en un segundo todos mis
pensamientos.]],

	{"sfx", "maquinaman.ogg", 2/3},
	{"name"},
	[[.........*ffff*]],

	{"name", "María"},
	[[Se oyó el ruido una vez mas. Asustada, me giré para buscarlo, pero
las calles se seguían viendo vacias. No sabía lo que era.]],

	{"sfx", "maquinaman.ogg"},
	{"wait", 2/3},
	{"name"},
	[[*FFFF*]],

	{"name", "María"},
	{"bg", "mod", tween={"fadein", 2/3, "delay", 1/3, "fadeout", 2/3}},
	{"bg", "mod", 1, 3, tween={"delay", 2/3, true}},
	{"bg", "add", 1,
		args={lib.img["Flash/i die/Nube.png"], 640, 480, 0, -1},
		color=lib.palette("tenpm")},
	{"bg", "add", 2, args={lib.img["Flash/the.png"], 0, 136},
		color=lib.palette("tenpm")},
	[[Creí ver de reojo algo moverse, pero me puse a correr en vez de
quedarme a mirar. El ruido me siguió. Me buscaba.]],

	{"bg", "finish"},
	{"bg", "mod", tween={"fadein", 2/3, "delay", 1/3, true}},
	{"bg", "mod", 1, 2, tween={"delay", 2/3, true}},
	{"bg", "add", args={lib.img["streetlamps.png"], 0, 0, 0, .8},
		color=lib.palette("tenpm", 0),
		tween={"delay", 1, "fadein", 2/3}},
	[[No conocía el barrio, apenas y había llegado la tarde del día del
evento. El ruido se hacía cada vez mas intenso, y por alguna estupidez mía, por
miedo, giré sin pensarlo en un callejón.]],

	{"bg", "mod", tween={"fadeout", 2/3, true}},
	{"wait", 2/3},
	[[Sin salida.]],

	{"bg", "add", args={lib.img["yssm.png"], -80},
		color=lib.palette("tenpm", 0, 1.5),
		tween={"delay", 2/3, "fadein", 2/3,
			"delay", lib.chrono.textSpeed * 160,
			"fadeout", 1/6, true}},
	[[Corrí a tratar de trepar la malla apoyándome en un bote de basura,
pero cuando estaba por alcanzar el borde, algo me tomó. El bote se movió bajo
mis pies. Perdí el equilibrio. Caí.]],

	{"bg", "finish"},
	[[Solo alcancé a ver por un momento la forma borrosa de la criatura
antes de golpearme la cabeza en el bote, y el mundo se fue.]],
}
