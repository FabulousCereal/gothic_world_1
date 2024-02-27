return {
	{"style", "vnMaria"},
	{"bgm", "set", "theme", 0, source="newgw-marimba.ogg",
		fade={"fadein", 6}},
	res.fun.macro.title,
	{"macro", res.fun.macro.date, {2011, 11, 12, 12, 42}},

	{"name", "-----"},
	[["¿Hola, me escuchas?"]],

	{"name", "María"},
	[[Veía el rostro de un hombre sobre mi. Calvo. Nariz prominente. Era lo
único que distinguía. La cabeza se me partía sola.]],

	{"bgm", "mod", "theme", fade={"fadeout", 6, true}},

	[["Ay..."]],

	{"name", "-----"},
	[["¡Abrio los ojos, Rocco!" ¿Quién rayos era Rocco?]],

	{"name", "María"},
	[["¿D-Donde estoy?" Me costaba enfocar la vista. Era una especie de
cuarto de madera. Hacía calor. Había olor a carbón.]],

	{"name", "-----"},
	[["Tranquila. Estás en mi casa."]],

	{"name", "María"},
	[[Parpadeé un par de veces, sin poder recordar de nuevo como fue que
llegué de donde estaba hasta acá, pero intuí que el apocalípsis seguía en
curso, y que lo mejor sería no mover la cabeza.]],

	[[Esto de despertar en cuartos ajenos se estaba haciendo costumbre.]],

	[["¿Quién eres?"]],

	{"name", "-----"},
	[["Me llamo Croft, y este es mi perro Rocco. Dí hola, Rocco."]],

	{"sfx", "sfx/un perro que olfatea ansioso mientras todos creen que está feliz x2.flac"},
	{"name", "Rocco"},
	[[Un perro café se apoyó en la cama para olfatearme, y por acto
reflejo le acaricié la cabeza. El perro sacaba alegre la lengua.
Supuse que este sujeto no podia ser mala persona.]],

	{"name", "María"},
	[["¿Que fue lo que pasó?"]],

	{"name", "Croft"},
	[["Cruzaste de pronto y te atropellé con mi auto. Por suerte pasaste
por el medio y no te tocó ninguna rueda. No podía frenar con esa nieve."]],

	{"name", "María"},
	[[Ahora recordaba. Ya había cruzado la calle cuando se me ocurrió
devolverme.]],

	[[No lograba recordar el auto pero sí fragmentos, como haber estado
tirada en mitad de la calle. El cielo gris que daba vueltas. Tambien que al
caer me golpeé la-- "¡AUUU!" grité.]],

	{"name", "Croft"},
	[["Disculpa, quería ver como te había quedado la cabeza."]],

	{"name", "María"},
	[["Pues bien mal," le reclamé, y me busqué entre el pelo el chichón.
Estaba en el único lugar posible. "Bueno, perdona, pero es que para variar me
golpeo dos veces en el mismo lado."]],

	{"name", "Croft"},
	[["Uf," dijo Croft. Rocco también simpatizó. "Pero no fue tan malo
como se ve entonces."]],

	{"name", "María"},
	[["Si... Bueno, gracias por todo pero tengo que irme," dije
destapándome. Irónicamente ya no aguantaba la calor.]],

	{"name", "Croft"},
	[["Espera, ¿a donde?"]],

	{"name", "María"},
	[["De regreso a casa."]],

	[[Me levanté queriendo ponerme las botas, pero la pierna me falló y de
inmediato volví a caer.]],

	[["¡AUU! ¡Me duele!" dije agarrándome el pie. "Ay ay ay..."]],

	{"name", "Croft"},
	[["Espera, espera. Dejame ver." Croft se agachó junto con Rocco a
revisarme.]],

	{"name", "María"},
	[["¡Ah!"]],

	{"name", "Croft"},
	[["Disculpa. Me parece que te esguinzaste el pie. No soy doctor, pero
de que está inflamado, lo está."]],

	{"name", "Rocco"},
	[["¡Wuf!" asintió Rocco.]],

	{"name", "María"},
	[[¿Como me había esguinzado? No imaginaba como, pero con este dolor no
podía discutirle tampoco. Debía tener pésima suerte simplemente.]],

	[[Y fuera del pie y la cabeza, también me dolía la cadera donde el auto
me había golpeado. Todo andaba mal.]],

	{"name", "María"},
	[["¿Donde hay un hospital?" pregunté al borde de las lágrimas, sin
pensar en lo que decía.]],

	{"name", "Croft"},
	[["No hay nadie. Están todos vacios," me respondió con toda seriedad.
Al menos no se burló, o si esa era su forma de hacerlo, no la capté.]],

	{"name", "María"},
	[["¿Y alguna venda o algo para el dolor?"]],

	{"name", "Croft"},
	[["Solo tengo aguardiente."]],

	{"name", "María"},
	[[No sé porque, pero lo primero en lo que pensé fue en Bake duchándose
con alcohol. Al menos eso me subió un poco el ánimo.]],

	[["Ehh, bueno, gracias pero no gracias. Me tengo que ir. Me están
esperando," dije recogiendo mis botas.]],

	{"name", "Croft"},
	[["Vamos, te llevo en el auto." Croft me extendió la mano para
ayudarme. Con cuidado logré pararme, y cojeé con el hacia la puerta.]],

	{"name", "María"},
	[[La casa en la que vivía era bien rústica, y no había señales de que
viviera con alguien mas. Por las ventanas se veía un patio enorme.]],

	[[Recíen al poner un pie afuera me dí cuenta de que estabamos en un
area rural, en medio de las montañas. Me quedé incrédula en la puerta.
¿En donde demonios estaba?]],

	[[Croft notó mi impresión, y me aseguró que la ciudad estaba a unos
minutos de acá. Me llevó hacia una vieja camioneta destartalada, que creí
era chatarra que tenía adornando su patio.]],

	{"name", "Croft"},
	[["Esta es mi Vieja Mula. Ya no es lo que era antes, le falla hasta la
bocina y la radio, pero nunca me ha abandonado," explicó. Viéndola de frente,
si, este fue el auto que me atropelló.]],

	{"sfx", "freesound/561724__ezzin__tractor-start.fadeout@9.5.flac"},
	{"bgm", "set", "mula_idle", 0, setup={play=false},
		fade={"delay", 9.5, "cmd", {play=true}, "fadein", 1},
		source="freesound/561724__ezzin__tractor-start.idle_loop.flac"},
	{"name", "María"},
	[[Croft se subió a darle contacto, y tras provocarle lo mas parecido a
una tos convulsiva que se le pueda dar a un vehículo, este encendió.]],

	[[Rocco se metió por la ventana de un salto. Noté un olor raro al
subir, pero preferí no hacer preguntas.]],

	{"name", "Croft"},
	[["¿Donde vives?"]],

	{"name", "María"},
	[["No... lo sé." Como siempre una inútil.]],

	{"name", "Croft"},
	[["Te puedo llevar a donde te encontré."]],

	{"name", "María"},
	[["Si, sería lo mejor."]],

	{"bgm", "sync"},
	{"bgm", "mod", "mula_idle",
		fade={"cmd", {setPitch=2}, "fadeout", 2,
			"cmd", {play=false, setPitch=1}}},
	{"bgm", "set", "mula_run", 0,
		fade={"fadein", 2},
		source="freesound/561724__ezzin__tractor-start.run_loop.flac"},
	[[Croft movió la palanca oxidada con lo que me dí cuenta debía ser una
fuerza considerable. Se oyó el ruido de metal dislocándose desde el motor, y
con un remezón la camioneta empezó a andar como si se hubiera sacudido las
pulgas.]],

	[[Rocco, por su parte, iba sentado entre los dos, mirando a la lejanía.
Salimos al camino de tierra. Se divisaba una que otra casa, pero era casi todo
campo.]],

	{"name", "Croft"},
	[["¿Escapabas de algo? Ví que te devolviste de pronto pero no ví
nada tras de ti." Ay Dios.]],

	{"name", "María"},
	[["No, no, solo salí a buscar ropa y cosas para el aseo. Lo perdí todo
ayer."]],

	{"name", "Croft"},
	[["¿Huiste de casa?" Que pregunta...]],

	{"name", "María"},
	[["Si," respondí. "Estoy con unos chicos ahora, pero estaban
heridos. No quise molestarlos por un cepillo."]],

	{"name", "Croft"},
	[["Entiendo. ¿Tienen comida?"]],

	{"name", "María"},
	[["Algo."]],

	{"name", "Croft"},
	[["Traigo una bolsa de galletas, si les sirve."]],

	{"name", "María"},
	[["Pero somos cuatro personas... ¿con una sola bolsa?"]],

	{"name", "Croft"},
	[["Bueno, algo es mejor que nada."]],

	{"name", "María"},
	[[A pesar de la impactante recibida, Croft parecía ser buena persona,
aunque me llamó la atención que viviera solo en el campo siendo tan joven. ¿No
se aburrirá? De pronto, Rocco empezó a dar vueltas en el asiento.]],

	{"name", "Croft"},
	[["¡Rocco! ¡No hagas--! Mierda. !Afuera!"]],

	{"bgm", "mod", "mula_idle", fade={"cmd", {play=true}, "fadein", 2}},
	{"bgm", "mod", "mula_run", fade={"fadeout", 2, "cmd", {play=false}}},
	{"name", "María"},
	[[Croft detuvo el auto e hizo salir a Rocco al camino, que se bajó
tiritando. Empezó a hacer del dos junto a la rueda de la camioneta mientras
Croft se llevaba la mano a la cara.]],

	{"name", "Croft"},
	[["Disculpa. No está acostumbrado a andar en carro." Rocco terminó de
hacer y empezó a tirarle tierra y nieve a la rueda hasta quedar contento.
"¿Listo?" Rocco agitó la cola sonriendo y se subió de vuelta.]],

	{"name", "María"},
	[[Ese era el olor, ese era.]],
	{"bgm", "rmall"},
}
