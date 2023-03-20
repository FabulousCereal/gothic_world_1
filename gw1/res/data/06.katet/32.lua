local cafeConCroft = {
	{"select", nil, {
		[["¿Vas a quedarte?"]],
		[["¿En que trabajabas en medio de la nada?"]],
		[["¿Como fue eso de la bodega de municiones?"]],
		[["¿Por que 'Rocco'?"]],
		[[Terminar]],
	}},
	{"case", nil, {
		{
			{"name", "Croft"},
			[["¿A dormir?" Croft sorbeteó su café mientras pensaba.
			"Iba a volver, pero creo que ya está muy oscuro.
			¿Tienen cama?" Oh-oh.]],

			{"name", "María"},
			[["La verdad... solo hay dos ahora." Estaba la de Pipi,
			peeero...]],

			{"name", "Croft"},
			[["Puedo dormir en el sillón."]],

			{"name", "María"},
			[["No, no te lo recomiendo. Déjame pensar..."
			Por mas que pensara, solo habían dos camas.]],

			{"name", "Croft"},
			[["Puedo dormir en mi camioneta también."]],

			{"name", "María"},
			[["No, ahí te vas a morir de frio. Espera--"]],

			{"name", "Croft"},
			[["Puedo dormir con los perros."]],

			{"name", "María"},
			[["...Ah, es broma."]],

			[[Croft sorbeteó de su café, enigmático como siempre. Se
			me ocurrió que tal vez no bromeaba, pero no sabía.]],

			{"name", "Croft"},
			[["No tengo problema en compartir cama," agregó.
			"No lo digo por ti, claro." Oh, ok.]],
		},
		{
			{"name", "Croft"},
			[["¿Yo? Vivía de la tierra."]],

			{"name", "María"},
			[["Ah, ¿sembrabas?"]],

			{"name", "Croft"},
			[["Si, y en los meses que no hacía nada trabajaba de
			temporero. Estuve un tiempo criando pollos, pero llegó
			un puma a la zona y como nunca pude cazarlo, me quedé
			sin nada."]],

			{"name", "María"},
			[["G-Guau, que... miedo. ¿Y te alcanzaba para vivir con
			eso?"]],

			{"name", "Croft"},
			[["Si, vivía cómodo. Mientras no me metiera a la
			ciudad, claro."]],

			{"name", "María"},
			[["¿Por que? ¿Era muy caro?"]],

			{"name", "Croft"},
			[["Si, te quitaban hasta los calcetines acá."]],

			{"name", "María"},
			[["¿Pero no vives al lado? Tendría que ser lo mismo."]],

			{"name", "Croft"},
			[["Ehh, tendría pero curiosamente no lo era. Donde
			vivía los negocios eran todos bien accesibles.
			Supongo que las viviendas son caras en la ciudad y por
			eso le suben el precio a todo, pero no sé."]],

			[["Ademas que entre los vecinos nos pasabamos dando
			comida y ayuda. Yo les arreglaba un tractor, ellos me
			daban sacos, y para las fiestas todos poniamos algo."]],

			{"name", "María"},
			[["Suena agradable eso," comenté.
			"¿Que pasó con tus vecinos?"]],

			{"name", "Croft"},
			[["Todos se convirtieron," dijo simplemente. Croft se
			quedó mirando su taza, y entre eso y lo que nos contó
			sobre su amigo, no supe que responder.]],

			{"name", "María"},
			[[Había querido preguntarle sobre su familia, pero
			preferí no tocar el tema por ahora.]],
		},
		{
			[[Croft alejó la vista, como si la pregunta le hubiera
			traido dolorosos recuerdos de un tiempo que debería ser
			olvidado. Tras un incómodo silencio quise decirle que
			no tenía que responder, pero Croft suspiró primero y
			dijo]],

			{"name", "Croft"},
			[["Bueno, todo empezó por un panal de abejas. Promete
			que no le contarás a nadie mas."]],

			{"name", "María"},
			[["Lo prometo."]],

			[[Croft me contó la historia del panal, y como prometí
			no contarla, no la repetiré.]],

			[[Las manos me temblaban cuando Croft terminó. El no
			despegaba la vista del tazón que rodeaba con las
			palmas para calentarse. A mi tampoco me gustaban las
			abejas ahora.]],
		},
		{
			{"name", "Croft"},
			[["Me gustó el nombre."]],

			{"name", "María"},
			[["Ah," dije. De verdad no tenía idea de que hablar
			con Croft.]],
		},
		{
			{"break"},
		}
	}},

	{"name", "María"},
	[[Tomé un sorbo de mi café.]],
}

return {
	{"style", "vnMaria"},
	res.fun.macro.title,

	{"name", "María"},
	[[Llegamos a las 19:30 a la casa, con la nieve cayendonos en cantidad.]],

	[[Era increible lo oscura que era una ciudad sin alumbrado. Si no fuera
por la nieve blanca, no se vería prácticamente nada mas allá de las luces
del auto.]],

	[[Mas encima que como venía la ventana rota, me morí de frio todo el
camino. Croft aguantó estóico, pero creo que igual la debió pasar mal con el
viento en la cara.]],

	[[Entré con el y Rocco mientras los chicos bajaban sus instrumentos, y
como se veían entusiasmados en eso, le ofrecí a Croft tomar algo calentarnos.]],

	[[Nos sentamos a comer mientras los chicos subían, martillaban, y
aserruchaban cosas en el segundo piso, en el cuarto desocupado. A Falcon ni se
le notaba que estuvo toda la mañana en cama.]],

	{"name", "Croft"},
	[["¿Son así siempre?"]],

	{"name", "María"},
	[["Eso creo."]],

	[[Los observamos durante un rato, y como Croft no era muy dado a
conversar, tuve que hablar yo.]],

	{"read", cafeConCroft, true},

	[[Cuando ya habiamos comido y estabamos retirando la loza, un
ruido estruendoso nos hizo saltar de susto.]],

	{"name", "Bake"},
	[["Welcome to the jungle!" gritó Bake mientras tocaba su guitarra
distorsionada por el ampli. "¡Ahora si, Falcon!"]],

	{"name", "Falcon"},
	[["Fuck yeah!" gritaron aplaudiendo.]],

	{"name", "María"},
	[["Dios mío." No sabía como le hacían si no había luz, pero lo
hicieron. Tampoco sé para que trajeron pared antisonora si sonaba fuerte
igual. Escuchamos pasos por el pasillo de arriba. Falcon se asomó de cabeza.]],

	{"name", "Falcon"},
	[["Croft, ¿sabes tocar la guitarra? ¿O el bajo?"
Croft tenía cara de °J°]],

	{"name", "Croft"},
	[["No °J°"]],

	{"name", "Falcon"},
	[["¡Dice que no!" gritó devolviendose.]],

	{"name", "Bake"},
	[["¡Vale!" Bake se pusó a tocar a toda velocidad.]],

	{"name", "María"},
	[[Con Croft nos lavamos los dientes al sonido de pruebas de guitarra,
golpes eléctricos, y mas martillazos provenientes del cuarto.]],

	[[Le pregunté a Croft porque había agua pero no luz, y Croft me dijo
que el agua corría por gravedad desde las torres. Si seré tonta. Toda la
vida viendolas y nunca se me ocurrió que eran para eso.]],

	{"name", "Bake"},
	[["(Na-na-na-na-na-na-na-na knees! Na-na-na-na kneees!)"]],

	{"name", "María"},
	[[También dijo que a su casa por estar en lo alto le dejó de
llegar agua esta mañana. Debia ser por eso que preferió quedarse a pesar de que
no quedaran camas.]],

	[[En fin, terminamos, y como era tarde, Croft se fue a agarrar la cama
de Falcon antes que los chicos salieran. Yo tomé la de Bake. Me puse dos
pijamas para el frio, y me estaba acomodando cuando los chicos se pusieron a
aserruchar de nuevo.]],

	[[Suspiré. Ahora aparte de indignada tenía curiosidad. Me levanté de
nuevo y fui a tocar la puerta. Me dijeron que pasara. Abrí...]],

	[[...Y me encontré con un estudio de grabación en construcción.]],

	{"name", "Bake"},
	[["María, hola," dijo Bake. Sostenía una tabla mientras Falcon la
clavaba a la pared como repisa. Habían dos linternas dando luz en un rincón,
junto a la pared antisonora sin usar.]],

	{"name", "María"},
	[["¿Q-Que están haciendo?"]],

	{"name", "Falcon"},
	[["Nuestra sala de música. ¿Te gusta?" Había alrededor de ellos una
maraña de cables conectando las guitarras con los amplis.]],

	{"name", "María"},
	[[Y los amplis estaban conectados a una batería de auto.]],

	[["¿Esa no es la batería del auto?"]],

	{"name", "Bake"},
	[["Si, a Falcon se le ocurrió."]],

	{"name", "María"},
	[["¿Es que son locos? ¿Que pasa si llegan los zombies con el ruido?"]],

	{"name", "Bake"},
	[["A los zombies los espanta el ruido, lol"]],

	{"name", "María"},
	[["wtf?? ¿Quien dijo eso?"]],

	{"name", "Bake"},
	[["Yo lo digo xD" Falcon terminó de clavar, y puso una de las linternas
encima.]],

	{"name", "Falcon"},
	[["Perfecto."]],

	{"name", "María"},
	[["¿Clavaron esa tabla solo para eso?"]],

	{"name", "Falcon"},
	[["No podiamos sujetarlas mientras tocabamos xD"]],

	{"name", "Bake"},
	[["Si, aparte se siente como escenario xDDD" dijo levantando las manos
como roquero hacia un público imaginario. El ingenio de estos dos era
asombroso.]],

	{"name", "Falcon"},
	[["¿Cual tocamos ahora?"]],

	{"name", "Bake"},
	[["'Niña de mi Alma.'" respondió de inmediato. Falcon entrecerró los
ojos.]],

	{"name", "Falcon"},
	[["Ehh, tengo amnesia."]],

	{"name", "Bake"},
	[["Si sos guapo la vas a reconocer." Bake agarró la guitarra, y
tocó parte de una canción que había sonado mucho hace unos años.]],

	{"sfx", "bake riff2.ogg"},
	{"wait", 4, false, true},

	{"name", "Falcon"},
	[["Dale, me la sé," dijo Falcon sonriente. Se colgó el bajo y
Bake tomó su segunda guitarra.]],

	{"name", "María"},
	[["¡E-Esperen...!"]],

	{"name", "Bake"},
	{"text", [["Un, dos, tres, y--!"]], false, true},

	{"bgm", "set", "radio",
source="si pudiera componer hits estaria en la radio y no haciendolo gratis.ogg"},
	1,

	{"name", "María"},
	[[Los chicos se pusieron a tocar con los amplis al máximo antes que
pudiera detenerlos.]],

	[[Me tapé los oidos y les grité que pararan, pero ninguno me escuchaba
o no querían hacerme caso.]],

	{"bgm", "mod", "radio", fade={"delay", 1, "fadeto", .5, 1}},
	[[Terminé retirándome a mi cuarto, donde cerré la
puerta y me cubrí la cabeza con las sabanas para tratar de aislar el ruido.
Desgraciadamente no bastó, los muros parecían de cartón.]],

	{"bgm", "mod", "radio", fade={"fadeout", 5, true}},
	[[Como a las dos horas de estar cabeceando a ratos con la discografía
de Armas y Rosas entremedio, el ampli se apagó de golpe, despertándome por la
súbita falta de ruido. Refunfuñé bajo la almohada.
Ni en el silencio encontraba la paz.]],

	[[Oí a los chicos conversar algo sobre la batería. Se dieron un
par de vueltas en el pasillo, y Bake entró todo sigiloso a la habitación.
Claro, ahora le importaba no meter ruido.]],

	[[Yo me hice la dormida para no hablarle, pero Bake se devolvió y habló
un poco mas con Falcon en el pasillo. De ahí bajaron al primer piso, y aunque
esperé a ver si volvían, el sueño me terminó ganando.]],
}
