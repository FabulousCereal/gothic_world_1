return {
	{"bgm", "set", "nostalgia", source="Nostalgia.ogg"},
	{"bgm", "set", "white", 0, source="wahwahwhite noise.flac",
		setup=res.fun.vn.lowpass(0),
		fade={"fadeto", .25, 6}},
	{"name"},
	{"style", "vnMaria"},
	[[Me desperté.]],

	{"macro", "titleDate", {2011, 11, 11, 10, 0}},

	{"name", "María"},
	[[El cielo se pintaba de un color gris abismal. Me levanté, casi sin
ánimos de nada. Creía que podía aguantar muchas cosas, pero parecía que
hasta quedarme en un hotel mas de dos días resultaba demasiado.]],

	{"bg", "addsub", {
		{draw=f0b.draw.screenFill, color={3/4, 3/4, 3/4, 1}},
		{
			args={{res.fun.clock.wall(
				res.style.clockTint, 10, 00, "Kekkō", "roman",
				"circle"
			)}, 12, 12},
			draw=f0b.draw.dropShadow
		},
	}},
	{"bg", "fold", color=res.palette("repellantYellow", 0),
		fade={"fadein", 1/3}},

	[[El reloj marcaba las 10am justas, su molesto tick-tack reverberando
de un lado a otro del cuarto.]],

	{"bg", "fade", {"delay", 1, true}},
	{"bg", "addsub", {
		{args={"Flash/i die/Nube.png", 0, -50}},
		{args={"Flash/la-guagua.png", 0, 137}},
		{draw=f0b.draw.screenFill,
			shader=res.shader.fbmWarp{
				alphaMask=1, rolloff=.8, amplitude=.25,
			},
		},
	}},
	{"bg", "fold", color=res.palette("repellantYellow", 0),
		fade={"fadein", 1}},

	[[La ciudad había muerto en el intervalo de dos días. Era irreal, mi
única vista al exterior era la ventana que daba al patio del hotel. Aquello de
la gente mutada, los muertos, el humo, pertenecían a la televisión. O eso
deseaba.]],

	{"bg", "fade", {"fadeout", 2/3, true}},
	[[Fui a prender la luz para ir al baño, tomar algo de agua, pero
entonces descubrí que se había cortado.]],

	[["¡Maldita sea!" grité golpeando el muro. ¿Quién me había mandado
a hospedarme en este hotel?]],

	[[Claro... había sido yo.]],

	[[Mi nombre es María. Solo diré que tengo 18 años. No me parece que sea
el momento para hablar sobre mí. Tampoco es que quiera, ni que importe.]],

	[[Me lavé la cara para pasar la frustración, y salí por fín de mi
cuarto, llevando solo las llaves y una navaja conmigo. No pensaba abandonar mis
otras cosas, pero necesitaba salir ahora. Me volvería loca si seguía una hora
mas.]],

	{"bg", "add", args={"hotel.jpg", 0, 0, 0, .8},
		fade={"fadein", 1/3},
		color=res.palette("repellantYellow", 0)},
	[[Nadie en los pasillos, nadie en las escaleras, nadie en el comedor.
La falta de luz hacía difícil ver lejos de las ventanas, ¿pero que
importaba? Estaba sola.]],

	[[Si no hubiera tenido ya una crisis de pánico la noche que comenzó
todo, quizás estaría al borde de otra... O quizás, solo quizás, me encontraría
en donde sea que se haya ido toda la gente.]],

	[[Tuvieron que haberse ido a algún lado, ¿verdad? Evacuar.]],

	{"bg", "fade", {"fadeout", 1/3, true}},
	{"bgm", "fade", "white", {"fadeto", 1, 6}},
	[[Sin comida ni gente que restara, salí al exterior. Sin saber que
hacer, me puse a caminar.]],

	{"bg", "addsub", {
		{args={"Flash/i die/Nube.png", 0, -50}},
		{args={"Flash/i die/Montañas.png", 40, 160}},
		{args={"Flash/until.png", 0, 136}},
	}},
	{"bg", "fold", color=res.palette("tenpm", 0),
		fade={"delay", 1/3, "fadein", 2/3}},
	[[Era un día especialmente frío, con un cielo que estaba mitad nublado,
mitad despejado.]],

	[[No se veía movimiento alguno tras las ventanas de los edificios, no
se oía ruido alguno en las calles. Esto no podía ser una ciudad. Traté de
caminar.]],

	[[La nieve de dos días se había acumulado en las calles y en las
veredas, entorpeciéndome el paso. El viento polar se colaba por las ventanas de
las casas, silbaba entre las ramas de los árboles que muertos sin sus hojas
asemejaban--]],

	{"bgm", "fade", "nostalgia", {"fadeout", 1/3, true}},
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
las calles se seguían viendo vacias. No sabía lo que era. Me empecé a agitar.]],

	{"sfx", "sfx/sombra.flac"},
	{"name"},
	[[*FFFF*]],

	{"name", "María"},
	{"bg", "fade", {"fadeout", 2/3, true}},
	{"bg", "addsub", {
		{args={"Flash/i die/Nube.png", 640, 480, 0, -1}},
		{args={"Flash/the.png", 0, 136}},
	}},
	{"bg", "fold", color=res.palette("tenpm", 0),
		fade={"delay", 2/3, "fadein", 2/3}},

	[[Creí ver de reojo algo moverse, pero me puse a correr antes de verlo
bien. El ruido me siguió. Me buscaba.]],

	{"bg", "fade", {"fadeout", 2/3, true}},
	{"bg", "add", args={"streetlamps.png", 0, 0, 0, .8},
		color=res.palette("tenpm", 0),
		fade={"delay", 2/3, "fadein", 2/3}},
	[[No conocía el barrio, apenas y había llegado la tarde del día del
evento. El ruido se hacía cada vez mas intenso, y por alguna estupidez mía, por
miedo, giré sin pensarlo en un callejón.]],

	{"bg", "rm"},
	{"wait", 2/3},
	[[Sin salida.]],

	{"bg", "add", args={"yssm.png", -80},
		color=res.palette("tenpm", 0, 1.5),
		fade={"fadein", 2/3}},
	[[Corrí a tratar de trepar la malla apoyándome en un bote de
basura, pero cuando estaba por alcanzar el borde, algo me tomó. El bote se
movió bajo mis pies.]],

	{"bg", "fade", {"fadeout", 1/12, true}},
	{"bgm", "fade", "white", {"fadeout", 1/12, true}},
	{"sfx", "freesound/377888__usernamemoe__trash-can-falling.edit.flac", 1, 4/3},
	[[Caí.]],

	{"bg", "add", args={"maria/sombra.png", -680, 0, 0, 3, 3},
		color=res.palette("tenpm", 1),
		fade={"fadein", 1/30, "mvabs", -640, -1280, 1/5, "fadeout", 1/6, true}
	},
	{"sfx", "freesound/648134__5plus5equalspatata__window-break.flac", 1/2, 1, 1/2},
	{"sfx", "freesound/346694__deleted_user_2104797__body-fall_02.flac", 1, 1, 4/3},
	[[Solo alcancé a ver por un momento la forma borrosa de la criatura
antes de golpearme la cabeza en el suelo. Oí ladridos, y el mundo se fue.]],
}
