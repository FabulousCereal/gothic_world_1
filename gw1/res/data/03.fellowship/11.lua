local recuerdos = {
	{"name", "María"},
	[["Si no es mucha la intromisión... ¿Como perdiste la memoria?" me
animé a preguntarle.]],

	[[Falcon al principio no pareció reaccionar, pero cuando acabó de
clavar, noté que su expresión había cambiado sutilmente.]],

	{"name", "Falcon"},
	[["Estaba con una chica al lado de la fábrica cuando explotó," me
dijo.]],

	{"name", "María"},
	[[Falcon me contó, en breve, lo que el llamaba toda la historia de su
vida. Sobre que había tomado un carro abandonado y había dado vueltas sin
rumbo desde entonces, como esperando reconocer algún lugar.]],

	[[Creo que lo que mas le dolía era que ni siquiera recordaba el nombre
de la chica.]],

	[[Solo recordaba su rostro y que ella "se reía" por algo, y que intuía
que eran novios aunque no sabía como.]],

	[["¿Tampoco recuerdas a tu familia?" Falcon se limitó a levantar los
hombros. No, era claro que no.]],

	{"name", "Falcon"},
	[["¿Que hay de la tuya?" me preguntó, y me limité a decir que estaba
lejos de acá.]],

	{"name", "María"},
	[[Tras un rato de silencio, nos pusimos a clavar de nuevo, mientras
trataba de imaginar como sería no poder recordar nada, pero sin éxito.]],

	[[Probablemente Falcon estaba a unos minutos en auto de su familia,
pero no sabía donde buscarla. En cambio yo... aquí estaba, lejos de todo.]],

	[[Para empeorar las cosas, estaba la duda inevitable de que si
recuperaba sus memorias, si encontraría a su familia viva.]],

	[[Quiero decir, la ciudad estaba casi desierta, y a menos que todos se
hayan ido sin que nos diéramos cuenta... el pronóstico no era bueno.]],

	[[No quise tocar ese tema, pero supuse que Falcon ya debía haberlo
considerado. No se notaba como alguien tan despreocupado como Bake.]],

	[[A veces sentía que aún no lograba dimensionar la magnitud de lo que
había ocurrido en esta ciudad.]],
}

