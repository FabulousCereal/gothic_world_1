local mv = res.fun.macro.mv

return {
	{"style", "vnMaria"},
	{"macro", "titleDate", {2011, 11, 13, 13, 59}},

	{"bg", "mod", "root", color={0,0,0,0}, fade={"color", {3/4,3/4,3/4,1}, 1}},
	{"bg", "addsub", {
		res.fun.gfx.comedor2(),
	}},
	{"bg", "addsub", {
		default={draw=f0b.doll.draw},
		root={color={1,1,3/4,1}},
		{args={res.doll.sillas, 0, 0, 1, 1, -480}},
		{args={res.doll.bake, 0, 0, 1, 1, 60, -20}},
		{args={res.doll.fab, 0, 0, -1, 1, 320}},
		{args={res.doll.andrea, 0, 0, -1, 1, 640}},
	}},
	{"macro", "mesa", false, "add"},
	{"bg", "fade", 3, {"mvdiff", 80, false, 0}},
	{"name", "María"},
	[[El mal clima seguía cuando nos sentamos al fin a comer. Falcon seguía
en cama, y yo ya me había acostumbrado a la sensación de que el viento hecharía
la casa abajo en cualquier segundo.]],

	{"name", "Fab"},
	[["Ehh, entonces...", dijo Fab tras terminar.]],

	[["Traía comida contando con que sería para los dos, pero ahora que
somos mas, no nos va a durar mucho. Asumiendo que Falcon siga vivo para comer,
debería alcanzarnos hasta... mañana por la mañana."]],

	{"name", "María"},
	[["O sea que debemos salir por mas." Fab asintió.]],

	{"name", "Andrea"},
	[["Eso o practicar canibalismo." Dios.]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Ok. ¿Salimos ahora o cuando nos dé hambre?" Bake preguntó mirándome
a mi. Yo no tenía idea esta vez.]],

	{"name", "María"},
	[["¿No es peligroso con la tormenta?"]],

	{"name", "Bake"},
	[["Puede que lo sea. No sé si te acordás vos Andrea, pero cuando era
chico el frio duraba una semana y caía mucha nieve. Si las calles se tapan, no
podremos salir en coche mas tarde."]],

	mv(-120, 1),
	{"name", "Andrea"},
	[["Es verdad, eso pasaba cada año. Aunque cuando era chica era lo que
mas me gustaba."]],

	{"name", "Fabian"},
	[["¿Por que? ¿Salias a jugar con nieve?"]],

	{"name", "Andrea"},
	[["Jugaba en casa, porque no había clases."]],

	{"name", "Fabian"},
	[["Aaah." Comenzaba a sospechar que Andrea no disfrutó mucho de la
escuela.]],

	{"name", "Andrea"},
	[["Pero en cualquier caso es cierto. Deberíamos ir ahora, si o si."
Los chicos parecian estar de acuerdo en eso. A mi me desagradaba la idea de
salir con este frio, pero evidemente no había opción.]],

	{"name", "María"},
	[["Debimos habernos abastecido mejor hace unos días," suspiré.]],

	mv(120, 1),
	{"name", "Bake"},
	[["Si, siempre perdiamos tiempo en otras cosas," se lamentó también
Bake.]],

	{"name", "María"},
	[["Si, como meter guitarras y amplis al auto ¬¬"]],

	{"name", "Bake"},
	[["No, eso era esencial xD Es por nuestra cordura xDD" '¿Que había de
la cordura mía?' pensé.]],

	{"name", "Fabian"},
	[["Ejem, ¿vamos a volver a la Avenida?" Bake sonrió.]],

	{"name", "María"},
	[["Bake, no," dije antes que dijera una palabra.]],

	{"name", "Bake"},
	[["Es que igual necesitamos cosas para los mareos y la fiebre de
Falcon. No se nos ocurrió buscar esas cosas en la farmacia."]],

	{"name", "María"},
	[["¡De ninguna forma vamos a volver a esa farmacia!" le reclamé de
inmediato. Bake se sorprendió un poco.]],

	{"name", "Bake"},
	[["No estaba diciendo que fueramos a esa."]],

	{"name", "María"},
	[["Bueno... igual no creo que siga habiendo comida en la Avenida."]],

	mv(-120, 1),
	{"name", "Andrea"},
	[["Nosotros sabemos donde hay."]],

	mv(0, 1/2),
	{"name", "Fabian"},
	[["Si no les importa comer arroz y fideos con salsa una semana,
claro."]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Pueeede que nos moleste xD ¿Es mucha?"]],

	{"name", "Fabian"},
	[["Mas o menos. Es un almacén de barrio que está algo escondido. De ahí
sacamos lo que traíamos."]],

	{"name", "Bake"},
	[["Suena perfecto. ¿Queda muy lejos?"]],

	{"name", "Fabian"},
	[["Queda cerca... de la Avenida. Por eso preguntaba xd"]],

	{"name", "Bake"},
	[["lol, todo vuelve al inicio. ¿Quieren mate?"]],

	{"name", "Fabian"},
	[["¿Hay té?"]],

	{"name", "Bake"},
	[["Solo mate y café en esta casa xD" Fab entrecerró los ojos.]],

	{"name", "Fabian"},
	[["¿Es bueno el mate?"]],

	{"name", "Bake"},
	[["Por algo lo toman."]],

	{"name", "Fabian"},
	[["Entonces dale xd"]],

	mv(-120, 1/2),
	{"name", "Andrea"},
	[["Oye, pero si sales al frío después de tomar mate se te enchueca la
boca. Eso decía mi mamá."]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Aw shit, es verdad xDD ¿Que hay del café?"]],

	mv(-120, 1/2),
	{"name", "Andrea"},
	[["No, del café no decía nada." Dios.]],

	mv(0, 1/2),
	{"name", "Fabian"},
	[["No sé, igual desconfío xD"]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Si, mejor xD Entonces no perdamos tiempo. Salgamos ahora mismo,"
dijo levantándose.]],

	{"bg", 2, "fade", 1, {"mvdiff", false, 60, 1/3}},
	{"bg", "fade", 3, {"mvdiff", false, 60, 1/3}},
	{"name", "María"},
	[["Espera, ¿ahora ahora?" Los chicos se levantaron también, tomando
sus abrigos.]],

	{"name", "Bake"},
	[["Obvio. ¿Que pensás hacer?"]],

	{"name", "María"},
	[["Falcon aún está en cama. No podemos dejarlo solo."]],

	{"name", "Bake"},
	[["Pero si esperamos a que despierte vamos a salir a la hora de ayer."]],

	{"bg", "sync"},
	mv(0, 1/2),
	{"name", "Fabian"},
	[["María tiene razón, debería quedarse uno a cuidarlo," señaló Fab.
"O dos, de hecho." Nos miramos por un momento entre los cuatro. Tenía razón.
Solo dos necesitaban ir.]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Bueno, ¿te querés quedar, nena?" me preguntó.]],

	{"name", "María"},
	[[Entendí, por el tono de voz, por la mirada de los chicos, que
esperaban que me quedara guardada en casa. Era para lo único que servía.]],

	[["Es que..."]],

	mv(-120, 1/2),
	{"name", "Fabian"},
	[["Andrea, ¿quieres ir tu o me quedo yo?"]],

	{"name", "Andrea"},
	{"text", [["Pienso que--..." ]], false, true},
	{"bg", 2, "fade", 4, {"src", res.doll.andrea_fome}},
	{"text", [[Andrea se detuvo y le lanzó una breve mirada, una
expresión de que no era la primera vez que oía ese chiste. ]], true, true},
	{"bg", 2, "fade", 4, {"src", res.doll.andrea}},
	{"text", [["Deberiamos ir los tres, porque afuera es mas peligroso."]],
		true},

	mv(0, 1/2),
	{"name", "Fabian"},
	[["Es que si pasa algo, María tendría que defenderse sola. Sería mejor
dos y dos," argumentó. "O si te acuerdas del lugar puedes ir tú y--"]],

	{"name", "María"},
	[["No he..." lo interrumpí, insegura, "dicho que quiera quedarme."]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["¿Entonces vas?"]],

	{"bg", 2, "fade", 4, {"src", res.doll.andrea_fome}},
	{"name", "María"},
	[["Si. Quiero ir," pronuncié. Los chicos me miraron en silencio.]],

	mv(-120, 1/2),
	[[Andrea colgó su poncho en la silla, y quedó decidido.]],

	mv(120, 1/2),
	{"name", "Bake"},
	[["Salgamos rápido entonces."]],

	{"name", "María"},
	[["Solo déjame avisarle a Falcon primero."]],

	{"macro", "bgFade", "maria/pasillo.png"},
	{"bg", "fade", 2, 3, {"fadeout", 1, true}},
	[[Mientras los chicos juntaban sus armas, yo me dirigí al segundo piso.
La puerta de Falcon seguía cerrada, así que la abrí con cautela y miré adentro.
Seguía en cama.]],

	{"macro", "bgFade", "maria/pieza.png"},
	[["Falcon," susurré. El se movió. "¿Estás despierto?"]],

	{"name", "Falcon"},
	[["¿M-María?" balbuceó girándose. Se veía pálido. Me acerqué
tratando de no hacer ruido.]],

	{"name", "María"},
	[["Vamos a ir por comida ahora," dije arrodillándome junto a la cama.
"¿Necesitas algún medicamento? Aparte de antivirales."]],

	{"name", "Falcon"},
	[["¿Que... que hay de la tormenta?"]],

	{"name", "María"},
	[["Volveremos rápido, no te preocupes. Andrea se va a quedar a
cuidarte."]],

	{"name", "Falcon"},
	[["B-Bueno," respondió debil. "No me sé los nombres... pero si hay algo
para los mareos y la fiebre... traigan eso xd"]],

	{"name", "María"},
	[["Está bien."]],

	{"name", "Falcon"},
	[["Y-Y también..." dijo antes que me levantara. "U-Un afinador de
guitarra," dijo formandosele una sonrisa. "Bake tiene... un oido de mierda
x...xD"]],

	{"name", "María"},
	[[Por mas ridículo que me pareciera todo eso de la banda, no pude
evitar sonreír.]],

	[["Buscaré uno sin decirle, ¿ok?"]],

	[[Falcon asintió debil. Una ráfaga de viento azotó el segundo piso, y
que le dí un beso en la frente. El me miró sorprendido.]],

	[["Chao."]],

	{"bg", "fade", {"fadeout", 1, true}},
	[[Corrí escalera abajo. El esguince me dolía, pero el tiempo se
acababa al parecer.]],

	{"bg", "add", args={"maria/living.png"}, fade={"fadein", 1}},
	[[Los chicos estaban junto a la puerta esperándome. Bake tenía la
katana y Fab su tubo. Andrea esperaba junto a ellos.]],

	[[Me abrigué rápido, tomé el bate, y abrimos. El viento entró con
fuerza, y la nieve nos golpeó en la cara.]],
}
