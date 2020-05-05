return {
	{"name", "María"},
	{"style", lib.style.vnMaria},
	[[No sé en que momento habré semi-despertado, atrapada entre los sueños
y la realidad. Mi cabeza daba vueltas. Mi consciencia iba y venía. Una melodía
retumbaba sin fin en mi mente... Me hoztigaba, pero no tanto como el sonido de
un despertador.]],

	{"bg", "add", args={lib.gen.alarmClock(lib.style.clockAlarm, 12, 30)},
		color={1,1,1,0},
		tween={"fadein", .25}
	},

	{"wait", 1},

	{"gen", exec=lib.gen.dateSubs, args={2011, 11, 11, 12, 30}},

	{"bg", "mod", tween={"delay", lib.chrono.textSpeed * 72,
		"fadeout", 1/12, true}},

	[[Estiré mi mano e hice callar el reloj como volviendo a una vieja
rutina, antes de caer en la cuenta de que estaba en una cama. ¿Cual casa es
esta? No era la mía, eso era seguro.]],

	[["¿Habrá sido un sueño?" Una sensación de alivio y paz recorrió mi
cuerpo, y solté un suspiro. Recordé esa crisis de pánico. Que bueno que no era
real. Vivir así sería demasiado terrible... no lo aguantaría de verdad.]],

	[["¿Que hice anoche entonces?" Seguía en una casa desconocida. Habían
posters de bandas de rock en la habitación. Había tambien ropa de chico tirada.
Afuera el viento helado hacía crujir el techo a ratos.]],

	[[Pero aquí adentro el aire era cálido y acogedor. Ese sueño me dejó
tan agotada emocionalmente que hasta me dieron ganas de dormirme de nuevo, pero
no. Noté una nota en el estante junto al despertador.]],

	{"bg", "add", args={lib.img["nota-bake.png"]}},
	[["Uno. Me voy y volveré a eso de las doce y media, la alarma está
encendida." Que considerado.]],

	[["Dos. No abuse de ti mientras estabas inconsciente. Ele O Ele."]],

	[[...¿Que?]],

	[[Era tan de la nada que comencé a reir. ¿Quién será este chico? La
nota no estaba firmada por ningún lado mas que con un posdata en otro idioma.
"Alguien culto debe ser," pensé. La dejé de vuelta en el estante pero se
cayó.]],

	{"bg", "rm"},
	[[Mi cabeza aún me dolía, ¿pero porque me dolía si había soñado todo?
Traté de hacer memoria.]],

	[[...Guau, de verdad no recordaba nada de lo que pasó anoche. Me revisé
entre el pelo el chichón, y al menos no parecía haber sangrado. Me levanté y me
acerqué a la puerta.]],

	[[Al abrirla escuché ruidos del primer piso. Cosas golpeándose
violentamente. El buen humor se me fue de inmediato.]],

	[[Yo aquí riéndome de este chico y ni sé aún si es peligroso o no. De
pronto, esa nota no se me hacía tan graciosa.]],

	{"bg", "add", args={lib.img["Flash/day.png"]},
		color=lib.palette("repellantYellow", 0),
		tween={"fadein", 2/3}},
	[[Baje con cautela los escalones, mientras los ruidos aumentaban en
intensidad. Llegué a una especie de living-comedor. Los ruidos venían de la
cocina.]],

	{"bg", "mod", tween={"fadeout", 2/3, true}},
	[[Me asomé por la puerta a mirar. Había un muchacho tirando cosas por
la ventana, hacia el patio. ¿Será el el dueño de casa? Parecíamos ser los
únicos acá. De pronto sacó un arma.]],

	[[El chico comenzó a disparar por la ventana, y yo me escondí
cubriéndome los oídos. ¿Que estaba pasando? ¿Por que me trajo acá? ¿Y que
querría de mí? No lo había visto nunca, ni sabía si iba a lastimarme, pero a la
vista, parecía... un buen chico. Luego oí unos gemidos espeluznantes desde
afuera.]],

	[[Si esos ruidos inhumanos no eran de gente... Entonces tal vez no
había despertado de ningún sueño. Pero no, debía confirmarlo. Entré con sigilo
a la cocina y me acerqué a la ventana. El chico estaba demasiado pendiente de
lo que había afuera para notar mi presencia.]],

	[[Por primera vez ví a las criaturas en directo. Eran dos personas con
una nauseante piel verde petroleo oscuro, el pelo casi completamente caído.
Sangraban un espeso liquido marrón al ser impactados, pero a pesar de que el
chico había derribado al mas pequeño a tiros, este seguía moviendose.]],

	[[Las manos del chico temblaban. No sabía si le quedaban balas para el
mas grande. Entonces recordé que seguía con la ropa mía puesta. Busqué en mis
bolsillos. Aún poseía mi navaja.]],

	[[Llamé al chico. Esté se sorprendió al verme, pero al ver la navaja lo
único que atinó a hacer fue una gran sonrisa. La tomó de mis manos y salió al
campo de batalla.]],

	{"bgm", "set", "prelude", 1, source=lib.bgm["prelude2.ogg"]},
	[[A pesar del aspecto terrorífico de las criaturas, el movimiento de
estas era torpe y lento. El chico botó el agua de una cubeta y se lo tiró al
grande para distraerlo. Se escabulló por atrás y antes de que la criatura
pudiera atacarlo, le hizo un corte en el cuello.]],

	[[La criatura se mantuvo en pie a pesar de la herida. Se dió vuelta y
golpeó al chico, y este entre forcejeos logró escaparse. Repitiendo su táctica,
el chico arremetió de nuevo, atacándolo ahora con la navaja hasta llevarlo al
suelo.]],

	{"bgm", "mod", "prelude", fade={"fadeout", 1/3, true}},
	[[El chico lo remató con un disparo detrás de la cabeza, e hizo lo
mismo con el pequeño. Con ambos muertos, el chico volvió corriendo a la cocina,
jadeando. Fue cuando se acercó que noté sus ojos marrones.]],

	[[De pelo negro hasta los hombros, un metro setenta y cinco, si parecía
un buen chico... y entonces recordé la nota. El chico habló.]],

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
que solo se había desmayado. Lo sujeté con todas mis fuerzas para que no se
cayera.]],

	[[Logré llevarlo —arrastrarlo— con gran esfuerzo hasta un sillón, y
cuando fuí a recostarlo, descubrí una mancha de sangre formándose atrás en su
polera.]],

	[[Con algunas cosas que encontré en su baño le vendé la herida para que
no sangrara más. Tras haberme traído acá, era lo mínimo que podía hacer por
el.]],

	[[Pasaron unos minutos en que el chico seguía durmiendo. Me pregunté
que haría acá. ¿No habían evacuado? ¿Que pasó con la gente entonces? Las calles
estaban demasiado vacias para que todos se hayan... transformado. No podía
ser.]],

	[[Tal vez aún había oportunidad. Lavé mi navaja con agua caliente y
decidí salir ir a dar una vuelta. Como no encontré un lápiz, le dejé al chico
su misma nota en la mesa antes de partir, con el despertador puesto a las
1:15pm, por si acaso. Al menos, ahora tenía un lugar donde volver.]],
}
