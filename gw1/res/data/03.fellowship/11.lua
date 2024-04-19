return {
	{"style", "vnMaria"},
	res.fun.macro.title,

	{"bgm", "set", "rev", 0,
		source="freesound/181460__erik90__car-rev.loop.flac",
		setup={setPitch=1/2},
		fade={"fadein", 6/3}},
	{"name", "María"},
	[[Falcon a pesar de su pie parecía conducir sin problemas.]],

	[[Lo que es más, para estar con las calles tapadas de nieve, controlaba
el auto con total precisión. Apenas y parecía mover el volante. Me incliné
hacia el frente para hablarle.]],

	{"select", nil, {
		[["¿Eras conductor o algo?"]],
		[["¿Sabes derrapar?"]],}},
	{"case", nil, {
		{
			{"name", "Falcon"},
			[["¿Conductor? Hmm," se limitó a decir.]],

			{"name", "María"},
			[["¿No te acuerdas?" Falcon no respondió nada. "¿De
			verdad no te acuerdas de nada?"]],

			[[Falcon dejó la pregunta en el aire, y me recliné de
			vuelta en el asiento. No lograba imaginar lo que sentía
			tener amnesia; a lo mejor no debería preguntar.]],

			{"name", "Bake"},
			[["Vos algo que ver con los autos debes haber hecho. No
			cualquiera se desliza lo justo para una curva con esta
			nieve," dijo Bake. Falcon inclinó la cabeza a un
			lado.]],

			{"name", "Falcon"},
			[["La verdad... es que lo aprendí de ocioso
			en estos días. Ya perdí la cuenta de cuantas veces
			choqué el auto."]],

			{"name", "María"},
			[["A-Ah."]],

			{"name", "Bake"},
			[["Eso explica las abolladuras xD"]],

			{"name", "María"},
			{"text", [[Llegamos]], false, true},
		},
		{
			{"name", "Falcon"},
			[["¿Derrapar?" dijo con una sonrisa dibujándose en su
			rostro. "Claro. Afirmate."]],

			{"bgm", "mod", "rev",
				fade={"delay", 1, "bend", 1, 1}},
			[[Falcon pasó cambios y le metió el pie al acelerador.
			Cuando nos íbamos acercando a una curva giró el volante
			rápido.]],

			{"bgm", "set", "squeal1", 0,
				source="freesound/71739__audible-edge__chrysler-lhs-tire-squeal-04.16.flac",
				setup={seek=5},
				fade={"fadeto", .75, .25, "delay", 1.75,
					"fadeout", .5, "cmd", {play=false}}},
--			{"sfx", "freesound/676613__fivebrosstopmosyt__table-smash-1.flac",
--				.25, 1/3, 2},
			{"name", "Bake"},
			{"text", [["HOLY SH--"]], false, true},

			{"name", "María"},
			{"sfx", "freesound/634778__5plus5equalspatata__metal-crash.mp3",
				1/6, 4/3, 2},
			{"bgm", "mod", "rev",
				fade={"delay", 2.1, "bend", 4/3, 1}},
			[[El auto pasó de largo la curva hasta que las
			ruedas chocaron con la cuneta de enfrente. El auto dió
			un salto y en el aire vi el piso de la vereda
			acercándose por mi ventana. Grité.]],

			{"bgm", "mod", "rev",
				fade={"delay", 1.1, "cmd", {setPitch=1}}},
			{"bgm", "mod", "squeal1",
				fade={"delay", 1, "cmd", {play=true, seek=1, setPitch=1.2},
					"fadeto", 1/2, 1/9}},
			{"sfx", "freesound/634778__5plus5equalspatata__metal-crash.mp3",
				1/3, 1, 1},
			[[Cuando estaba a solo centímetros las ruedas tocaron
			el suelo y el auto saltó hacia el otro lado.]],

			{"bgm", "mod", "rev",
				fade={"bend", 3/4, 15}},
			[[Nos deslizamos por la calle en dirección a un árbol
			mientras Falcon movía como loco el volante y Bake ponía
			y sacaba el freno de manos.]],

			{"bgm", "mod", "squeal1",
				fade={"bend", 3/4, 1/9, "fadeout", 1/9, true}},
			{"bgm", "set", "squeal2", 0,
				source="freesound/71738__audible-edge__chrysler-lhs-tire-squeal-03.cut.flac",
				fade={"fadein", 1, "fadeout", 6, true}},
			[[De alguna forma lo esquivamos, y nos fuimos con el
			auto dando coletazos por la calle.]],

			{"name", "Falcon"},
			[["Q-Quería hacer eso."]],

			{"name", "María"},
			{"text", [[Llegamos (vivos)]], false, true},
		}
	}},
	{"bgm", "mod", "rev", fade={"fadeout", 1, true}},

	{"bg", "conf", "default", color=res.palette("fivepm")},
	{"bg", "add", args={"maria/living.png"}, fade={"fadein", 2}},
	{"name", "María"},
	{"text", [[ a la casa cerca de las seis, cuando ya empezaba a oscurecer
y la nieve comenzaba a tapar la vista. Entramos Falcon y yo cargando
la comida, y el dejó un segundo las bolsas para estirar los brazos al techo.]],
	true},

	{"bg", "add", args={"zeh/falcon-ja.png", 150}, fade={"fadein", 1/12}},
	{"name", "Falcon"},
	[["Dios, que agradable," dijo extasiado. "Había dormido todos estos
días en el auto." Bake entró sin nada y se tiró como tabla en el sillón.]],

	{"name", "Bake"},
	[["Tenés razón," dijo recostado boca abajo. Llevé a Falcon a la
cocina para guardar la comida.]],

	{"macro", "rFade", "maria/cocina.png", false, 1},
	{"bg", "mod", fade={"fadeout", 1}},
	[["¿Sabés que nos hizo falta? Unas chelas," comentó Bake desde el
living. Falcon contuvo una risa, aunque a mi no me hizo gracia.]],

	{"name", "María"},
	[["Bake, hay que sacar los cuerpos," le dije enojada.]],

	{"name", "Bake"},
	[["Mierda xD"]],

	{"bg", "mod", args={"zeh/falcon.png", 50}, fade={"fadein", 1/12}},
	{"name", "Falcon"},
	[["¿Eh? ¿Cuerpos?"]],

	{"name", "María"},
	[["Si. Unos zombies nos atacaron en la mañana y quedaron ahí
afuera," dije apuntando a la ventana porque no quería verlos de nuevo.
"Bake no me quiere ayudar a sacarlos."]],

	{"name", "Falcon"},
	{"text", [["Ahh."]], false, true},

	{"bg", "mod", fade={"fadeout", 1}},
	{"text", [[ Falcon fue a echar un ojo mientras yo guardaba la comida.]],
true},

	[["Aquí no hay nada," dijo.]],

	{"bg", "add", 2, args={"maria/patio.png"}, fade={"fadein", 1/3}},
	[[Pensé que quizás era la nieve que los había cubrido. Me asomé a
mirar, y luego abrí la puerta. De verdad no estaban.]],

	{"name", "María"},
	[["S-Se suponía que estaban muertos." ¿Donde se habían ido? ¿Que había
pasado?]],

	{"name", "Bake"},
	[["Mi espalda dice gracias xD," dijo Bake llegando a apoyarse en la
puerta, sin campera. "Debe ser que se los llegó a comer otro porque yo los dejé
bien muertos."]],

	{"name", "Falcon"},
	[["Que yo sepa no son caníbales, pero quién sabe."]],

	{"bg", "add", args={"zeh/bake.png", 640, 0, 0, -1, 1}, fade={"fadein", 1/2}},
	{"bg", "mod", 3, fade={"mvabs", 50, 0, 0, "fadein", 1/2}},
	{"bg", "mod", 2, fade={"fadeout", 1/2, true}},
	{"name", "María"},
	[[El viento sopló fuerte de nuevo así que nos metimos de nuevo a la
casa. Le puse el seguro a la puerta.]],

	{"name", "Falcon"},
	[["No te preocupes en todo caso, mejor que estén lejos," dijo tratando
de calmarme.]],

	[["¿Les molesta si le doy una vuelta a la casa?"]],

	{"name", "Bake"},
	[["Dale. Yo tengo hambre así que voy a preparar algo."]],

	{"bg", "sync"},
	{"bg", "mod", 2, fade={"fadeout", 1}},
	{"name", "María"},
	[[Falcon nos dejó solos, y yo intenté quedarme tranquila con sus
palabras. Por mas que me dijeran esas cosas, esa extraña incomodidad en el
pecho no desaparecía.]],

	[[Empecé a charlar un poco con Bake para quitarme eso de la mente.
Aunque fuera loco, escucharlo hablar me ayudaba.]],

	{"bg", "mod", 1, 3, color=res.palette("sixpm"), shader=res.shader.purkinje},
	{"bg", "mod", 2, fade={"fadeout", 0, "mvdiff", -50, 0, 0}},
	{"bg", "mod", 3, fade={"mvabs", 600, 0, 1/60}},
	{"bg", "add", draw=f0b.draw.screenFill, color={0,0,0,1},
		fade={"fadeout", 1, true}},
	[[Afuera la nieve se apilaba, y el sol se ponía lentamente. Bake me
contaba de la vez que a Pipi la atropellaron pero que logró salir adelante.]],

	{"bg", "mod", 2, fade={"fadein", 2}},
	[[Falcon regresó casi una sombra, haciendo que me sobresaltara. Bake se
rió, y recién ahí sacó su linterna.]],

	[[Falcon dijo que le preocupaba no tener protección en las ventanas.
Según el, había visto unos zombies metiéndose a una casa así, e iba a ser muy
dificil defender tantas entradas ante cualquier problema.]],

	{"name", "Bake"},
	[["Hmm, en la bodega hay unas tablas. Podés clavarlas si querés."]],

	{"name", "María"},
	[["¿No vas a ayudar?"]],

	{"name", "Bake"},
	{"text", [["Quisiera, pero caminar dos horas no le hizo bien a mi
espalda xD]], false, true},

	{"bg", "mod", args={"zeh/bake-xd.png", 640, 0, 0, -1, 1}},
	{"text", [[ Me duele xDD"]], true},

	{"bg", "mod", args={"zeh/bake.png", 600, 0, 0, -1, 1}},
	{"name", "María"},
	[["Yo te ayudo entonces," me ofrecí.]],

	{"bg", "mod", 2, 3, fade={"fadeout", 1/3}},
	[[Le quitamos la linterna a Bake y lo dejamos cocinando solo con la
llama del gas, y entramos todas las tablas y herramientas.]],

	{"macro", "rFade", "maria/living.png", false, 1},
	{"bg", "conf", "default", color=res.palette("flashlight"),
		shader=res.shader.contrast},
	{"bg", "mod", 2, 3, color=res.palette("flashlight"),
		shader=res.shader.contrast},
	{"bg", "mod", 3, fade={"fadeout", 0}},
	{"bg", "rm"},
	[[Yo sostenía mientras el clavaba. Me sentía un poco mal haciéndole
esto a la casa de Bake, pero peor sería dormir tras lo que dijo Falcon.]],

	{"bg", "mod", fade={"mvabs", 150, 0, 1/60, "fadein", 1/3}},
	[["¿Crees que vayan a volver a la noche?" le pregunté tras un rato.]],

	{"name", "Falcon"},
	[["¿Ah?"]],

	{"name", "María"},
	[["Esas... Los zombies."]],

	{"name", "Falcon"},
	[["Eeh, no creo, no son tan listos. Solo deambulan."]],

	{"name", "María"},
	[["¿Y no te dan miedo?"]],

	{"name", "Falcon"},
	{"text", [[]], false, true},
	{"wait", 1/12, false, true},
	[["Algo," dijo levantando los hombros, aunque lo noté algo incómodo.]],

	[["Mientras no nos tomen por sorpresa no nos va a pasar nada. Es cosa
de estar atentos."]],

	{"name", "María"},
	[["Uhm..." Me quedé mirando a Falcon un poco mientras trabajabamos, y
me quedé pensando en sus palabras. 'Estar atentos'.]],

	[[Yo andaba demasiado alerta. Ojalá sirva de algo.]],

	{"bg", "mod", fade={"fadeout", 1, true}},
	[[Tras nuestro arreglo la casa quedó aún mas oscura, así que
con Falcon acordamos buscar velas y baterías para la próxima salida.]],

	{"macro", "rFade", res.fun.complex.comedor(true,
		res.fun.complex.linterna), {1, 3/4, 2/3, 0}, 1},
	[[Acabado el trabajo, nos sentamos a comer un estofado con lo único
medianamente saludable que trajimos.]],

	[[Voy a admitir que luego de lo de la pizza en lata no tenía fe que
Bake fuera bueno en esto...]],

	[[Pero no sé si fueron todos los días comiendo galletas o que, pero
la primera cucharada casi me hizo llorar. Estaba tan exquisito, era incluso
mejor que lo que comía en casa.]],

	[[Antes de darme cuenta me lo había tragado todo. Bake me miraba
atento.]],

	[["Te quedó muy bueno," concluí.]],

	{"name", "Bake"},
	[["lol, se notó," dijo sonriendo. "¿Mate? ¿Café?"]],

	{"name", "María"},
	[["Yo quiero un mate."]],

	{"name", "Falcon"},
	[["Eeh, mate también."]],

	{"name", "María"},
	[[Bake fue a la cocina y se trajo todo en un solo viaje, incluyendo
un termo con agua caliente que había hervido de antes. Bake me pasó la yerba y
empecé a servirme de inmediato. Falcon nos quedó mirando.]],

	{"name", "Falcon"},
	[["Pregunta, ¿ustedes son novios?" preguntó de pronto. Ambos lo
miramos.]],

	{"name", "María"},
	[[Bake empezó a reir con la pregunta tan repentina, y yo hice lo mismo,
no más que de paso errándole con el agua al mate.]],

	{"name", "Bake"},
	[["lol, no, nos conocimos esta mañana. La salvé de la Sombra," rió.]],

	{"name", "María"},
	[["¿De la que?" Bake solo sonrió misteriosamente. "¿Como que una
Sombra?"]],

	{"name", "Bake"},
	[["Solo algo random que ví. No era nada."]],

	{"name", "María"},
	[["¿Como que nada? Había algo persiguiéndome en la mañana. ¿Era eso?"]],

	{"name", "Bake"},
	[["Nena, cuando te encontré estabas en el suelo. Si no sabés que te
pasó, yo menos xD"]],

	{"name", "María"},
	[["¿Y entonces que viste?"]],

	{"name", "Bake"},
	[["Ví como de reojo un manchón alejándose de donde estabas, eso es
todo."]],

	{"name", "María"},
	[["¿Un manchón como que? ¿Como un zombie?"]],

	{"name", "Bake"},
	[["Como un manchón."]],

	{"name", "María"},
	[["¡Bake!"]],

	{"name", "Bake"},
	[["No sé, fue como una fracción de segundo. No me pidas mas detalles
porque no sé Xd"]],

	{"name", "María"},
	[[Me quedé mirándolo, como tratando de ver si decía la verdad,
mientras Falcon nos observaba en silencio con las cejas levantadas. O bueno,
lo estuvo hasta que probó el mate.]],

	{"name", "Falcon"},
	[["Ew," dijo arrugando la cara. "Es amargo."]],

	{"name", "Bake"},
	[["¿Nunca habias tomado?"]],

	{"name", "Falcon"},
	[["Intuia que no pero pensé que era por la amnesia," dijo agarrando
el azucarero.]],

	{"name", "Bake"},
	[["Vos fumaste de la mala parece."]],

	{"name", "Falcon"},
	[["No bromees, que ya estoy que te creo." Falcon rebalsó su mate con
azúcar.]],

	{"name", "María"},
	[[Tenía la impresión de que Bake decía la verdad con lo de la Sombra,
así que decidí olvidarme del tema. Daba lo mismo a estas alturas. En serio.]],

	[[Nos quedamos charlando un rato ahora que podíamos hablar con calma.
Falcon nos contó, como el mismo la llamó, la completa historia de su vida, que
se limitaba a los últimos tres días desde la explosión.]],

	[[No era mucho, pero me llamó la atención lo de la chica. Entendía
ahora porque Falcon no había abandonado la ciudad a pesar de tener un auto.
Ojalá la hubiera buscado mas.]],

	[[Hablando de autos, me pareció curioso como al segundo día, ayer, ya
no había nadie.]],

	[[Le pregunté si sabía de alguna evacuación y me dijo que no, pero que
como todas las estaciones habían dejado de transmitir el primer día, había
dejado de usar la radio del auto.]],

	[[Tambien habló de que se veían helicópteros de vez en cuando, aunque
no sabía donde iban ni que hacían. Sugerí que a lo mejor eran del rescate, pero
Falcon dijo que no aterrizaban en la ciudad.]],

	[[Reconocimiento, dijo Bake, pero ninguno le encontró mucho sentido.
¿Cuantos días de reconocimiento podía necesitar la propia capital?]],

	[[Por donde se le mirara nada parecía tener sentido.]],

	[[En fin, conversamos hasta que el reloj de Falcon sonó a las 9. El
cansancio se nos notaba a todos, aunque a el especialmente.]],

	[[Bake quiso tocar la guitarra pero lo detuvimos, y como ya era
prácticamente de noche y el ambiente se enfriaba por segundo, decidimos que era
mejor irnos a dormir. Fuimos hasta la escalera.]],

	{"macro", "rFade", "maria/living.png"},
	{"bg", "add", args={"zeh/bake.png", 20}, fade={"fadein", 1}},
	{"bg", "add", args={"zeh/falcon.png", 600, 0, 0, -1, 1}, fade={"fadein", 1}},
	{"name", "Falcon"},
	[["¿Donde dormiremos?"]],

	{"name", "Bake"},
	[["Hay tres camas. Una la está ocupando Pipi. Solo queda la mía y la de
mis padres que es doble."]],

	{"name", "Falcon"},
	[["No dormiré contigo."]],

	{"bg", "sync"},
	{"bg", "mod", 2, args={"zeh/bake-xd.png"}},
	{"name", "Bake"},
	[["Yo tampoco. No somos gays xD"]],

	{"bg", "mod", 2, args={"zeh/bake.png", 20}},
	{"name", "Falcon"},
	[["María duerme contigo en la doble entonces, a menos que quieras
dormir solo por la espalda."]],

	{"name", "Bake"},
	[["No importa si duermo solo o si no. Si ella quiere dormir conmigo que
se meta en la cama de alguna manera mientras duermo. Y si duermo solo no
importa, cualquier cosa estamos cerca."]],

	{"name", "Falcon"},
	[["Si, dormimos con la oreja parada. Yo estoy muerto así que buenas
noches."]],

	{"name", "Bake"},
	[["Buenas noches."]],

	{"bg", "mod", 2, 3, fade={"fadeout", 1/3, true}},
	{"name", "María"},
	[[Ambos subieron y se fueron a dormir, dejándome sola a los pies de la
escalera con la linterna en la mano.]],

	[[En cinco segundos se habían repartido las camas, y poco mas y
decidían con quién dormía sin siquiera preguntarme. Ya se habían esfumado para
cuando se me ocurrió reclamar. Patée el suelo.]],

	[[¿Por que los hombres siempre tenían que creerse tan machos? ¿Que
tenía que durmieran juntos? En la escuela era igual, no se podían ni pasar a
tocar entre ellos.]],
}
