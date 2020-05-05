return {
	{"name", "María"},
	{"style", lib.style.vnMaria},
	[[Me apresuré buscando la casa del chico. ¿Sabía cual era? Nunca se me
ocurrió girarme a verla bien cuando me iba. Por suerte, la casa de en frente si
la reconocí.]],

	[[Entré por la puerta que había dejado abierta, y lo primero que noté
fue que el chico no estaba. ¿Se habrá levantado? ¿Habrá tenido que huir de
algo? El living se veía intacto, así que nada ha entrado. Calmé mis nervios.
"Seguro fue al baño", me dije, pero por si acaso fui a la cocina a ver los dos
cuerpos.]],

	[[Seguían muertos. Todo en orden, al parecer. La puerta estaba cerrada,
pero igual le puse seguro. Solo faltaba... el chico.]],

	[["Seguro fue al baño", me repetí. Iría a buscarlo ahí. Si. Pero de
pronto, un grito primal de dolor que me heló el alma.]],

	{"name"},
	[["¡¡LA CONCHA DE LA LORAAAAAAA!!"]],

	{"bg", "add", args={lib.img["cuchillo de cocina canvas 1-1.png"],
		-60, -108},
		color={1,1,1,0},
		tween={"fadein", 1/3, "delay", 1/3, "fadeout", 1/3, true}},
	{"name", "María"},
	[[Tomé lo primero que encontré a mano y corrí al segundo piso a buscar
al chico. ¿Que esperaba hacer? ¿Creía que serviría yo de algo? Lamentablemente,
no parecía ser yo la que tomaba decisiones hoy día. Ví una habitación con la
puerta abierta y con un fuerte olor a alcohol proviniendo de adentro. Entré.]],

	[[Encontré al chico en el baño sin polera, agitando los brazos
y saltando vehementemente. En su mano, una botella de alcohol que se acababa de
hechar por la espalda.]],

	{"name", "chico"},
	[["¡RRRGH!" gritó de nuevo, y apretando los puños pareció disipar de
una todo su dolor. El vapor se fue. Entoces el chico me miró con esos
atrapantes ojos marrones.]],

	[["Oh, hola. ¿Donde estabas?" me preguntó aparentando estar bien, pero
respiraba entrecortado por el dolor... o tal vez el frio.]],

	{"name", "María"},
	[["Ehh...", titubee. Noté que había entrado con un cuchillo en la mano,
pero el chico no parecía alarmado por eso. "¿Y-Yo? P-Por ahí." El chico se
quedó mirándome un rato, como no sabiendo que decir. 'Por ahí', ¿que clase de
respuesta es esa?]],

	[["En realidad--", empecé para tratar de arreglarla.]],

	{"name", "chico"},
	[["Disculpa, ¿cual era tu nombre? Solo recuerdo hasta lo de la cubeta,
lol."]],

	{"name", "María"},
	[["M-María", le respondí]],

	{"name", "chico"},
	[["María", dijo sonriendo. "Como mi guitarra, lol"]],

	{"name", "María"},
	[[El chico tomó su guitarra que por alguna razón tenía en el baño.]],

	{"bgm", "set", "el real", false, source=lib.bgm["El Real.ogg"],
		fade={"delay", lib.chrono.textSpeed * 45, "cmd", "play", {}}},
	{"name", "chico"},
	[["Yo me llamo... Bakeritsu."]],
	{"bgm", "clear"},

	{"name", "María"},
	[[Tras eso se puso su polera.]],

	{"bgm", "set", 1, 1, source=lib.bgm["dedededede.ogg"]},
	{"wait", 2/3},
	{"bg", "add", args=lib.gen.titleCard(lib.style.titleCard,
		"En este\ncliffhanger\nterminamos.")},
	{"wait", 13},
	{"bg", "clear"},
	{"bgm", "clear"},
}
