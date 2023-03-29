local function repeatSqueal(n)
	local fade = {}
	local time = 1.19
	local ins = table.insert
	for i = 1, n do
		ins(fade, "cmd")
		ins(fade, {seek=0})
		ins(fade, "fadeto")
		ins(fade, 1 - i/n)
		ins(fade, time)
	end
	return fade
end

return {
	{"style", "vnMaria"},
	res.fun.macro.title,

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
			[["En realidad... la verdad es que lo aprendí de ocioso
			en estos días. Ya perdí la cuenta de cuantas veces
			choqué el auto."]],

			{"name", "María"},
			[["A-Ah."]],

			{"name", "Bake"},
			[["lol, entiendo todo ahora."]],

			{"name", "María"},
			{"text", [[Llegamos]], false, true},
		},
		{
			{"name", "Falcon"},
			[["¿Derrapar?" dijo con una sonrisa dibujándose en su
			rostro. "Claro. Afirmate." Falcon pasó cambios y le
			metió el pie al acelerador. Cuando nos íbamos acercando
			a una curva giró el volante rápido.]],

			{"bgm", "set", "squeal1", 0,
				source="freesound/71739__audible-edge__chrysler-lhs-tire-squeal-04.16.flac",
				setup={seek=5}, fade={"fadein", .25, "delay", 1.75, "fadeout", .5, true}},
			{"sfx", "freesound/676613__fivebrosstopmosyt__table-smash-1.flac",
				.25, 1/3, 2},
			{"name", "Bake"},
			{"text", [["HOLY SH--"]], false, true},

			{"name", "María"},
			[[El auto pasó de largo la curva hasta que las
			ruedas chocaron con la cuneta de enfrente. El auto dió
			un salto y en el aire vi el piso de la vereda
			acercándose por mi ventana. Grité.]],

			[[Cuando estaba a solo centímetros las ruedas tocaron
			el suelo y el auto saltó hacia el otro lado.]],

			[[Nos deslizamos por la calle en dirección a un árbol
			mientras Falcon movía como loco el volante y Bake ponía
			y sacaba el freno de manos.]],

			{"bgm", "set", "squeal2",
				source="freesound/71738__audible-edge__chrysler-lhs-tire-squeal-03.cut.flac",
				fade=repeatSqueal(5)},
			[[De alguna forma lo esquivamos, y nos fuimos con el
			auto dando coletazos por la calle.]],

			{"name", "Falcon"},
			[["Q-Quería hacer eso."]],

			{"name", "María"},
			{"text", [[Llegamos (vivos)]], false, true},
		}
	}},

	{"name", "María"},
	{"text", [[ a la casa cerca de las siete, cuando ya estaba oscureciendo
y la nieve comenzaban a tapar la vista. Entramos Falcon y yo cargando
la comida, y el se detuvo a estirar los brazos al techo.]], true},

	{"name", "Falcon"},
	[["Dios, que agradable," dijo extasiado. "Había dormido todos estos
días en el auto." Bake entró sin nada y se tiró directo al sillón.]],

	{"name", "Bake"},
	[["Tenés razón," dijo recostado boca abajo. Llevé a Falcon a la
cocina para guardar la comida.]],

	[["¿Sabés que nos hizo falta? Unas chelas," comentó Bake desde el
living. Falcon contuvo una risa, aunque a mi no me hizo gracia.]],

	{"name", "María"},
	[["Bake, hay que sacar los cuerpos," le dije enojada.]],

	{"name", "Bake"},
	[["Mierda xD"]],

--	{"bg", "add", args={"falcon/que.png"}},
	{"name", "Falcon"},
	[["¿Eh? ¿Cuerpos?"]],

	{"name", "María"},
	{"text", [["Si. Unos zombies nos atacaron en la mañana y quedaron ahí
afuera," dije apuntando a la ventana porque]], false, true},

--	{"bg", "mod", args={"falcon/lado.png"}},
	{"text", [[ no quería verlos de nuevo. "Bake no me quiere ayudar a
sacarlos."]], true, false},

	{"name", "Falcon"},
	{"text", [["Ahh."]], false, true},

--	{"bg", "mod", tween={"fadeout", 1/2, true}},
	{"text", [[ Falcon fue a echar un ojo mientras yo guardaba la comida.]],
true},

	[["Aquí no hay nada," dijo. Pensé que quizás la nieve los había
cubrido. Me asomé a mirar, y luego abrí la puerta. De verdad no estaban.]],

	{"name", "María"},
	[["S-Se suponía que estaban muertos." ¿Donde se habían ido? ¿Que había
pasado?]],

	{"name", "Bake"},
	[["Mi espalda dice gracias xD," dijo Bake llegando a apoyarse en la
puerta, sin polera. "Debe ser que se los llegó a comer otro porque yo los dejé
bien muertos."]],

--	{"bg", "add", args={"falcon/que.png"}},
	{"name", "Falcon"},
	[["Que yo sepa no son caníbales, pero quién sabe."]],

	[[El viento sopló fuerte de nuevo así que nos metimos de nuevo a la
casa. Le puse el seguro a la puerta.]],

--	{"bg", "mod", args={"falcon/normal.png"}},
	[["No te preocupes en todo caso, mejor que estén lejos," dijo por lo
visto calmado. "Si no les molesta, voy a darle una vuelta a la casa."]],

	{"name", "Bake"},
	[["Dale. Yo tengo hambre así que voy a preparar algo."]],

--	{"bg", "rm"},
	{"name", "María"},
	[[Intenté quedarme tranquila con sus palabras, aunque por mas que
me dijeran esas cosas, esa extraña incomodidad en el pecho no desaparecía.
Empecé a charlar un poco con Bake para quitarme eso de la
mente. Aunque fuera loco, escucharlo hablar siempre me ayudaba.]],

	[[Afuera la nieve se apilaba, el día oscurecía, y pusimos una linterna
para iluminarnos mientras Bake cocinaba. Falcon volvió, y dijo
que sería mejor reforzar las ventanas ya que ninguna tenía protección.]],

	{"name", "Bake"},
	[["Te ayudaría, pero caminar dos horas no le hizo bien a mi espalda xD
Me duele xD" dijo Bake.]],

	{"name", "María"},
	[["Yo te puedo ayudar." Bake nos dijo que en la bodega tenía unas
tablas que nos podían servir. El se quedó cocinando, mientras yo y Falcon nos
dedicabamos a tapar cada ventana.]],

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
me quedé pensando en sus palabras. 'Estar atentos'. Yo andaba sobresaltada.
Ojalá sirva de algo.]],

	[[Al final de nuestro arreglo la casa quedó aún mas oscura, así que
con Falcon acordamos buscar velas y baterías para la próxima salida. Terminado
eso, nos sentamos a comer un estofado con la última comida real que le quedaba
a Bake.]],

	[[Voy a admitir que luego de lo de la pizza en lata no tenía fe que
Bake fuera bueno en esto...]],

	[[Pero no sé si fueron todos los días comiendo galletas y o que, pero
la primera cucharada casi me hizo llorar. Estaba tan exquisito, era incluso
mejor que lo que comía en casa. Antes de darme cuenta me lo había tragado
todo. Bake me miraba atento.]],

	[["Te quedó muy bueno," concluí.]],

	{"name", "Bake"},
	[["lol, se notó. ¿Mate? ¿Café?"]],

	{"name", "María"},
	[["Mate."]],

	{"name", "Falcon"},
	[["Eeh, mate también."]],

	{"name", "María"},
	[[Bake fue a la cocina y se trajo todo en un solo viaje, incluyendo
un termo con agua caliente que había hervido de antes. Bake me pasó la yerba y
empecé a servirme de inmediato. Falcon nos quedó mirando.]],

	{"name", "Falcon"},
	[["Pregunta, ¿ustedes son novios?" preguntó de pronto. Nos
quedamos callados un segundo.]],

	{"name", "María"},
	[[Bake empezó a reir con la pregunta tan repentina, y yo tambien, no
más que de paso errándole con el agua al mate.]],

	{"name", "Bake"},
	[["lol, no, nos conocimos esta mañana. La salvé de la Sombra," rió.]],

	{"name", "María"},
	[["¿De la que?" Bake solo sonrió misteriosamente y se negó a explicarme
que era eso de la sombra.]],

	[[También se negó a decirme como fue que terminé en su cama, y Falcon
levantó las cejas tras eso último. O bueno, lo hizo hasta que
probó el mate,]],

	{"name", "Falcon"},
	[["Ew," dijo arrugando la cara. "Que amargo."]],

	{"name", "Bake"},
	[["lol, ¿nunca habias tomado?"]],

	{"name", "Falcon"},
	[["Intuia que no pero pensé que era por la amnesia."]],

	{"name", "Bake"},
	[["Vos fumaste de la mala parece."]],

	{"name", "Falcon"},
	[["No bromees, ya casi creo que tienes razón," dijo
rebalsando su mate con azúcar.]],

	{"name", "María"},
	[[Nos quedamos charlando un rato ahora que podíamos hablar con calma.
Falcon nos contó, como el mismo la llamó, la completa historia de su vida, que
se limitaba a los últimos tres días desde la explosión.]],

	[[No era mucho, pero me llamó la atención lo de la chica. Entendía
ahora porque Falcon no había abandonado la ciudad a pesar de tener un auto.
Ojalá la hubiera buscado mas.]],

	[[Hablando de autos, me pareció curioso como al segundo día, ayer, ya
no había nadie. Le pregunté si sabía de alguna evacuación y me dijo que no,
pero que como todas las estaciones habían dejado de transmitir el primer día,
había dejado de usar la radio del auto.]],

	[[Tambien habló de que se veían helicópteros de cuando en vez, aunque
no sabía donde iban ni que hacían. Sugerí que a lo mejor eran del rescate, pero
Falcon dijo que no aterrizaban en la ciudad. Reconocimiento, dijo Bake, pero
¿que tanto reconocimiento se podía necesitar de la propia capital?]],

	[[Por donde se le mirara nada parecía tener sentido.]],

	[[En fin, conversamos hasta que el reloj de Falcon sonó a las 9. El
cansancio se nos notaba a todos, aunque a el especialmente.]],

	[[Bake quiso tocar la guitarra pero lo detuvimos, y como ya era
prácticamente de noche y el ambiente se enfriaba por segundo, decidimos que era
mejor irnos a dormir. Fuimos hasta la escalera.]],

	{"name", "Falcon"},
	[["¿Donde dormiremos?"]],

	{"name", "Bake"},
	[["Hay tres camas. Una la está ocupando Pipi. Solo queda la mía y la de
mis padres que es doble."]],

	{"name", "Falcon"},
	[["No dormiré contigo."]],

	{"name", "Bake"},
	[["Yo tampoco. No somos gays xD"]],

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

	{"name", "María"},
	[[Ambos subieron y se fueron a dormir, dejándome sola a los pies de la
escalera con la linterna en la mano. En cinco segundos se habían repartido las
camas, y poco mas y decidían con quién dormía sin siquiera preguntarme. Ya
se habían esfumado para cuando se me ocurrió reclamar. Patée el suelo.]],

	[[¿Por que los hombres siempre tenían que creerse tan machos? ¿Que
tenía que durmieran juntos? En la escuela era igual, no se podían ni pasar a
tocar entre ellos. Yo si preferiría dormir con otra mujer.]],
}
