local laComida = {
	{"name", "María"},
	[["¿Ya no te queda comida?"]],

	{"name", "Bake"},
	[["¿No te gustó la pizza?" preguntó preocupado.]],

	{"name", "María"},
	[["No, no es eso. Es que como ví que tuviste que buscar mucho..."]],

	{"name", "Bake"},
	[["Ah, si xD Salí a buscar con Pipi en la mañana, pero me encontré con
un ángel en un callejón y no pude seguir," dijo antes de hecharse otro pedazo a
la boca.]],

	{"name", "María"},
	[[Yo demoré un segundo en procesar lo que dijo.]],

	[["E-Ehh, estaba escapando--"]],

	{"name", "Bake"},
	[["Hey, ¿me acompañás luego a buscar?" me interrumpió. "Hay una zona
comercial a media hora de acá. Ahí debería haber comida," explicó. Asentí.
"Sweet."]],

	{"name", "María"},
	[[Me quedé en silencio, pensando en lo del callejón. Estuve huyendo de
algo, pero... ¿de que?]],

	[[Pensando con detención, no recordaba haber visto ninguna criatura. No
solo eso, había mirado a todos lados en medio de una calle despejada, y no
había visto nada.]],

	[[No quería reconocerlo, pero parecía que había entrado en pánico por
un ruido cualquiera, y para variar terminé subiéndome a--]],

	{"name", "Bake"},
	[["¿No te vas a comer la piña?" preguntó Bake, despavilándome. Señalaba
una rodaja que había apartado de mi trozo.]],

	{"name", "María"},
	[["No, no, dale." Dejé de darle vueltas al asunto y me enfoqué en
comer antes que Bake se lo tragara todo. Al fin y al cabo, todo eso ya estaba
en el pasado.]],
}

local laGente = {
	{"name", "María"},
	[["¿No sabes que pasó con toda la gente?"]],

	{"name", "Bake"},
	[["Hmm, ¿aparte que se convirtieron?"]],

	{"name", "María"},
	[["No, quiero decir... ¿No sabes si hubo una evacuación?"]],

	{"name", "Bake"},
	[["¿La hubo?" me preguntó sorprendido.]],

	{"name", "María"},
	[["Tuvo que haberla, ¿no? Por que si no, ¿a donde se fueron todos?"
razoné. El chico inclinó la cabeza a un lado.]],

	{"name", "Bake"},
	[["Ahora que lo decís, sos la primera persona que veo," dijo pensando.
"No me había fijado. Yo teniendo mi arma y comida no me preocupaba, lol"]],

	{"name", "María"},
	[[Me quedé sin saber como contestar. Este chico jamás iba a morir de
estrés. El chico habló de nuevo.]],

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
	[[A pesar de la interrogante, el chico siguió comiendo despreocupado.]],

	[[A lo mejor yo me estaba revolviendo demasiado la cabeza con todo
esto, y pronto se arreglaría todo. Me limité a comer de la pizza y mirar por la
ventana. El aire siguió agarrando fuerza.]],

	[['Los únicos humanos en esta ciudad.' Eso sonaba claustrofóbico,
aunque tambien... romántico.]],

	[[Quiero decir, no es que me guste el chico, pero... la idea en si daba
esa sensación. Yo solo digo.]],
}

local losAmigos = {
	{"name", "María"},
	[["¿No tenías amigos?"]],

	{"name", "Bake"},
	[["¿Amigos? Obvio xD"]],

	{"name", "María"},
	[["¿Como están?"]],

	{"name", "Bake"},
	[["No sé, lol xDD"]],

	{"name", "María"},
	[["¿Q-Que?"]],

	{"name", "Bake"},
	[["Si no hay señal para llamarlos. Desde la explosión que no los veo."]],

	{"name", "María"},
	[[El chico me empezó a contar sobre que vieron acá la noticia de los
mutados. Que antes de esto estuvieron en una cafetería cuando ocurrió la
explosión, y que luego un auto entró y arrolló justo a 'la chica buena.']],

	[[Yo no sabía que responder, pero el chico me aseguró que se la
llevaron rápido a un hospital donde la pondrían en una cámara de hipersueño,
donde seguro dormiría plácidamente todo el apocalípsis, 'lol']],

	[[La cosa es que se quedaron hasta que se cortó la luz, y ahí se
despidieron y se fue cada uno para su casa. El chico se quedó solo con Pipi y
el arma de su viejo, y aquí ha estado desde entonces.]],

	[[Le pregunté si no estaba preocupado, pero me aseguró que todos se
habían duchado bien al llegar, y que si el había sobrevivido hasta ahora con
facilidad, seguramente ellos tambíen.]],

	[[De hecho, parecía mas preocupado por haber agarrado al conductor del
auto a palos. Dijo que en retrospectiva, debió ser uno de los primeros en
infectarse.]],

	[[Tenía mis dudas sobre si al chico no le fallaba algo mas que solo el
termostato, pero mala persona no parecía ser, al menos.]],
}

local infoLoop = {
	{"select", nil, {
		[[Sobre la comida...]],
		[[Sobre la gente...]],
		[[Sobre sus amigos...]],
		[[Tragarse la pizza entera.]],
	}},
	{"case", nil, {
		laComida,
		laGente,
		losAmigos,
		{
			{"name", "María"},
			[[Habíamos pasado mucho tiempo comiendo, así que agarré
			toda la pizza.]],

			[["*OM OM*" El chico se detuvo a verme.]],

			{"name", "Bake"},
			[["lol xD"]],

			{"break"}
		},
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
en esta ciudad contaminada.]], true},

	[[Tenía 19 años, cumplidos hace solo unos días, pero a diferencia mía,
el no parecía muy afectado por lo que estuviera ocurriendo allá afuera.]],

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
de viaje a otro país.]],

	[[No se notaba preocupado por ellos, argumentando que el humo no
llegaría tan lejos. Su único compañero ahora era Pipi, su perro. O perra, mas
bien.]],

	[[No entendía todas las cosas que decía o hacía el chico, a lo mejor
era la cultura del extremo sur o que se yo, pero casi envidiaba su calma en
esta situación... Escucharlo hablar era como oír una voz de un mundo en que no
todo estaba perdido.]],

	[[Por otro lado, el ruido que metía con la guitarra me traía con los
nervios de punta.]],

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
nevar de nuevo, con los dos cuerpos lentamente cubriéndose de un blanco
sucio.]],

	[[La casa crugía. Las manchas de sangre en el patio se escondían de a
poco, y tuve una sensación extraña en el pecho. Una inquietud de que algo no
concordaba.]],

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
	[[Bake se fue al comedor con la lata y me llamó para que comieramos.]],

	[[Vació la pizza minúscula en un plato, le hechó unas gotitas de agua,
y esta se expandió en segundos. Radiaba calor y un exquisito olor a pizza de
jamón y piña llenó el ambiente.]],

	{"name", "Bake"},
	[["Provecho, lol"]],

	{"bgm", "set", source="chill.ogg"},
	{"name", "María"},
	[[Como en un bizarro oasis de paz dentro de la ciudad, con un amigable
extraño que parecía indiferente al mundo exterior y a las normas usuales de
vestimenta, comenzamos a comer una comida común y corriente.]],

	[[Simplemente no sabía que decir sobre todo esto.]],

	[["Ehh... Dime, Bake..."]],

	{"name", "Bake"},
	[["?"]],

	{"read", infoLoop, true},
	{"bgm", "mod", fade={"fadeout", 2, true}},

	{"name", "María"},
	[[Con eso terminamos de almorzar.]],
}
