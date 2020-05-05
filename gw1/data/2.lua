return {
	{"style", lib.style.vnFab},
	{"name", "Altavoz"},
	[["Atención pasajeros, les habla su cápitan para anunciar que en unos
minutos vamos a aterrizar. Favor de dirigirse a su asientos, y abrochar sus
cinturones de seguridad. La hora local es 17:12 de la tarde, y la temperatura
afuera es de 8°C."]],

	[["Atentu pasaĝeroj..."]],

	{"name", "Fabian"}, [["Ha sido un largo viaje..."]],
	{"name", "señora de al lado"}, [["¿Me hablaba?"]],
	{"name", "Fabuab"}, [["No."]],
	{"gen", exec=lib.gen.dateSubs, args={2011, 11, 8, 17, 11}},
	[[Me acomodé en mi asiento mientras miraba la ciudad por la ventana. El
sol del atardecer se reflejaba en los cristales de los rascacielos. "Una casa
de espejos monumental," comenté, "donde nada es lo que parece."]],

	{"name", "señora de al lado"}, [["¿Que?"]],
	{"name", "Fabian"},
	[["Un centro comercial y tecnológico, creciendo en todas las
direcciones a pasos agigantados, mas rápido que lo que la gente común podría
entender. Muchos se quedan atras en la carrera al futuro. Los pocos a la
vanguardia pelean entre ellos como lobos hasta la muerte."]],

	[[Me recliné a beber de mi jugo.]],

	[["CONIUNGUNT. El principio de todo, el destino último. Lo posible. Lo
probable en posibilidad. Lo probable en demostrable. Una máquina de Turing
aleatorea con curso hasta ahora misterioso, pero ante la cual la ciudad pronto
tendrá respuestas."]],

	[["Una hiperconsciencia duerme bajo los suelos, una revolución que
promete todo lo que la era post-cuántica defraudo. Solo falta el Recibimiento.
Los poderosos se apresuran, saben que sus riquezas no valdrán nada en la nueva
era."]],

	[[Suspiré.]],

	[["Pero yo soy una simple persona, y en realidad no se nada de estos
sucesos aún. Pero es bueno saber de ante mano a que se enfrenta uno," agregué.
La mujer había dejado de oirme hace mucho. Tomé otro sorbo de mi jugo, y pegué
la frente a la ventanilla. Hacía frío.]],

	{"bg", "add", args=common.screenCover,
		color=lib.palette("softAfternoon", 1, .5),
		tween={"delay", 2, true}},
	{"bg", "add", args={lib.gen.wallClock(lib.style.clockTint, 17, 34,
		"Seikō")},
		color=lib.palette("softAfternoon"),
		tween={"delay", 2, true}},
	{"bg", "add", args=common.screenCover, color={0, 0, 0, 1},
		tween={"fadeout", 1/3, "delay", 4/3, "fadein", 1/3, true}},

	[[Cuando llegamos al aeropuerto y salí con mi mochila, extrañamente no
encontré a mi prima por ningún lado. Quizás se atrasó asi que me puse a
esperarla, porque no sabía donde vivía.]],

	{"bg", "finish"},
	{"bg", "add", args=common.screenCover, color={1,1,1,1},
		tween={"fadeout", .1, true}},
	[[Entonces ocurrió. Ví una luz como un rayo, y luego escuché la fuerte
explosión.]],

	{"sfx", "ping.ogg"},
	{"name", false},
	[[.........*boom*]],
	{"name", "Fabian"},
	[["¿Q-Que fue eso?"]],

	{"bg", "add", args={lib.img["fab-aeropuerto.png"], 20, 0, 0, .75},
		color=lib.palette("softAfternoon", 0),
		tween={"fadein", 1}},
	[[Me acerqué a mirar por la ventana, y lo único que ví fue una gran
nube de humo acercandose desde la ciudad. La gente miraba confundida, y pronto
el humo negro empezó a entrar en el aeropuerto.]],

	{"bg", "mod", tween={"fadeout", 1, true}},
	[[Este no era mi primer rodeo. Todos los que sobrevivimos el incidente
en Valdemar sabiamos muy bien que hacer, asi que me tiré al suelo tapandome la
nariz y gatée hasta la salida. Afuera las cosas ya estaban empezando a
descontrolarse. Los aviones daban vueltas sin poder aterrizar.]],

	[[Y ahora... me encontraba de noche en la ciudad, vagando y tratando de
buscar un lugar donde alojarme.]],

	{"bgm", "set", "haba", true,
		source=lib.bgm["haba-faba in da house, yo.ogg"]},
	[[Las calles estaban casi desoladas. El tráfico silencioso, El aire
estancado. Nada se movía bajo la luz de los faroles.]],

	[[No conozco bien la capital pero esperaría que lo normal fuera un poco
mas de actividad, ¿eh? A ratos, un molesto olor a humedad se sentía y se iba.]],

	[[Terminé llegando a un lugar, no se si un hostal o un motel, pero la
recepción estaba vacía. Vacía del tipo, seguramente podría meterme a dormir sin
que nadie me detuviera.]],

	[[Esperé durante varios minutos pero como se estaba haciendo muy tarde
tomé cualquier juego de llaves y fui a buscarles la habitación. Podía dar
explicaciones después.]],

	[[Los corredores estaban vacios. Escuchaba una tele de alguna
habitación, pero no veía gente. Aun tenía un poco del olor metálico del humo en
la nariz. Llegué a mi cuarto y cerré todo, y me dí una ducha antes de poner las
noticias...]],

	{"bgm", "mod", "haba", fade={"fadeout", 2/3, true}},
	{"wait", 2/3},
}
