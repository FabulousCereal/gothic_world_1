local conFalcon = {
	[[Emergí lentamente de mis sueños, aferrada a una calidez que sentía
que me abandonaría si es que la llegaba a soltar.]],

	[[Extrañamente me sentía bien. Fue una de esas noches que no había
tenido en demasiado tiempo. Con pereza abrí los ojos.]],

	[[Estaba vuelta hacia Falcon, con un brazo alrededor de el.]],

	{"bg", 1, "add", args={"maria/pieza.png"}, fade={"fadein", 2}},
	[[Me quedé paralizada sin saber que hacer. El seguía vuelto hacia la
pared, y pronto me dí cuenta que el aún dormía, sin darse cuenta.]],

	[[Con cautela lo solté y salí de la cama. Me puse abrigo y zapatos.
Esto nunca pasó.]],

	{"macro", "bgFade", "maria/pasillo.png"},
	[[Salí al pasillo y me recibió un olor a tostadas. Ese debía ser Bake.]],

	[[Me debatí sobre si despertar a Falcon para que desayunara, pero tras
ese incidente que acababa de prometerme olvidar, no tuve el valor.]],

	[[Si, no tenía ningún sentido si es que de verdad seguía durmiendo;
igual no quería.]],

	{"macro", "bgFade", "maria/living.png"},
	[[Bajé sola, tratando de entender como fue que había terminado así sí
me había acostado vuelta hacia el otro lado.]],

	{"macro", "bgFade", "maria/cocina.png"},
	[[Llegando a la cocina me encontré con Bake, que se trataba de mirar la
herida mientras el pan se le empezaba a quemar.]]
}

local conBake = {
	[[Desperté entre las luces de la mañana. El sol se asomaba por sobre
las montañas, y yo me sentía de maravilla. Recuperada. Enérgica. Luego recordé
que estaba en el apocalípsis. Mierda.]],

	[[Suspiré. Lo importante era que tenía la suerte de estar viva,
de no haber desaparecido como el resto de la ciudad, y de al menos tener
compañía.]],

	[[Me giré y noté que Bake ya se había levantado, o al menos no estaba
en la cama, así que me puse zapatos y bajé a buscarlo.]],

	{"bg", 1, "add", args={"maria/cocina.png"}, fade={"fadein", 1}},
	[[Guiada por el olor a tostadas llegué a la cocina. Bake se trataba de
mirar la herida. El pan se quemaba.]],
}

