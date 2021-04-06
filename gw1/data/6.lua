return {
	{"name", "María"},
	{"style", "vnMaria"},
	[[No sé en que momento habré semi-despertado, atrapada entre los sueños
y la realidad. Mi cabeza daba vueltas, mi consciencia iba y venía, y una
melodía retumbaba sin fin en mi mente... Me hoztigaba, pero no tanto como el
súbito sonido de un despertador.]],

	{"bg", "add", args={res.gen.clock.alarm(res.style.clockAlarm, 12, 30)},
		color={1,1,1,0},
		tween={"fadein", .25}
	},

	{"wait", 1},

	{"macro", res.gen.sub.date, {2011, 11, 11, 12, 30}},

	{"text", [[Estiré mi mano e hice callar el reloj como volviendo a una
vieja rutina,]], false, true},

	{"bg", "mod", tween={"fadeout", 1/12, true}},
	{"text", [[ antes de caer en la cuenta de que me hallaba en un cuarto,
en una cama. ¿Que lugar era este? No lo reconocía, eso era seguro.]], true},

	[["¿Habrá sido un sueño?" Una sensación de alivio y paz recorrió mi
cuerpo, y solté un suspiro. Recordé esa crisis de pánico. Que bueno que no fue
real. Vivir así sería demasiado terrible... no lo aguantaría de verdad.]],

	[["¿Que hice anoche entonces?" Seguía en una casa desconocida. Habían
posters de bandas de rock en la habitación. Había tambien ropa de chico tirada.
Escuché ladridos. Afuera el viento helado hacía crujir el techo a ratos, pero
aquí estaba protegida de todo aquello. El aire era cálido y acogedor.]],

	[[Ese sueño me dejó tan agotada emocionalmente que hasta me dieron
ganas de dormirme de nuevo, pero no. Noté una nota en el estante junto al
despertador.]],

	{"bg", "add", args={"nota-bake.png"}},
	[["Uno. Me voy y volveré a eso de las doce y media, la alarma está
encendida." Que considerado.]],

	[["Dos. No abuse de ti mientras estabas inconsciente. Ele O Ele."]],

	[[...¿Que?]],

	[[Era tan de la nada que comencé a reir. ¿Quién será este chico? La
nota no estaba firmada por ningún lado mas que con un posdata en otro idioma.
"Alguien culto debe ser," pensé. La dejé de vuelta en el estante pero se
cayó.]],

	{"bg", "rm"},
	[[Mi cabeza aún me dolía por la parte de atrás, ¿pero porque me dolía
si había soñado todo? Traté de hacer memoria.]],

	[[...Guau, de verdad no recordaba nada de la noche anterior. "Ahora si
te las mandaste," me dije a mi misma. Ojalá no haya sido por una fiesta, porque
detestaría haberla olvidado si fue buena. No, y ni hablar del dinero perdido.]],

	[[Me busqué entre el pelo el chichón, y aunque me dolío como los mil y
un demonios al tocarme, no parecía haberme hecho herida ni haberme sangrado,
por lo que asumí que no me haría mal moverme. Me levanté y me acerqué a la
puerta a buscar respuestas.]],

	[[Al abrirla escuché ruidos del primer piso. Cosas golpeándose
violentamente. El buen humor se me fue de inmediato.]],

	[[Yo aquí riéndome de este chico y ni sé aún si es peligroso o no. De
pronto, esa nota no se me hacía tan graciosa.]],

	{"bg", "add", args={"Flash/day.png"},
		color=res.palette("repellantYellow", 0),
		tween={"fadein", 2/3}},
	[[Bajé con cautela los escalones, mientras los ruidos aumentaban en
intensidad. Llegué a una especie de living-comedor. Las cortinas estaban
cerradas. Los ruidos provenían de lo que parecía la cocina.]],

	{"bg", "mod", tween={"fadeout", 2/3, true}},
	[[Me asomé por la puerta a mirar. Había un muchacho tirando cosas por
la ventana, hacia el patio. ¿Será él el dueño de casa? Parecíamos ser los
únicos acá. De pronto sacó un arma.]],

	[[El chico comenzó a disparar por la ventana, y yo me escondí
cubriéndome los oídos. ¿Que estaba pasando? ¿Por que me trajo acá? ¿Y que
querría de mí? No lo había visto nunca, ni sabía si iba o no a
lastimarme, pero a la vista, parecía... un buen chico.]],

	[[Entonces oí entre disparos unos gemidos atroces desde afuera, que
casi me detuvieron el corazón. Si esos ruidos inhumanos no eran de gente...
Entonces tal vez no había despertado de ningún sueño.]],

	[[No, no podía ser cierto, tenía que confirmarlo. Entré con sigilo a la
cocina. El chico estaba demasiado pendiente de lo que había afuera para notar
mi presencia. Miré afuera.]],

	[[Por primera vez ví a las criaturas en directo. Eran dos personas con
una piel nauseabunda, color verde petroleo, con el pelo casi completamente
caído. Sangraban un espeso liquido marrón al ser impactados, pero a pesar de
que el chico había derribado al mas pequeño a tiros, este seguía moviendose.]],

	[[Las manos del chico temblaban. No sabía si le quedaban balas para el
mas grande. Entonces recordé que si esto no era un sueño, debía seguir con las
mismas cosas encima. Busqué en mis bolsillos. Aún poseía mi navaja.]],

	[[Le hablé al chico. Esté se sorprendió al verme tan de pronto, pero al
ver la navaja lo único que atinó a hacer fue una gran sonrisa. La tomó de mis
manos y salió al campo de batalla.]],

	{"bgm", "set", source="prelude2.ogg"},
	[[A pesar del aspecto terrorífico de las criaturas, el movimiento de
estas era torpe y lento. El chico botó el agua de una cubeta y se la tiró por
la cabeza al grande para distraerlo. Se escabulló por atrás y antes de que la
criatura pudiera atacarlo, le inserto la navaja en el cuello.]],

	[[La criatura se mantuvo en pie a pesar del corte. Se dió vuelta y
agarró al chico, y este entre forcejeos apenas logró escaparse. Repitiendo su
táctica, el chico arremetió de nuevo, atacándolo ahora con la navaja hasta
llevarlo al suelo.]],

	{"bgm", "mod", fade={"fadeout", 1/3, true}},
	[[El chico lo remató con un disparo detrás de la cabeza, e hizo lo
mismo con el pequeño. Con ambos muertos, el chico volvió corriendo a la cocina,
jadeando. Fue cuando se acercó que noté sus enormes ojos marrones.]],

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
que se había desmayado. Lo sujeté con todas mis fuerzas para que no se cayera.
Su cuerpo se sentía cálido, a pesar que tenía muy poca ropa para este frio.]],

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

	[[Tal vez aún había tiempo. Lavé mi navaja con agua caliente y
decidí que saldría a dar una vuelta. Como no encontré un lápiz, le dejé al
chico su misma nota en la mesa antes de partir, con el despertador puesto a las
1:15pm por si acaso.]],

	[[Salí dejando la puerta junta para cuando volviera, y el perro del
chico me siguió olfateandome hasta la puerta de la calle, y me miró mientras me
alejaba. Al menos, ahora tenía un lugar donde volver.]],
}
