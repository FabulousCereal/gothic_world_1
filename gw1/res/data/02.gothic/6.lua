return {
	{"name", "María"},
	{"style", "vnMaria"},
	{"bgm", "set", "theme", 0, source="newgw-marimba.ogg",
		fade={"delay", .5, "fadeto", .5, 6}},
	res.fun.macro.title,

	[[No sé en que momento habré semi-despertado, atrapada entre los sueños
y la realidad. Mi cabeza daba vueltas, mi consciencia iba y venía, y una
melodía retumbaba sin fin en mi mente... Me hoztigaba, pero no tanto como el
súbito sonido de un despertador.]],

	{"bgm", "mod", "theme", fade={"fadeout", 3, true}},
	{"bgm", "set", "alarm", source="weird alarm.ogg"},
	{"bg", "add", args={res.fun.clock.alarm(res.style.clockAlarm, 12, 30)},
		color={1,1,1,0},
		tween={"fadein", .25}
	},
	1,

	{"macro", res.fun.macro.date, {2011, 11, 11, 12, 30}},

	{"text", [[Estiré mi mano e hice callar el reloj como volviendo a una
vieja rutina,]], false, true},

	{"bgm", "mod", "alarm", fade={"fadeout", 1/12, true}},
	{"bg", "mod", tween={"fadeout", 1/12, true}},
	{"text", [[ antes de caer en la cuenta de que me hallaba en un cuarto,
en una cama. ¿Donde estaba? No reconocía el lugar, eso era seguro.]], true},

	[["¿Habrá sido un sueño?" Sentí una sensación de alivio y paz, y solté
un suspiro. Recordé esa crisis de pánico. Que bueno que no fue
real. Vivir así sería demasiado terrible... no lo aguantaría de verdad.]],

	[["¿Que hice anoche entonces?" Seguía en una casa desconocida. Habían
posters de bandas de rock en la habitación. Había tambien ropa de chico
tirada. Escuché ladridos.]],

	[[Afuera el viento helado hacía crujir el techo a ratos, pero aquí
estaba protegida de todo aquello. El aire era cálido y acogedor.]],

	[[Ese sueño me dejó tan agotada emocionalmente que hasta me dieron
ganas de dormirme de nuevo, pero tal vez sería mejor que me levantara. Noté una
nota en el estante junto al despertador.]],

	{"bg", "add", args={"bake/nota.png"}},
	[["Uno. Me voy y volveré a eso de las doce y media, la alarma está
encendida." Que considerado.]],

	[["Dos. No abuse de ti mientras estabas inconsciente. Ele O Ele."]],

	[[...¿Que?]],

	[[Era tan de la nada que comencé a reir. ¿Quién será este chico? La
nota no estaba firmada, solo contenía una posdata en otro idioma.
"Alguien culto debe ser," pensé. La dejé de vuelta en el estante pero se
cayó.]],

	{"bg", "rm"},
	[[Mi cabeza aún me dolía, ¿pero porque me dolía si había soñado todo?
Traté de hacer memoria.]],

	[[...Guau, de verdad no podía recordar nada. "Ahora si te las
mandaste," me dije refregándome los ojos. Ojalá no haya sido por una fiesta,
porque detestaría haberla olvidado si fue buena.]],

	[[Me busqué entre el pelo el chichón, y aunque me dolío como los mil y
un demonios al tocarme, no parecía haberme hecho herida ni haberme sangrado,
así que no debía ser tan grave. Me levanté y me acerqué a la puerta a buscar
respuestas.]],

	[[Al abrirla escuché ruidos del primer piso. Cosas golpeándose
violentamente. El buen humor se me fue de inmediato.]],

	[[Yo aquí riéndome de este chico y ni sé aún si es peligroso o no. De
pronto, esa nota no se me hacía tan graciosa.]],

	{"bg", "add", args={"Flash/day.png"},
		color=res.palette("repellantYellow", 0),
		tween={"fadein", 2/3}},
	[[Bajé con cautela las escaleras, mientras los ruidos aumentaban en
intensidad. Llegué a una especie de living que daba a un comedor. Las cortinas
estaban cerradas. Los ruidos provenían de lo que parecía la cocina.]],

	{"bg", "mod", tween={"fadeout", 2/3, true}},
	[[Me asomé por la puerta a mirar. Había un muchacho tirando cosas por
la ventana, hacia el patio. ¿Será él el dueño de casa? Vestía solo una polera
y unos shorts a pesar del frio que hacía. Parecíamos ser los
únicos acá. De pronto sacó un arma.]],

	[[El chico comenzó a disparar por la ventana, y yo me escondí
cubriéndome los oídos. ¿Que estaba sucediendo? ¿Por que me trajo acá? ¿Y que
querría de mí? No lo había visto nunca, ni sabía si iba o no a
lastimarme, pero a la vista, parecía... un buen chico.]],

	[[Entonces oí entre disparos unos gemidos atroces desde afuera, que
me helaron la sangre. Si esos ruidos inhumanos no eran de gente... es que tal
vez no había despertado de ningún sueño.]],

	[[No, no podía ser cierto, tenía que confirmarlo. Entré con sigilo a la
cocina. El chico estaba demasiado pendiente de lo que había afuera para notar
mi presencia. Miré por la ventana.]],

	[[Por primera vez ví a las criaturas en directo. Eran dos personas con
una piel nauseabunda, color verde petroleo, con el pelo casi completamente
caído. Sangraban un espeso liquido marrón al ser impactados, pero a pesar de
que el chico había derribado al mas pequeño a tiros, este seguía vivo.]],

	[[Las manos del chico temblaban. No sabía si le quedaban balas para el
mas grande. Entonces recordé que si esto no era un sueño, debía seguir con las
mismas cosas encima. Busqué en mis bolsillos. Aún poseía mi navaja.]],

	[[Le hablé al chico. Esté se sorprendió al verme tan de pronto, pero al
ver la navaja lo único que atinó a hacer fue una gran sonrisa. La tomó de mis
manos y salió al campo de batalla.]],

	{"bgm", "set", source="prelude2_famicom.ogg"},
	[[A pesar del aspecto terrorífico de las criaturas, el movimiento de
estas era torpe y lento. El chico botó el agua de una cubeta y se la tiró por
la cabeza al grande para distraerlo. Corrió hacia la criatura por el costado,
y antes de que esta pudiera atacarlo, le enterró la navaja en el cuello.]],

	[[A la criatura no le importó. Golpeó al chico con el brazo en la
cabeza, pero el pareció resistirlo bien.]],

	[[El chico probó a realizar ataques veloces, haciendole cortes en el
cuello y retirandose de un salto. La criatura lo atrapó en uno de sus ataques,
pero el chico se safó rápido y volvió a arremeter. La criatura por fín empezó a
tambalearse, y cayó al suelo mientras mas de ese líquido brotaba de su herida.]],

	{"bgm", "mod", fade={"fadeout", 1/3, true}},
	[[Al final, el chico lo remató con un disparo detrás la cabeza, e hizo
lo mismo con el pequeño que ya había logrado levantarse. Con ambos muertos, el
chico volvió corriendo a la cocina, jadeando. Fue cuando se acercó que noté sus
enormes ojos marrones.]],

	[[De pelo negro hasta los hombros, un metro setenta y cinco. Si,
viendolo de cerca, parecía un buen chico... y entonces recordé la nota. El
chico habló.]],

	{"name", "chico"},
	[["Graci--" Lo interrumpí con una cachetada.]],

	{"name", "María"},
	[["No creo lo segundo que pusiste en la carta," le reclamé.]],

	{"name", "chico"},
	[["Tranquila, era broma," dijo riendo.]],

	{"name", "María"},
	[[Me quedé mirando sus ojos, y sonreí. Su rostro radiaba por el
ejercicio y la adrenalina. Se notaba era atlético. El sonrió de vuelta.]],

	{"name", "chico"},
	[["¿Cual es tu nombre?" me preguntó.]],

	{"name", "María"},
	[["María," respondí sin dudarlo. "¿Y el tu--?"]],

	[[El chico de pronto se abalanzó sobre mi, quedando su cara en mi
pecho. Pensé que ahora si estaba segura de que era un depravado, pero resultó
que se había desmayado. Lo sujeté con todas mis fuerzas para que no se cayera.
Su cuerpo se sentía cálido, a pesar que tenía muy poca ropa para este frio.]],

	[[Logré llevarlo —arrastrarlo— con gran esfuerzo hasta un sillón, y
cuando fuí a recostarlo, descubrí una mancha de sangre formándose atrás en su
polera.]],

	[[Con algunas cosas que encontré en su baño le vendé la herida para
frenar el sangrado. Tras haberme traído acá, era lo mínimo que podía hacer.]],

	[[Pasaron unos minutos en que el chico seguía inconsciente. Me pregunté
que hacía acá solo. ¿No habían evacuado? ¿Que pasó con la gente entonces? Las
calles estaban demasiado vacias para que todos se hayan... transformado. No
podía ser.]],

	[[Si había un rescate, tal vez aún había tiempo. Lavé mi navaja con
agua y cloro y me dispuse a dar una vuelta para explorar. Como no encontré
un lápiz, le dejé al chico su misma nota en la mesa antes de partir, con el
despertador puesto a las 1:15pm, por si acaso.]],

	[[Salí dejando la puerta junta para cuando volviera, y el perro del
chico me siguió olfateándome hasta la puerta de la calle, y me miró mientras me
alejaba. Al menos, ahora tenía un lugar donde volver.]],
}
