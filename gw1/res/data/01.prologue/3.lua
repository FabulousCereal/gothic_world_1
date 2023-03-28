return {
	{"style", "vnFalcon"},
	{"name", false},
	[[Lo último que recuerdo era que estaba en la calle con mi chica.
Aquella imagen quedó grabada en mi mente, lo único que quedó de antes de la
explosión.]],

	{"bg", "add", args=f0b.elem.screenFill, color={1,1,1,1},
		tween={"fadeout", 6, true}},
	{"sfx", "sfx/explosión cercana.flac"},
	{"wait", 1, true},
	{"macro", res.fun.macro.date,
		{2011, 11, 8, 18, 34, idx=1}},

	{"name", "------"},
	[[Desperté entremedio de rocas y cenizas, con un dolor que me partía la
cabeza. Tenía la boca seca y la piel me ardía.]],

	{"bg", "add", args={"croft/street_crappy_test_by_croft70-d57ige5.png", 0, 0,
		0, .8, .8},
		tween={"fadein", 1}},
	[[Miré a todos lados confundido, buscando mi chica, donde estaba mi
chica. Las llamas habían consumido casi todo a mi alrededor. Ella no estaba.]],

	[[No recordaba que era lo que estábamos haciendo por acá, ni a donde
nos dirigiamos ni porque pasamos por aquí. Abrí la boca para llamarla... pero
no pude recordar su nombre.]],

	[[No recuerdo el mio tampoco.]],

	[[Toda mi ropa estaba desgarrada y al parecer por unas garras, tal vez
fueron perros.]],

	[[Me puse de pie apoyándome en lo que quedaba de la pared mas cercana.
La cabeza me daba vueltas. Había un horrendo olor metálico que no me dejaba
respirar. Humo salía aún del edificio. No entendía nada de lo que pasaba.]],

	[[Mi pierna derecha parecía no responderme, así que caí al tratar de
dar un paso. "Necesito un hospital" fue lo único que pude pensar. Al
levantar la mirada, pude ver algunos carros abandonados. Sus puertas habían
quedado abiertas.]],

	{"bg", "mod", tween={"fadeout", 1/3, true}},
	{"text", [[Me arrastré hasta uno y utilicé mis instintos para volverlo
a prender sin usar las llaves. El motor cobró vida de inmediato y el tablero se
iluminó.]], false, true},

	{"bg", "add", args={res.fun.clock.alarm(
			res.style.carClockAlarm, 17, 34)},
		color={1, 1, 1, 0},
		tween={"fadein", 1/6},
	},
	{"text", [[ El reloj marcaba las 17:34.]], true},

	{"bg", "mod", tween={"delay", 2, "fadeout", 1/12, true}},

	[[Me puse a manejar aunque no podía reconocer el lugar. Pensé que me
debería ser familiar, pero los nombres de la calles no me sonaban, lo único que
sabía era que se conducía por la derecha.]],

	[[Mientras iba manejando veía a personas que al parecer estaban
delirando, quizás solo un poco peor que yo. A momentos se me iba la
consciencia, pero milagrosamente sobrevivimos yo y el auto hasta que una
señalética me indicó donde había un hospital.]],

	[[Estacioné afuera en la calle, no le puse seguro porque no tenía las
llaves. Pude cogear hasta la entrada para que me atendieran por el pie y otras
heridas menores, pero había demasiada gente.]],

	[[¿Era asi siempre? Debí haberme golpeado fuerte, no podía ni recordar
si la atención pública era buena, pero sospechaba que la situación no era
normal. Busqué un muro donde apoyarme. No quedaban asientos.]],

	[[Sentí algo de tristeza mirando a tanta gente, porque había señores y
señoras llorando por sus hijos, hijas, o familiares. Pensé en mi chica una vez
más, debí haberla buscado mejor, no sabía que tan grave fue lo que ocurrió.]],

	[[La explosión debió ser muy fuerte, o el humo que salía era
tóxico. Me sentía mareado aún, pero por lo menos no estaba delirando. Fuí al
baño a beber agua, y noté un derrame en mi ojo izquierdo, que a estas alturas
ni me pareció importante.]],

	[[Pasada una hora en el hospital, me aburrí porque nadie me había
visto, y entré en pánico. Me metí a los pasillos y fuí con un maldito doctor
que estaba mirando papeles y le rogué que me atendiera.]],

	[[El doctor, al ver que estaba actuando como loco, me golpeó y me dijo
que me calmara. Me preguntó como me sentía, le dije que no sabía que tenía en
mi pierna. Me llevó hasta una silla porque estaban todos los cubículos ocupados
y me comenzó a checar.]],

	[[Me dijo que tenía un esguince, que solo descansara y que me mejoraría
en unos días. Por el mareo no podía hacer nada, que respirara aire fresco nada
mas. Claro. El doctor logró conseguir algunas vendas para el pie y con eso
me fuí de ahí.]],

	[[Salí rápido a buscar el carro porque una niña comenzó a balbucear y
tratar de morder a su padre, o no sé que será suyo.]],

	[[Una vez me subí al carro apoyé la cabeza en el mando sin saber que
hacer. El dolor y el mareo habían pasado un poco, pero tenía la mente en
blanco. No podía recordar donde vivía. Ninguna imagen o dirección. Me revisé
los bolsillos, buscando alguna identificación o un celular.]],

	[[...Nada, pero tenía unos billetes que reconocía. Por lo
menos sé que vivo en este país.]],

	[[Sin rumbo claro, comencé a dar vueltas esperando encontrar algún
policía que me pudiera ayudar, o en el caso mas rebuscado darme cuenta de donde
me hallaba. Tras media hora ví el anuncio de un hostal.]],

	{"bg", "add", args={res.fun.clock.alarm(res.style.carClockAlarm, 20, 50)},
		tween={"fadein", 1/8},
	},
	{"text", [[El tablero marcó las 20:50 cuando me bajé. ]], false, true},

	{"bg", "mod", tween={"fadeout", 1/12, true}},
	{"text", [[Entré a la recepción pero no había nadie. Siempre lo mismo.
No había nadie en ningún lado, y si encontraba gente estaban delirando o
inconscientes.]], true},

	[[Estaba cansado de no poder entender que mierda ocurría, me dolía la
cabeza cada vez que trataba recordar. Salté el mostrador para tomar unas llaves
y fuí hasta una habitación, dejándome caer sobre la cama blanca.]],

	[[Estaba todo tan callado, pacífico. Las sábanas olían aún a
detergente y tenía un techo sobre la cabeza. Todo esto era impagable.]],

	[[Abrí los ojos y me ví reflejado en un espejo. No se me ocurrió
pensar porque había un espejo en el techo, solo me fijé que estaba herido por
todos lados. Parecía un boxeador que ya debería salir del ring.]],

	[[Pensé de nuevo en mi chica. Veía su cara aún como si la tuviera
frente a mi. Sé que la conocía hace mucho, pero por mas que me esforzaba no
podía darle nombre, y no podía ver nada previo a aquél momento. No sabía ni que
clase de vida llevaba.]],

	[[Notando el control remoto sobre la mesa, hice un último esfuerzo y
encendí la televisión, aunque fuera para ver porno.]],

	{"sfx", "sfx/crt on.flac"},
	[[Sonó el golpe eléctrico que hacían las teles antiguas, y poco a poco
la pantalla cobró brillo.]],

	[[No hubo necesidad de cambiar de canal, las noticias ya estaban en
curso...]],
}