return {
	{"style", "vnMaria"},
	{"name", "María"},
	res.fun.macro.title,

	{"bg", "mod", "root", color=res.palette("tenpm")},
	{"bg", "addsub", {}},
	{"let", "quien"},
	{"global", "get", "quien", "DespiertaDonde"},
	{"case", "quien",
		{
			Bake = conBake,
			Falcon = conFalcon,
		},
		{
			{"bg", 1, "add", args={"maria/living.png"},
				fade={"fadein", 2}},
			[[Me sentía con ganas de morir. Tanto los ojos como el
			cuerpo me pesaban, y la cabeza se me partía, pero
			la claridad del día era tal que la horas perdidas ya no
			volverían.]],

			[[Para rematar, Bake se puso a hacer el desayuno.
			Mi estómago gruñó. 8 horas sin comer. Me desenrollé del
			nido con gran dificultad y fui tras el.]],

			{"macro", "bgFade", "maria/cocina.png"},
			[[Me quedé en la puerta de la cocina, a punto de caerme
			de cara al suelo, mirándolo sin que se diera cuenta.]],

			[[Había puesto la tetera y puso a tostar pan, pero
			intentaba revisarse la herida de la espalda. Se veía
			preocupado.]],
		}
	},

	[["¿Bake?"]],

	{"bg", "addsub", {
		{args={res.doll.bake, 210}},
		default={draw=f0b.doll.draw},
	}},
	[[Bake se sobresaltó al oírme, pero luego me miró con la sonrisa de
siempre.]],

	{"name", "Bake"},
	[["Buenos días."]],

	{"name", "María"},
	[["¿Te pasa algo?"]],

	{"name", "Bake"},
	[["No, no, estoy bien."]],

	{"bg", 2, "mod", fade={"fadeout", 1}},
	{"name", "María"},
	[[De un aventón dió vuelta todas las tostadas en el aire, y dijo que en
un rato estaría listo, que esperara un par de minutos.]],

	[[Sentía que había algo que no me contaba, pero tampoco me atrevía a
hacerle preguntas.]],

	{"bg", "mod", "root", fade={"color", {1/3, 1/3, 1/3, 1}, 1}},
	{"macro", "bgFade", res.fun.gfx.comedor2()},
	{"bg", 2, "add", 1, args={res.doll.sillas, 320},
		fade={"fadein", 1}},
	{"macro", "mesa", 1, "add"},
	[[Al final no hice mas que llevar una mantequilla a la mesa. Me senté
y me guardé las manos bajo el abrigo mientras esperaba. Mi aliento se notaba
por el frio.]],

	[[Tras varios minutos, Bake llegó con las tostadas y el agua.]],

	{"bg", 2, "mod", 2, fade={"fadein", 0}},
	{"name", "Bake"},
	[["¿No se levantó Falcon?" me preguntó mientras servía agua. Negué con
la cabeza mientras rodeaba el mate con las manos. "Seguro le debía hacer falta
una buena noche."]],

	{"bg", 2, "mod", 2, fade={"fadeout", 1, true}},
	{"name", "María"},
	[[Bake no quiso hablar mucho, y al terminar se fue a probar su guitarra
nueva al living. Sin ampli claro, aunque parecía saber como sonaría de todas
formas.]],

	[[Acabando de comer sola, me dí cuenta de que no sabía que hacer
ahora.]],

	{"bgm", "set", "bored", source="RECSNG13 - Un Château Abandonné.ogg"},
	{"bg", "mod", "root", fade={"color", {0,0,0,0}, 2/3}},
	2/3,

	{"bg", "rm", 2, 3},
	{"bg", 1, "rmall"},
	{"bg", "mod", "root", color={1,1,1,1}},
	{"macro", "date", {2011, 11, 12, 9, 25}},
	[[Nunca pensé que el apocalípsis pudiera ser tan aburrido.]],

	{"bg", 1, "mod", "default", color=res.palette("tenpm")},
	{"bg", 1, "add", args={"maria/patio.png"}, fade={"fadein", 1}},
	[[Salí a mirar donde estuvieron los cuerpos ayer y a mover la nieve con
los pies, pero de nuevo, no habían quedado mas que las manchas de sangre.]],

	[[Miré al cielo a ver si veía algún helicóptero de los que habló
Falcon. Traté de oir el ruido de algún auto por sobre los silenciosos solos de
Bake, pero parecía que el tiempo se había quedado estancado en esta ciudad,
pudriéndose.]],

	[[El día tenía mejor aspecto, eso si. Ojalá se acabara el frio.]],

	[[Pensé como última opción entrar a pedirle a Bake que me enseñara a
tocar, para pasar el rato, pero la verdad es que soy negada para eso de la
música. Siempre tenía malas notas en eso.]],

	[[Mi mamá me trataba de enseñar siempre que se lo pedía. Ella tocaba
bonito y cantaba, pero aunque pusiera los dedos igual, a mi me sonaba feo.
Nunca entendí eso.]],

	{"macro", "bgFade", "maria/living.png"},
	[[En fin, cuando me metí de vuelta a la casa, Bake se había ido al
baño. Me pregunté si es la herida que lo estaba molestando.]],

	[[Aunque ahora que lo pienso, un baño no me haría mal... Y de hecho,
tampoco una muda de ropa y un cepillo. Necesitaba conseguir esas cosas hoy.]],

	{"bgm", "mod", "bored", fade={"fadeout", 1, true}},
	[[Oh Dios, tal vez era eso. Bake me evitaba porque apestaba. Traté de
sentirme el olor. No lo logré pero estaba segura que debía ser eso.]],

	[[Todo esto es culpa del puto fin del mundo.]],

	[[Tendría que ir de nuevo al area comercial. O no, estaba demasiado
lejos. Debía buscar otro lado, o ir a recuperar mis cosas en el hotel, si es
que lograba ubicarlo.]],

	[[Hice memoria. Bake decía que solo salía a pasear a Pipi. O sea que
el hotel debía de hecho estar muy cerca de acá.]],

	[[Como Falcon seguía durmiendo y Bake por su herida era mejor que se
cuidara, busqué un lapiz y dejé una nota antes de salir. Pipi me olfateó
hasta la calle. No me estas haciendo sentir mejor, Pipi.]],

	{"bg", 1, "mod", 1, fade={"fadeout", 1, true}},
	[[Llevaba mi fiable navaja y una botella con agua. Ahora solo
necesitaba orientarme.]],
}