local losZombies = {
	{"name", "María"},
	[["¿Crees que vayan a volver a la noche?"]],

	{"name", "Falcon"},
	[["¿Ah?"]],

	{"name", "María"},
	[["Esas... Los zombies."]],

	{"name", "Falcon"},
	[["Eeh, no, no creo. Dudo que tengan mucha memoria."]],

	{"name", "María"},
	[["Es que Bake dijo que sentían el CO2 de la gente." Falcon me miró
sorprendido.]],

	{"name", "Falcon"},
	[["¿De veras?"]],

	{"name", "María"},
	[["Eso dice el. No sé si será verdad."]],

	{"name", "Falcon"},
	[["Hmm, es posible. Yo tengo la teoría de que huelen la sangre, pero
también podría ser eso."]],

	{"name", "María"},
	[["¿Lo dices por tus heridas?"]],

	{"name", "Falcon"},
	[["Solo digamos que siempre sabían encontrarme cuando me bajaba del
auto xD"]],

	{"name", "María"},
	[[Tenía sentido, Falcon parecía haber pasado unos días duros. En
comparación, yo habia pasado todo en completa comodidad.]],

	[["Yo recién hoy ví un zombie por primera vez."]],

	{"name", "Falcon"},
	[["¿De veras? ¿Como los evitaste xD?"]],

	{"name", "María"},
	[["Me quedé encerrada en un cuarto de hotel desde la explosión."
Falcon inclinó un poco la cabeza.]],

	{"name", "Falcon"},
	[["¿Te quedaste encerrada por accidente?" Yo contuve una risa.]],

	{"name", "María"},
	[["¡No! Me encerré yo sola."]],

	{"name", "Falcon"},
	[["Ahh, ok XD ¿Pero y que comías?"]],

	{"name", "María"},
	[["Tenía unos sandwich y galletas, y cuando se me acabaron me comí lo
de la nevera del cuarto."]],

	{"name", "Falcon"},
	[["¿Y el aburrimiento?"]],

	{"name", "María"},
	[["Me ganó en la mañana," dije. Falcon rió.]],

	{"name", "Falcon"},
	[["Y yo que me sentía con claustrofobia por andar todo el día en el
auto. Andaba todo cómodo xD" Que cosas...]],

	{"name", "María"},
	[["¿Dijiste que dormías en el auto? ¿No intentaste buscar una casa?"]],

	{"name", "Falcon"},
	[["Es complicado saltar rejas con un esguince xd"]],

	{"name", "María"},
	[["Cierto, perdón." Que tonta. "Ehh, ¿pero esas heridas son por pelear
con zombies?"]],

	{"name", "Falcon"},
	[["Si... en parte," dijo medio suspirando. "Aunque en verdad, creo que
me he hecho mas heridas huyendo de ellos que enfrentándolos xD"]],

	{"name", "María"},
	[["¿Y no les tienes miedo?"]],

	{"name", "Falcon"},
	[["...Algo," dijo algo incómodo. "¿Por que? ¿Tu no?"]],

	{"name", "María"},
	[["Yo si. Ojalá no se den cuenta de que estamos aquí."]],

	{"name", "Falcon"},
	[["Bueno, igual no creo que nos puedan sentir respirar dentro de una
casa."]],

	{"name", "María"},
	[[Puesto de esa forma, si, podía sonar ridículo que fueran a volver...
¿pero entonces por que habían venido en la mañana?]],

	[[A juzgar por la reacción de Bake, debía ser la primera vez que
llegaban hasta acá. Quizás... era por mí.]],

	[[Pero no, ¿por que me seguirían a mí en especial? No tenía sentido.]],

	[[Falcon me miró, y debió notar que no estaba muy relajada.]],

	{"name", "Falcon"},
	[["Mientras no nos tomen por sorpresa no nos va a pasar nada. No
son sigilosos, y con estas tablas, créeme que nos daremos cuenta si tratan de
entrar. Es cosa de estar preparados."]],

	{"name", "María"},
	[["Uhm..." Retomamos el trabajo con Falcon, tratando de quedarme con
sus palabras. 'Estar preparados'.]],

	[[Yo andaba sobresaltada. Ojalá eso sirva de algo.]],
}

local laConversacion = {
	{"select", nil, {
		[[Sobre las criaturas.]],
		[[Preguntarle sobre su amnesia.]],
		[[Terminar.]],
	}},
	{"case", nil, {
		losZombies,
		recuerdos,
		{
			{"break"},
		},
	}},
}

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

			{"bgm", "fade", "rev", {"delay", 1, "bend", 1, 1}},
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
			{"bgm", "fade", "rev", {"delay", 2.1, "bend", 4/3, 1}},
			[[El auto pasó de largo la curva hasta que las
			ruedas chocaron con la cuneta de enfrente. El auto dió
			un salto y en el aire vi el piso de la vereda
			acercándose por mi ventana. Grité.]],

			{"bgm", "fade", "rev", {"delay", 1.1, "cmd", {setPitch=1}}},
			{"bgm", "fade", "squeal1",
				{"delay", 1, "cmd", {play=true, seek=1, setPitch=1.2},
					"fadeto", 1/2, 1/9}},
			{"sfx", "freesound/634778__5plus5equalspatata__metal-crash.mp3",
				1/3, 1, 1},
			[[Cuando estaba a solo centímetros las ruedas tocaron
			el suelo y el auto saltó hacia el otro lado.]],

			{"bgm", "fade", "rev", {"bend", 3/4, 15}},
			[[Nos deslizamos por la calle en dirección a un árbol
			mientras Falcon movía como loco el volante y Bake ponía
			y sacaba el freno de manos.]],

			{"bgm", "fade", "squeal1",
				{"bend", 3/4, 1/9, "fadeout", 1/9, true}},
			{"bgm", "set", "squeal2", 0,
				source="freesound/71738__audible-edge__chrysler-lhs-tire-squeal-03.cut.flac",
				fade={"fadein", 1, "fadeout", 5, true}},
			[[De alguna forma lo esquivamos, y nos fuimos con el
			auto dando coletazos por la calle.]],

			{"name", "Falcon"},
			[["Q-Quería hacer eso."]],

			{"name", "María"},
			{"text", [[Llegamos (vivos)]], false, true},
		}
	}},
	{"bgm", "fade", "rev", {"fadeout", 1, true}},

	{"bg", "mod", "root", color=res.palette("fivepm")},
	{"bg", "addsub", {
		{args={"maria/living.png"}, fade={"fadein", 2}},
	}},
	{"name", "María"},
	{"text", [[ a la casa cerca de las seis, cuando el sol ya se ponía
y la nieve comenzaba a tapar la vista. Entramos Falcon y yo cargando
la comida, y el dejó un segundo las bolsas para estirar los brazos al techo.]],
	true},

	{"bg", "addsub", {
		default={draw=f0b.doll.draw},
		{args={res.doll.falcon_ja, 210}, fade={"fadein", 1/12}},
	}},
	{"name", "Falcon"},
	[["Dios, que agradable," dijo extasiado. "Había dormido todos estos
días en el auto." Bake entró sin nada y se tiró como tabla en el sillón.]],

	{"name", "Bake"},
	[["Tenés razón," dijo recostado boca abajo. Llevé a Falcon a la
cocina para guardar la comida.]],

	{"macro", "bgFade", "maria/cocina.png"},
	{"bg", 2, "fade", {"fadeout", 1}},
	[["¿Sabés que nos hizo falta? Unas chelas," comentó Bake desde el
living. Falcon contuvo una risa, aunque a mi no me hizo gracia.]],

	{"name", "María"},
	[["Bake, hay que sacar los cuerpos," le dije enojada.]],

	{"name", "Bake"},
	[["Mierda xD"]],

	{"bg", 2, "fade", {"src", res.doll.falcon, "fadein", 1/12}},
	{"name", "Falcon"},
	[["¿Eh? ¿Cuerpos?"]],

	{"name", "María"},
	[["Si. Unos zombies nos atacaron en la mañana y quedaron ahí
afuera," dije apuntando a la ventana porque no quería verlos de nuevo.
"Bake no me quiere ayudar a sacarlos."]],

	{"name", "Falcon"},
	{"text", [["Ahh."]], false, true},

	{"bg", 2, "fade", {"fadeout", 1}},
	{"text", [[ Falcon fue a echar un ojo mientras yo guardaba la comida.]],
true},

	[["Aquí no hay nada," dijo.]],

	{"name", "María"},
	{"text", [[Pensé que quizás era la nieve que los había cubrido. ]],
		false, true},
	{"bg", 1, "add", args={"maria/patio.png"}, fade={"fadein", 1/3}},
	{"text", [[Me asomé a mirar, y luego abrí la puerta. De verdad no
		estaban.]], true},

	{"name", "María"},
	[["S-Se suponía que estaban muertos." ¿Donde se habían ido? ¿Que había
pasado?]],

	{"name", "Bake"},
	[["Mi espalda dice gracias xD," dijo Bake llegando a apoyarse en la
puerta, sin campera. "Debe ser que se los llegó a comer otro porque yo los dejé
bien muertos."]],

	{"name", "Falcon"},
	[["Que yo sepa no son caníbales, pero quién sabe."]],

	{"bg", 1, "fade", {"fadeout", 1/2, true}},
	{"bg", 2, "fade", {"mvabs", 160, false, 0, "fadein", 1/2}},
	{"bg", 2, "add",
		args={res.doll.bake, 480, 0, -1}, fade={"fadein", 1/2}},
	{"name", "María"},
	[[El viento sopló fuerte de nuevo así que nos metimos de nuevo a la
casa. Le puse el seguro a la puerta.]],

	{"name", "Falcon"},
	[["No te preocupes en todo caso, mejor que estén lejos," dijo tratando
de calmarme.]],

	[["¿Les molesta si le doy una vuelta a la casa?"]],

	{"name", "Bake"},
	[["Dale. Yo tengo hambre así que voy a preparar algo."]],

	{"bg", 2, "fade", 1, {"fadeout", 1}},
	{"name", "María"},
	[[Falcon nos dejó solos, y yo intenté quedarme tranquila con sus
palabras. Por mas que me dijeran esas cosas, esa extraña incomodidad en el
pecho no desaparecía.]],

	[[Empecé a charlar un poco con Bake para quitarme eso de la mente.
Aunque fuera loco, escucharlo hablar me ayudaba.]],

	{"bg", "mod", "root", color={0,0,0,1},
		fade={"color", res.palette("sixpm"), 1},
		shader=res.fun.gfx.purkinje(),
	},
	[[Afuera la nieve se apilaba, y el sol se ponía lentamente. Bake me
contaba de la vez que a Pipi la atropellaron pero que logró volver a caminar.]],

	{"bg", 2, "fade", 1, {"fadein", 2}},
	[[Falcon regresó casi una sombra, haciendo que me sobresaltara. Bake se
rió, y recién ahí reveló que tenía una linterna.]],

	{"bg", "mod", "root", color=res.palette("flashlight"),
		shader=res.shader.radialTex{
			center={5/7,2/7}, mul={3,3}, decay=2,
			bg={0,0,0,.95},
		}
	},
	{"bg", 2, "fade", {"src", res.doll.bake_xd}},
	{"name", "Bake"},
	[["Whazza!"]],

	{"bg", 2, "fade", {"src", res.doll.bake}},
	{"name", "María"},
	[["¬¬"]],

--[=[
	{"bg", "mod", "root",
		shader=res.shader.radial{
			center={-2/3,-2/3}, mul={3,3}, decay=2,
		}
	},
	1,
	{"bg", "mod", "root", shader=false},
	{"bg", "add", draw=f0b.draw.screenFill, color=res.palette("flashlight")},
	1/12,
	{"bg", "mod", color={0,0,0,1}, fade={"delay", .5, "fadeout", 4, true}},

	[["¡Ay, Bake!" dije tapándome los ojos. Me había apuntando con la
linterna.]],
]=]

	{"bg", "mod", "root", shader=res.fun.gfx.linterna(true)},
	{"name", "María"},
	[[Le quité la linterna para iluminar bien la cocina, porque no
me gustaba para nada la oscuridad.]],

	[[Falcon se aclaró la garganta, y explicó que le preocupaba no tener
protección en las ventanas.]],

	[[Según el, había visto unos zombies metiéndose a una casa así, e iba a
ser muy dificil defender tantas entradas ante cualquier problema.]],

	[[Por lo visto, Falcon había observado bastante como se comportaban
esas criaturas.]],

	{"name", "Bake"},
	[["Hmm, en la bodega hay unas tablas. Podés clavarlas si querés."]],

	{"name", "María"},
	[["¿No vas a ayudar?"]],

	{"name", "Bake"},
	{"text", [["Quisiera, pero caminar dos horas no le hizo bien a mi
espalda xD]], false, true},

	{"bg", 2, "fade", 2, {"src", res.doll.bake_xd}},
	{"text", [[ Me duele xDD"]], true},

	{"bg", 2, "fade", 2, {"src", res.doll.bake}},
	{"name", "María"},
	[["Yo te ayudo entonces," me ofrecí.]],

	[[Me llevé la linterna y dejamos cocinando a Bake solo con la
llama del gas, y entramos todas las tablas y herramientas al living.]],

	{"bg", 2, "modall", fade={"fadeout", 1}},
	{"macro", "bgFade", "maria/living.png"},

	[[Nos pusimos manos a la obra de inmediato. Yo sostenía las tablas
mientras el las clavaba a la pared.]],

	[[Me sentía un poco mal haciéndole esto a la casa de Bake, pero peor
sería dormir tras lo que dijo Falcon.]],

	{"bg", 2, "fade", 1, {"fadein", 1}},
	[[Mientras pasaba el tiempo, no pude evitar también sentir algo de
lástima por Falcon. A pesar de todas sus heridas, se notaba era un buen
chico.]],
	{"read", laConversacion, true},

	{"bg", 2, "fade", 1, {"fadeout", 1}},
	[[Tras nuestro arreglo la casa quedó aún mas oscura, así que
con Falcon acordamos buscar velas y baterías para la próxima salida.]],

	{"macro", "bgFade", res.fun.gfx.comedor2()},
	{"macro", "mesa", 1, "add"},
	{"bg", 2, "add", 1, args={res.doll.sillas, 320}},
	{"bg", 2, "modall", fade={"fadein", 1}},
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

	{"bg", 2, "fade", 3, {"fadeout", 1}},
	{"name", "María"},
	[[Bake fue a la cocina y se trajo todo en un solo viaje, incluyendo
un termo con agua caliente que había hervido de antes.]],

	{"bg", 2, "fade", 3, {"fadein", 1}},
	[[Bake me pasó la yerba y empecé a servirme de inmediato. Falcon nos
quedó mirando.]],

	{"name", "Falcon"},
	[["Pregunta, ¿ustedes son novios?" preguntó de pronto. Ambos lo
miramos.]],

	{"bg", 2, "fade", 3, {"src", res.doll.bake_xd}},
	{"name", "María"},
	[[Bake empezó a reir con la pregunta tan repentina, y yo hice lo mismo,
no más que de paso errándole con el agua al mate.]],

	{"bg", 2, "fade", 3, {"src", res.doll.bake}},
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
Falcon le repitió a Bake lo que me había contado sobre como sobrevivió estos
días.]],

	[[Pronto se pusieron a hablar sobre lo que sabían sobre los zombies.
Como enfrentarlos mejor, de que tan lejos nos podían detectar, si detectaban
el CO2 o la sangre o que se yo. Ninguno sabía porque algunos parecían mas
letárgicos.]],

	[[Yo le pregunté si sabía a donde se habían ido todos. El tampoco
tenía idea, pero si había notado el primer día que había muy poca gente
para una ciudad de millones.]],

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

	{"macro", "bgFade", "maria/living.png"},
	{"bg", "fade", {"fadeout", 1, true}},
	{"bg", 2, "fade", 1, {"fadeout", 1, true}},
	{"name", "Falcon"},
	[["¿Donde dormiremos?"]],

	{"name", "Bake"},
	[["Hay tres camas. Una la está ocupando Pipi. Solo queda la mía y la de
mis padres que es doble."]],

	{"name", "Falcon"},
	[["No dormiré contigo."]],

	{"name", "Bake"},
	{"text", [["Yo tampoco. ]], false, true},
	{"bg", 2, "sync"},
	{"bg", 2, "fade", 2, {"src", res.doll.bake_xd}},
	{"text", [[No somos gays xD"]], true},
	{"bg", 2, "fade", 2, {"src", res.doll.bake}},

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

	{"bg", 2, "modall", fade={"fadeout", 1/3, true}},
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
