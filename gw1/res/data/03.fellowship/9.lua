local sobreLaGente = {
	[["Dime, Bake..."]],

	{"name", "Bake"},
	[["?"]],

	{"name", "María"},
	[["¿No sabes que pasó con todos?"]],

	{"name", "Bake"},
	[["¿Aparte que se convirtieron?"]],

	{"name", "María"},
	[["No, quiero decir... ¿No sabes si hubo una evacuación?"]],

	{"name", "Bake"},
	[["¿La hubo?" me preguntó sorprendido.]],

	{"name", "María"},
	[["Tuvo que haberla, ¿no? Por que si no, ¿a donde se fueron todos?"
le expliqué. El chico inclinó la cabeza a un lado.]],

	{"name", "Bake"},
	[["Ahora que lo decís, sos la primera persona que veo," dijo pensando.
"No me había fijado. Yo teniendo mi arma y comida no me preocupaba, lol"]],

	{"name", "María"},
	[[Me quedé en silencio sin saber que contestar, y el chico habló de
nuevo.]],

	{"name", "Bake"},
	[["Igual todas las estaciones y antenas dejaron de funcionar a pocas
horas de la explosión. No sé como se habrían enterado de una evacuación."]],

	{"name", "María"},
	[["¿No escuchaste que viniera la policía o algo?" Quién pregunta, en
todo caso.]],

	{"name", "Bake"},
	[["Tampoco, y eso que salí varias veces a pasear a Pipi." El chico
pensó brevemente la situación mientras comía la pizza. "A lo mejor se volvieron
todos zombies, y somos los únicos humanos."]],

	{"name", "María"},
	[["Zombies..." Bake lo decía como si nada. Esa fue la primera palabra
que se me vino a la mente cuando empezó todo, pero creo ni siquiera los
periodistas se atrevian a usarla, era muy de película... Bueno, supongo que da
lo mismo ahora.]],

	[["Pero las calles estarían repletas de esas cosas si fuera así..."]],

	{"name", "Bake"},
	[["Uhmm," pensó de nuevo. "Bueno, no sé, lol."]],

	{"name", "María"},
	[[A pesar de la interrogante, el chico siguió comiendo despreocupado. A
lo mejor yo me estaba revolviendo demasiado la cabeza con todo esto, y pronto
alguien arreglaría todo. Me limité a comer de la pizza y mirar por la ventana.
El aire siguió agarrando fuerza.]],

	[['Los únicos humanos en esta ciudad.' Eso sonaba claustrofóbico,
aunque tambien... romántico.]],

	[[Quiero decir, no es que me guste el chico, pero... la idea en si daba
esa sensación. Yo solo digo.]],

	{"break"},
}

local infoLoop = {
	{"name", "María"},
	[["Uhm..."]],

	{"select", nil, {
		[["Hola."]],
		[["Sé mi novio."]],
		[["Sobre la gente..."]],
	}},
	{"case", nil, {
		{
			[["Hola," le dije al chico. El esperó a tragar lo que
			tenía en la boca.]],
			{"name", "Bake"},
			[["No me vuelvas a hablar."]],
			{"name", "María"},
			[[El chico se retiró con su plato y no volvió a
			dirigirme la palabra el tiempo que estuve en su casa.
			A los cuatro días, sucumbí a la profunda pena y morí.
			El chico tiró mi cuerpo a la calle y me devoraron.]],
			[[...O eso es lo que pensé que pasaría. Preferí no
			arriesgarme.]],
		},
		{
			[["¿Q-Quieres ser mi novio? Hago de todo."]],
			{"name", "Bake"},
			[["Bueno, lol"]],
			{"name"},
			[[¡SUBISTE UN NIVEL!]],
			[[Estado: Novia (pero sin beneficios)]],

			{"wait", 1},
			[[«El tiempo retrocede, y el lazo que los unió queda
			sin efecto. No puedes ser su novia aún.»]],
		},
		sobreLaGente,
	}},
}

return {
	{"name", "María"},
	{"style", "vnMaria"},
	res.fun.macro.title,

	{"text", [[El chico de nombre Bakeritsu, o]], false, true},

	{"bg", "add", args=res.fun.card.card(
		"dejaVuSans", res.style.vnMaria.fontSize * 4,
			" /beɪk/ ")},
	{"speed", 1/3},
	{"text", [[ /beɪk/ ]], true, true},
	{"speed", 1},
	{"bg", "rm"},

	{"text", [[como el prefiere, era otro sobreviviente, olvidado también
en esta ciudad contaminada. Tenía 19 años, cumplidos hace solo unos días, pero
a diferencia mía, el no parecía muy afectado por lo que estuviera ocurriendo
allá afuera.]], true},

	[[De hecho, se lo tomaba todo bien a la ligera.]],

	{"name", "Bake"},
	[["WIIIAA", dijo luego de echarse desodorante, que podría o no también
contener alcohol.]],

	{"name", "María"},
	[["¿Eh?"]],

	{"name", "Bake"},
	[["Imitando a mi guitarra xD" El chico, considerando que ponerse ropa
de abrigo encima no era tan esencial en este clima, se puso a tocar a lo
'Cabeza de Cubeta' mientras salía del baño al pasillo.]],

	{"name", "María"},
	[[El chico vivía en esta casa con sus padres, que justo habían salido
de viaje a otro país. No se notaba preocupado por ellos, argumentando que el
humo no llegaría tan lejos. Su único compañero ahora era Pipi, su perro. O
perra, mas bien.]],

	[[De sus amigos, dijo que no los había visto desde el día del incidente
pero que seguro estaban bien, que solo "la chica buena" a lo mejor aún seguía
grave, pero que estando en una cámara de hipersueño dormiría plácidamente todo
el apocalípsis, "lol".]],

	[[No entendía todas las cosas que decía o hacía el chico, a lo mejor
era la cultura del extremo sur o que se yo, pero casi envidiaba su calma en
esta situación... Escucharlo hablar era como oír una voz de un mundo en que no
todo estaba perdido.]],

	[[Por otro lado, el ruido que metía con la guitarra me
traía con los nervios de punta.]],

	[[Y no lo digo por como tocaba, de hecho lo hace bastante bien, si no
por que podía atraer mas de esas criaturas, pero el chico insistía en que no
pasaba nada.]],

	{"name", "Bake"},
	[["Bue, me dolió el tendón," dijo cuando se cansó de tocar, con el
primer tinte de inquietud que había oído en su voz, y dejó la guitarra a un
lado. "¿Querés comer algo? Tengo Pizza Enlatada."]],

	{"name", "María"},
	[["¿Las que les pones agua y se agrandan?"]],

	{"name", "Bake"},
	[["Si, son re-flasheras," dijo volviendo a sonreír.]],

	{"name", "María"},
	[[El chico y yo bajamos a la cocina, el sin molestarse en ponerse
nada encima de la camisa o de los boxers. Tras dos minutos hurgueteando entre
las despensas y muebles dió con una lata enpolvada.]],

	{"name", "Bake"},
	[["'Consumir antes del 2007.' Si está enlatada, no se debería hechar a
perder, ¿verdad?" dijo antes de enterrarle un abrelatas.]],

	{"name", "María"},
	[[Noté que afuera el viento agarraba fuerza y que habia empezado a
nevar de nuevo, con los dos cuerpos lentamente cubriendose de un blanco sucio.
La casa crugía. Las manchas de sangre en el patio se escondían de a poco, y
tuve una sensación extraña en el pecho. Una inquietud de que algo no concordaba.]],

	[[Sin saber que hacer, me limité a verificar que la puerta siguiera con
seguro.]],

	{"name", "María"},
	[["Disculpa... ¿No vamos a sacar los cuerpos?" Bake estaba concentrado
en la lata.]],

	{"name", "Bake"},
	[["¿Que querés que haga que?"]],

	{"name", "María"},
	[["Deberiamos sacar los cuerpos... Me incomoda que estén aquí. ¿A ti
no?" Bake se acercó un poco para ver.]],

	{"name", "Bake"},
	[["Bueno, ahora que lo decís si están bien feos, pero con este viento
no dan ganas de estar afuera. Esperá que calme y me ocupo."]],

	{"name", "María"},
	[[Bake se fue al comedor con la lata y me llamó para que comieramos.
Vació la pizza minúscula en un plato, le hechó unas gotitas de agua, y esta se
expandió en segundos. Radiaba calor y un exquisito olor a pizza de jamón y piña
llenó el ambiente.]],

	{"name", "Bake"},
	[["Provecho, lol"]],

	{"name", "María"},
	[[Como en un bizarro oasis de paz dentro de la ciudad, con un amigable
extraño que parecía indiferente al mundo exterior y a las normas usuales de
vestimenta, comenzamos a comer una comida común y corriente. No sabía que decir
sobre todo esto.]],

	{"bgm", "set", source="chill.ogg"},
	{"loop", infoLoop},
	{"bgm", "mod", fade={"fadeout", 2, true}},

	{"name", "María"},
	[[Tras eso, terminamos.]],
}
