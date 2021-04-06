return {
	{"name", "María"},
	{"style", "vnMaria"},
	[[Me apresuré buscando la casa del chico. Una tonta, una tonta es lo
que soy. ¿Sabía cual era? No se me ocurrió girarme a verla cuando me iba.]],

	[[Por suerte la pude reconocer cuando el perro empezó a ladrarme.]],

	{"name", "Pipi"},
	[["¡Guau guau guau!"]],

	{"name", "María"},
	[["¿Que dices, Pipi? ¿Que el chico se cayó a un pozo?"]],

	[[Entré a la casa, y lo primero que noté fue que el chico no estaba en
el sofá. Mierda. ¿Se habrá levantado? ¿Habrá tenido que huir de algo? El living
se veía intacto, así que nada ha entrado. Calmé mis nervios. Me estaba
asustando sola.]],

	[["A lo mejor fue... fue al baño", me dije, pero por si acaso fui
primero a la cocina a ver los dos cuerpos.]],

	[[Seguían muertos, inmóviles. Se veía todo en orden también aquí. La
puerta estaba bien cerrada, pero igual le puse seguro. Solo faltaba... el
chico. Debía estar en el segundo piso, ¿verdad? De pronto, un grito primal de
dolor que me heló el alma cortó el aire.]],

	{"name"},
	[["¡¡LA CONCHA DE LA LORAAAAAAA!!"]],

	{"bg", "add", args={"cuchillo de cocina canvas 1-1.png",
		-60, -108},
		color={1,1,1,0},
		tween={"fadein", 1/3, "delay", 1/3, "fadeout", 1/3, true}},
	{"name", "María"},
	[[Tomé lo primero que encontré a mano y corrí arriba a buscar al chico.
¿Que esperaba hacer? ¿Creía que serviría yo de algo? Lamentablemente, no
parecía ser yo la que tomaba decisiones hoy día. Ví una habitación con la
puerta abierta y con un fuerte olor a alcohol proviniendo de adentro. Entré.]],

	[[Encontré al chico en el baño sin polera ni pantalones, agitando los
brazos y saltando vehementemente. En su mano, una botella de alcohol
desinfectante que se acababa de hechar por la espalda.]],

	{"name", "chico"},
	[["¡RRRGH!" gruñó de nuevo mientras le corría el alcohol por el cuerpo,
era como que se duchaba con ella, y tras apretar los puños pareció disipar de
una todo su dolor. El vapor se fue. Entoces el chico se giró a mirarme con esos
cautivadores ojos marrones.]],

	[["Oh, hola. ¿Donde estabas?" me preguntó disimulando estar bien, pero
respiraba entrecortado por el dolor... o tal vez el frio. Andaba solo en
boxers.]],

	{"name", "María"},
	[["Ehh..." titubee. Noté que había entrado con un cuchillo en la mano,
pero el chico no parecía alarmado por esto. Lo tiré en el lavamanos. "¿Y-Yo?
P-Por ahí." El chico se quedó mirándome un rato, como no sabiendo que decir.]],

	[["En realidad--", empecé para tratar de explicar.]],

	{"name", "chico"},
	[["Disculpa, ¿cual era tu nombre? Solo recuerdo hasta lo de la cubeta,
lol."]],

	{"name", "María"},
	[["María," le respondí.]],

	{"name", "chico"},
	[["María," repitió sonriendo. "Como mi guitarra."]],

	{"name", "María"},
	[[El chico tomó su guitarra eléctrica que por alguna razón tenía en el
baño.]],

	{"name", "chico"},
	{"text", [["Yo me llamo...]], false, true},
	{"bgm", "set", source="El Real.ogg"},
	{"text", [[]], true},

	{"text", [[ Bakeritsu."]], true},
	{"bgm", "clear"},

	{"name", "María"},
	[[Tras eso se puso camisa.]],

	{"bgm", "set", source="dedededede.ogg"},
	{"wait", 2/3},
	{"bg", "add", args=res.gen.titleCard(res.font("takaoMincho", 72),
		"En este\ncliffhanger\nterminamos.")},
	{"wait", 13},
	{"bg", "clear"},
	{"bgm", "clear"},
}
