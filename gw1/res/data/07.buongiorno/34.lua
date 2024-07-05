local function bakeRebotando(vol)
	return {"read", {
		{"sfx", "freesound/427563__tbone1999__doorhit.flac", vol, .9},
		{"sfx", "freesound/346694__deleted_user_2104797__body-fall_02.flac", vol, 1, .35},
		{"sfx", "freesound/547580__fmaudio__hitting-cabbage-against-wooden-door-frame-1.flac",
			vol,1,.6},
	}}
end

return {
	{"style", "vnMaria"},
	{"macro", "titleDate", {2011, 11, 13, 9, 13}},

	{"bg", "mod", "root", color={3/4, 3/4, 2/3, 1}},
	f0b.table.union(res.fun.gfx.comedor2(), {"bg", "add"}),
	{"bg", "addsub", {
		default={draw=f0b.doll.draw},
		{args={res.doll.sillas, 320}},
		{args={res.doll.falcon, 160}},
		{args={res.doll.bake, 480, 0, -1}},
	}},
	{"macro", "mesa", false, "add"},
	{"name", "Bake"},
	[["Ahh, delicioso," dijo Bake tras acabarse el último pedazo de pollo.
"¿Que hacemos ahora?"]],

	{"name", "María"},
	[["Estamos de nuevo sin comida," reclamé.]],

	{"name", "Bake"},
	[["Verdad. Habrá que ir de shopping de nuevo, lol. ¿Vamos ahora o
cuando nos dé hambre?"]],

	{"name", "María"},
	[["¿Como que--? ¡Ahora tiene que ser!"]],

	{"name", "Bake"},
	[["Es que tiene pinta de nevar, por eso digo xD"]],

	{"name", "Falcon"},
	[["Ehh, no puede ser ahora. Estamos sin batería."]],

	{"name", "Bake"},
	[["Verdad. La agotamos con los amplis xD"]],

	{"name", "María"},
	[["¿QUE?"]],

	{"name", "Bake"},
	[["Contabamos con que hariamos puente con la camioneta de
Croft xD Estamos varados y sin amplis xdd"]],

	{"bg", 2, "fade", {"src", res.doll.bake_xd}},
	{"name", "María"},
	[["Bake..." dije con una necesidad asesina surgiendo de mi. Falcon se
levantó.]],

	{"bg", 2, "fade", {"src", res.doll.bake}},
	{"bg", 2, "fade", 2, {"mvdiff", false, -120, 1/3}},
	{"name", "Falcon"},
	[["Tranquila, que ese coche ya se iba a desarmar solo," dijo mientras
se ponía abrigo, y miró a Bake. "¿Se enojarán tus vecinos si les
sacamos un carro?"]],

	{"bg", 2, "fade", {"mvdiff", false, -120, 1/3}},
	{"name", "Bake"},
	[["Hmm, nah xD Vamos."]],

	{"bg", "addsub", {
		{args={"maria/living.png"}, fade={"fadein", 1}},
	}},
	{"name", "María"},
	[[Los chicos se dirigieron a la puerta, y yo me apresuré en ponerme
abrigo para ir con ellos. Estabamos saliendo cuando Bake se detiene de golpe,
y chocamos Falcon y yo con el.]],

	{"bg", "rm", 1, 3},
	{"bg", "sync"},
	{"bg", "addsub", {
		default={draw=f0b.doll.draw},
		{args={res.doll.bake, 160}},
	}},
	{"name", "Bake"},
	[["lol, mierda," dijo dando un salto.]],

	{"bg", 2, "fade", {"fadeout", 1/12}},
	{"name", "María"},
	[[Miramos al suelo y había un regalito de Rocco justo frente a la
puerta, y para variar ya tenía dibujada una suela de zapato. Lo rodeamos y
salimos a la calle, con Pipi olfateándonos los pies.]],

	{"bg", 1, "fade", {"fadeout", 1, true}},
	[[Fuimos a la casa del vecino. Sin perder el tiempo Bake escaló el
portón y se metió de un salto.]],

	[[Parecía que ya estaba mejor de la espalda, o por lo menos no le
impedía moverse. Movió un par de fierros adentro y nos abrió. Lo primero que
vimos fue una camioneta en la cochera.]],

	{"bg", 2, "fade", {"fadein", 1/12}},
	{"bg", 2, "add",
		args={res.doll.falcon, 480, 0, -1}, fade={"fadein", 1/12}
	},
	{"name", "Bake"},
	[["Vos sabés robar carros, ¿verdad?"]],

	{"name", "Falcon"},
	[["No porque sepa hacerlos partir voy a saber abrirlos," respondió
ofendido. "Pero dejame probar."]],

	{"name", "María"},
	[[Falcón se acercó a inspeccionar la puerta. Cerca había una mesa con
un montón de herramientas, así que Falcon tomó un destonillador y se puso a
meterlo en la cerradura.]],

	[[Y en fin, parece que estaba en lo correcto porque tras unos segundos
admitió que no tenía idea de lo que hacía.]],

	{"name", "Bake"},
	[["¿Que tal si rompemos una ventana?"]],

	{"name", "María"},
	[["¿Estás loco? Nos congelaríamos como ayer."]],

	{"name", "Falcon"},
	[["Es verdad."]],

	{"name", "Bake"},
	[["xdd ¿entonces que, buscamos en otro lado?"]],

	{"name", "Falcon"},
	[["Bueno, como el carro está acá pueeeede que estén las llaves en la
casa."]],

	{"name", "Bake"},
	[["Bien pensado. ¿Como abrimos la puerta?" Por la mier--.]],

	{"name", "Falcon"},
	[["Pos con las armas." Los tres miramos la puerta.]],

	{"name", "Bake"},
	[["No gastemos municiones. Dejá."]],

	{"bg", 2, "fade", 1, {"fadeout", 1/12}},
	{"name", "María"},
	[[Bake agarró vuelo y se lanzó con el hombro a derribarla.]],

	bakeRebotando(1),
	[[Con un golpe seco Bake rebotó en la puerta, y luego en el suelo.]],

	{"name", "Bake"},
	[["Hoooly shit!" dijo agarrándose el hombro, revolcándose con lo que
parecía una risa adolorida. Falcon se golpeó la frente con la palma. Yo ni eso
pude hacer.]],

	{"name", "María"},
	[["Dios mío," dije atónita. No ibamos a llegar a ningún lado a este
ritmo.]],

	{"name", "Bake"},
	[["D-Dejá que me recupere," dijo tendiendose, pero se retorció de nuevo
cuando la espalda le tocó el suelo. "Oww, bitchy bitch."]],

	{"name", "María"},
	[["Voy a revisar las ventanas, ¿les parece?"]],

	{"name", "Falcon"},
	[["Anda, yo lo cuido."]],

	{"bg", 2, "fade", {"fadeout", 1}},
	{"name", "María"},
	[[Mientras Bake se regeneraba empecé a rodear la casa en busca de algo
abierto o alguna llave bajo un florero.]],

	[[Desgraciadamente no fue así. Las ventanas del primer piso tenían
todas protección, y por mas que revisé no encontré ninguna llave por ningún
lado.]],

	[[Cuando terminaba de dar la vuelta por atrás, encontré una ventana de
baño. Estaba cerrada, pero sin rejilla.]],

	[["Acá hay una," grité. Solo necesitaba algo donde subirme. Falcon
se acercó a mirar.]],

	{"bg", 2, "fade", {"fadein", 1/12}},
	{"name", "Falcon"},
	[["¿Está abierta?"]],

	{"name", "María"},
	[["No. Pensaba romperla." Falcon la miró dudoso y sacó de nuevo el
destornillador.]],

	{"name", "Falcon"},
	[["Dame un momento. Si es de las que creo que son, la voy a
poder abrir."]],

	{"bg", 2, "fade", {"fadeout", 1/12}},
	{"name", "María"},
	[[Mientras Falcon que era mas alto la revisaba, fui al garage a buscar
una silla. Bake seguía en el suelo de concreto, sin interés por levantarse en
el corto plazo. Era como su segunda siesta.]],

	[["Bake, te vas a enfermar."]],

	{"name", "Bake"},
	[["Naah."]],

	{"name", "María"},
	[[Cuando volví Falcon hacía palanca con el destornillador metido entre
ambas ventanas. Trataba de mover algo.]],

	{"bg", 2, "fade", {"fadein", 1/12}},
	{"name", "Falcon"},
	[["Está el seguro justo ahí detrás. Vé si puedes quitarlo."
Me subí y empecé a probar suerte.]],

	{"name", "María"},
	[[La ventana era de ese cristal que no dejaba ver casi nada, pero
distinguía parte del seguro por dentro. Me impresionaba que siendo tan comunes
se pudieran abrir tan fácil.]],

	[[Fácil relativamente, porque se hizo evidente que esto exigiría
bastante paciencia.]],

	{"bg", 2, "fade", {"fadeout", 1/12}},
	[[Tras dos minutos de lento progreso Falcon se fue a ver a Bake que
seguía sin levantarse. Yo persistí hasta que logré desbloquearla.]],

	[["¡La abrí! Voy a entrar," avisé.]],

	[[Como iba a caber por ahí, no sabía. Estaba levantando el pie
cuando la cadera me recordó que estaba atropellada. Auuuch...]],

	[[A duras penas logré pasar la pierna, contorsionarme metí la cabeza, y
tuve que colgarme para bajar porque justo estaba el estanque del inodoro
debajo, y no quería descubrir si iba a aguantar mi peso.]],

	[[Bajé y terminé con los rieles marcados en las manos, pero fue todo
extrañamente divertido.]],

	[[Me miré de casualidad en el espejo. Era increíble como llevaba como 6
días con la misma ropa.]],

	[[Estaba bien mal, de hecho. Mi pelo estaba grasoso y tenía unas ojeras
terribles. Ni en mis momentos mas bajos recordaba haberme visto así.]],

	[[¿Que hubiera pasado si me hubiera quedado en casa? Papá, hermano...]],

	[[No sé como de un momento a otro pasé al borde de las lágrimas. Dios,
este no era el momento para ponerme melancólca.]],

	[[Me abofeteé las mejillas, y pensé en Bake para sacarme la pena de la
mente. Bake rebotando contra la puerta.]],

	bakeRebotando(.5),
	1,
	[[Con eso recuperé un poco el ánimo.]],

	[[Abrí la puerta del baño que daba a un pasillo, y de inmediato
retrocedí ante un nauseante olor a carne descompuesta. Algo andaba mal. Algo
andaba muy mal aquí adentro.]],

	[[Agarrando aire, caminé hacia donde había mas claridad, suponiendo que
así llegaría al living. Quería encontrar rápido una puerta para salir. Giré en
la esquina.]],

	[["¡AAAAAAAAH!"]],

	[[Retrocedí hasta chocar con la pared. El medio del living habían dos
cuerpos a medio deborar sobre un charco de sangre.]],

	{"name", "Falcon"},
	[["¡María! ¡¿Que pasa?!" gritó Falcon desde afuera.]],

	{"name", "María"},
	[[Me devolví para escapar por el baño, cuando desde el extremo oscuro
del pasillo se levantó una de esas criaturas, sus ropas teñida de sangre.]],

	[[La criatura corrió tras de mí, y yo huí al living gritando. Los
chicos golpeaban la puerta y me llamaban.]],

	[[Me dirigí sin pensar a unas escaleras y las subí a saltos. Me tropecé
y me golpée con un escalón en la frente, pero el rugido de la criatura
a punto de tomarme me hizo levantarme y seguir corriendo.]],

	{"name", "Bake"},
	[["¡MARÍA!"]],

	{"name", "María"},
	[[Llegué al segundo piso y me metí a la primera habitación que vi
abierta. Alcancé a cerrar la puerta antes que la criatura la embistiera con
todo su peso, botando los cuadros que estaban colgados. Estaba a oscuras.]],

	[[La bestía gemía mientras golpeaba. El cuarto se estremecia entero,
cayeron cosas de los muebles.]],

	[[Me apoyé contra la puerta para que no se rompiera, pero la criatura
se lanzó de nuevo e hizo crugir la madera. No sabía cuanto iba a resistir. El
olor a muerte me tenía al borde del vómito.]],

	[[De prontó oí disparos.]],

	{"name", "Falcon"},
	[["¡Para! ¡María está adentro!"]],

	{"name", "Bake"},
	[["¡A la mierda!" Oí otro disparo, y de una patada abrieron la puerta
de abajo. "¡María!" Los chicos entraron.]],

	{"name", "Falcon"},
	[["¡Santo Dios!" exclamó Falcon. La criatura se devolvió a la
escalera. "¡Allá arriba!"]],

	{"name", "Bake"},
	[["¡Vení a morir!" La criatura saltó por las escaleras, y se
oyeron mas disparos y gritos.]],

	{"name", "María"},
	[[Todo quedó en silencio por unos momentos, en que solo escuchaba mis
propios latidos. De pronto unos pasos fuertes resonaron por las escaleras.]],

	{"name", "Bake"},
	[["¿María?" me llamó Bake al subir. Las manos me temblaban tanto que
me costó tomar el seguro. Lo quité, y al abrir la puerta me encontré con la
mirada de Bake. Yo no podía hablar.]],

	[["¿Estás bien? ¿Que te pasó en la frente?" me preguntó al salir.]],

	{"name", "María"},
	[["M-Me caí en las escaleras," dije. Había estado demasiado asustada,
me sentía bloqueada. Bake me sonrió.]],

	{"name", "Bake"},
	[["Nena, vas a perder la cabeza si seguís así." Reí nerviosa. Tenía
razón. "¿No te pasó nada mas?"]],

	{"name", "María"},
	[["No, no... Me alcancé a esconder..." Fui a mirar a la habitación
cuando Bake me toma la cabeza.]],

	{"name", "Bake"},
	[["Nena, está bien. Salgamos de acá," dijo haciéndome andar.]],

	{"name", "María"},
	[[Bajamos al primer piso, donde estaba Falcon con su arma en la mano.
A los pies de la escalera estaba el cuerpo inerte de la criatura.]],

	{"name", "Falcon"},
	[["Vamos," dijo guiando el paso. Lo seguí hasta la cocina donde estaba
la salida al garage. La puerta estaba abierta por completo, la cerradura estaba
hecha añicos.]],

	{"name", "María"},
	[[Falcon de pronto se giró con su arma. Me sobresalté, pero era para
tomar un juego de llaves que estaban colgados.]],

	[[Salimos y sin perder el tiempo Falcon abrió la camioneta. Nos subimos
los tres; Bake de copiloto, y yo atrás. Falcon la hizo andar y partimos.]],
}
