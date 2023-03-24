local conFalcon = {
	[[Emergí lentamente de mis sueños envuelta en una acogedora calidez.
Era una de esas noches que no había tenido en demasiado tiempo. Con pereza
abrí los ojos.]],

	[[Estaba vuelta hacia Falcon, con un brazo alrededor de el.]],

	[[Me quedé paralizada sin saber que hacer. El seguía vuelto hacia la
pared, y pronto me dí cuenta que el aún dormía, sin darse cuenta. Con cautela
lo solté y salí de la cama. Me puse abrigo y zapatos. Esto nunca pasó.]],

	[[Salí al pasillo y me recibió un olor a tostadas. Ese debía ser Bake.]],

	[[Me debatí sobre si despertar a Falcon para que desayunara, pero tras
ese incidente que acababa de prometerme olvidar, preferí no arriesgarme.]],

	[[Si, no tenía ningún sentido si es que de verdad seguía durmiendo;
igual no me atrevía. Bajé sola, tratando de entender como fue que había
terminado así sí me había acostado vuelta hacia el otro lado.]],

	[[Llegando a la cocina me encontré con Bake, que se trataba de mirar la
herida mientras el pan se le empezaba a quemar.]]
}

local conBake = {
	[[Desperté entre las luces de la mañana. El sol se asomaba por sobre
las montañas, y yo me sentía de maravilla. Recuperada. Enérgica. Luego recordé
que estaba en el apocalípsis. Puta.]],

	[[Suspiré. Lo importante era que había tenido la suerte de estar viva,
de no haber desaparecido como el resto de la ciudad, y de al menos tener
compañía. Me giré y noté que Bake ya se había levantado, o al menos no estaba
en la cama, así que me vestí (o sea me puse zapatos) y bajé a buscarlo.]],

	[[Guiada por el olor a tostadas llegué a la cocina. Bake se trataba de
mirar la herida. El pan se quemaba.]],
}

return {
	{"style", "vnMaria"},
	{"name", "María"},
	res.fun.macro.title,

	{"let", "quien"},
	{"global", "get", "quien", "DespiertaDonde"},
	{"case", "quien", {
		Bake = conBake,
		Falcon = conFalcon,
		sola = {
			[[Me sentía con ganas de morir. Tanto los ojos y el
			cuerpo me pesaban, y la cabeza se me partía, pero
			la claridad del día era tal que la horas perdidas ya no
			volverían. Para rematar, Bake se puso a hacer el
			desayuno. Mi estómago gruñó. 8 horas sin comer.]],

			[[Me desenrollé del nido (tardé un poco en esto) y fui
			tras el. Me quedé en la puerta de la cocina, mirándolo.
			Había puesto la tetera y puso a tostar pan, pero
			intentaba revisarse la herida de la espalda. Se
			veía preocupado.]],
		}
	}},

	[["¿Bake?"]],

	[[Bake se sobresaltó al oírme, pero luego me miró con la sonrisa de
siempre.]],

	{"name", "Bake"},
	[["Buenos días."]],

	{"name", "María"},
	[["¿Te pasa algo?"]],

	{"name", "Bake"},
	[["No, no, estoy bien."]],

	{"name", "María"},
	[[De un aventón dió vuelta todas las tostadas en el aire, y dijo que en
un rato estaría listo, que esperara un par de minutos.]],

	[[Sentía que había algo que no me contaba, pero tampoco me atrevía a
hacerle preguntas. Al final no hice mas que llevar una mantequilla a la mesa.
Bake llegó pronto con las tostadas y el agua.]],

	{"name", "Bake"},
	[["¿No se levantó Falcon?" me preguntó mientras servía té. Negué con la
cabeza. "Seguro le debía hacer falta una buena noche."]],

	{"name", "María"},
	[[Bake no quiso hablar mucho, y luego de comer fue a probar su guitarra
nueva al living. Sin ampli claro, aunque parecía saber como sonaría de todas
formas. Quedándome sola, me dí cuenta de que no sabía que hacer ahora.]],

	{"macro", res.fun.macro.date, {2011, 11, 12, 9, 26}},
	[[Nunca pensé que el apocalípsis pudiera ser tan aburrido.]],

	[[Salí a mirar donde estuvieron los cuerpos ayer y a mover la nieve con
los pies, pero de nuevo, no habían quedado mas que las manchas de sangre.]],

	[[Miré al cielo a ver si veía algun helicóptero. Traté de oir el ruido
de algún auto por sobre los silenciosos solos de Bake, pero parecía que el
tiempo se había quedado estancado en esta ciudad, pudriendose.]],

	[[El día tenía buen aspecto, eso si, ojalá se acabe el frio.]],

	[[Pensé como última opción pedirle a Bake que me enseñara a tocar, para
pasar el rato, pero la verdad es que soy negada para eso de la música. Siempre
tenía malas notas en eso.]],

	[[Mi mamá me trató de enseñar una vez. Ella tocaba bonito y cantaba,
pero aunque pusiera los dedos igual, a mi me sonaba feo. Nunca entendí eso.]],

	[[En fin, cuando entré de vuelta a la casa, Bake se había ido al baño.
Me pregunté si es la herida que lo estaba molestando.]],

	[[Aunque ahora que lo pienso, un baño no me haría mal... Y de hecho,
tampoco una muda de ropa y un cepillo. Necesitaba conseguir esas cosas hoy.]],

	[[Oh Dios, tal vez era eso. Bake me evitaba porque apestaba. Traté de
sentirme el olor, pero no olí nada.]],

	[[Todo esto es culpa del puto fin del mundo.]],

	[[Tenía que ir de nuevo al area comercial. Era eso, o ir a recuperar
mis cosas en el hotel, si es que lograba ubicarlo. Me pareció mejor eso último,
ya que si Bake andaba a pie, no debiamos estar muy lejos de donde me
encontró.]],

	[[Como Falcon seguía durmiendo y Bake por su herida era mejor que se
cuidara, busqué un lapiz y dejé una nota antes de salir. Pipi me olfateó
hasta la calle. No me estas haciendo sentir mejor, Pipi.]],

	[[Llevaba mi navaja y una botella con agua. Ahora solo necesitaba
orientarme.]],
}
