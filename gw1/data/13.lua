local conFalcon = {
	[[Emergí lentamente de mis sueños envuelta en una acogedora calidez.
Era una de esas noches que no había tenido en demasiado tiempo. Con pereza
abrí los ojos.]],

	[[Estaba abrazando a Falcon.]],

	[[Me quedé paralizada sin poder reaccionar, pero pronto noté que Falcon
aun seguía durmiendo. Lentamente lo solté y me levanté de la cama, me vestí y
me puse zapatos. Esto nunca pasó.]],

	[[Salí al pasillo y me recibió un olor a tostadas. Ese debía ser Bake.]],

	[[Me debatí sobre si despertar a Falcon para que desayunara, pero tras
ese incidente que acabo de prometerme olvidar, sinceramente no me atrevía. Bajé
sola, tratando de entender como fue que había terminado así.]],

	[[Llegando a la cocina me encontré con Bake, que se trataba de mirar la
herida mientras el pan se le empezaba a quemar.]]
}

local conBake = {
	[[Desperté entre las luces de la mañana. El sol se asomaba por sobre
las montañas, y yo me sentía de maravilla. Recuperada. Enérgica. Luego recordé
que estaba en el apocalípsis.]],

	[[Suspiré. Lo importante era que había tenido la suerte de no haber
desaparecido. Me giré y noté que Bake ya se había levantado, o al menos no
estaba en la cama, así que me vestí (o sea me puse zapatos) y bajé a
buscarlo.]],

	[[Guiada por el olor a tostadas llegué a la cocina. Bake se trataba de
mirar la herida. El pan se quemaba.]],
}

return {
	{"style", "vnMaria"},
	{"name", "María"},

	{"case", "DespiertaDonde", {
		Bake = conBake,
		Falcon = conFalcon,
		sola = {
			[[Me sentía para la historia. Tanto los ojos y el
			cuerpo me pesaban, y la cabeza me dolía un poco, pero
			la claridad del día era tal que la horas perdidas ya no
			volverían. Para rematar, Bake se puso a hacer el
			desayuno. Mi estómago gruñó. 8 horas sin comer.]],

			[[Me desenrollé del nido (tardé un poco en esto) y fui
			tras el. Había puesto la tetera y puso a tostar pan,
			pero intentaba revisarse la herida de la espalda. Se
			veía preocupado. El pan empezó a humear.]],
		}
	}},

	[["¿Te ayudo?"]],

	[[Bake se sobresaltó al oírme, pero luego me miró con la sonrisa de
siempre.]],

	{"name", "Bake"},
	[["No, no, estoy bien."]],

	{"name", "María"},
	[[De un aventón dió vuelta todas las tostadas en el aire, y dijo que en
un rato estaría listo.]],

	[[Sentía que había algo que no me contaba, pero tampoco me atrevía a
ponerme a hacer preguntas. Al final no hice mas que llevar una mantequilla a la
mesa. Bake llegó pronto con las tostadas y el agua.]],

	{"name", "Bake"},
	[["¿No se levantó Falcon?" me preguntó. Negué con la cabeza. "Le debía
hacer falta una buena noche."]],

	{"name", "María"},
	[[Bake no quiso hablar mucho, y luego de comer fue a probar su guitarra
nueva al living. Sin ampli claro, aunque parecía saber como sonaría de todas
formas. Quedandome sola, me dí cuenta de que no sabía que hacer ahora.]],

	[[Nunca pensé que el apocalípsis pudiera ser aburrido.]],

	{"case", "DespiertaDonde", {
		sola = {
			[[Dormir no era opción. Hacerlo de día era algo que ya
			había intentado en varias ocaciones, y sabía que una
			dormía poco y para variar mal. De hecho, me dejaba con
			mas dolor de cabeza.]],
		}
	}},

	[[Salí a mirar donde estuvieron los cuerpos ayer. Miré al cielo a ver
si veía alguno de esos helicópteros. Traté de oir el ruido de algún auto por
sobre los silenciosos solos de Bake, pero parecía que el tiempo no pasaba por
esta casa. El día tenía buen aspecto, eso si, ojalá se vaya el frio.]],

	[[Pensé por último en pedirle a Bake que me enseñara a tocar para pasar
el rato, pero la verdad es que soy cerrada para eso de la música. Siempre tenía
malas notas en eso.]],

	[[Mi mamá me trató de enseñar una vez.]],

	[[Ella tocaba bonito, pero aunque pusiera los dedos igual que ella a mi
me salía feo. Nunca entendí eso...]],

	[[En fin, cuando entré de vuelta a la casa, Bake se había ido al baño.
Espero que no sea que la herida lo esté molestando.]],

	[[Aunque ahora que lo pienso, un baño no me haría mal... Y de hecho,
tampoco una muda de ropa, y una lavada de dientes...]],

	[[Ay cielos. Tal vez era eso. Bake me evitaba porque apestaba. No no
no, que vergüenza. Todo esto es culpa del puto fin del mundo.]],

	[[Tenía que recuperar todo lo que había dejado en el hotel. O buscar
todo nuevo, creo que eso sería mas fácil. ¿Como no se me ocurrió cuando
estuvimos en las tiendas? Brillante eres María, brillante.]],

	[[Como Falcon seguía durmiendo y Bake por su herida era mejor que se
cuidara, busqué un lapiz y dejé una nota antes de salir. Pipi me olfateó
hasta la calle. No me estas haciendo sentir mejor, Pipi. Llevaba mi navaja y
algo de agua. Ahora solo necesitaba ubicarme.]],
}
