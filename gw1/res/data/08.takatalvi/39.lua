local gBP = {1,2}
local gFA = {3,4}

local swap = res.fun.vn.charSwap

return {
	{"style", "vnMaria"},
	res.fun.macro.title,

	{"bg", "mod", "root", color={.5, .5, .5, 1}},
	{"bg", "addsub", {}},
	{"name", "María"},
	[[Pipi corrió a olerle los pies a Bake apenas se bajó. Movía la
cola muy rápido, como asustada.]],

	[[Bake y Falcon se miraron, y como entendiendose sin hablar, se
aseguraron de tener las armas cargadas y caminaron hacia la puerta, nosotros
siguiendolos de cerca.]],

	[[Fab venía con su tubo, y Andrea reveló un revólver negro.]],

	{"name", "María"},
	[["¿Sabes disparar Andrea?" le pregunté teniendo que subir la voz. El
viento hacía difícil oír.]],

	{"name", "Andrea"},
	[["Si... pero nunca he acertado."]],

	{"name", "María"},
	[["¿E-Es broma?"]],

	{"name", "Fabian"},
	[["No podemos practicar si tenemos solo 10 balas," dijo Fab. No era
broma. "Acuerdate de no cerrar los ojos antes de jalar el gatillo."]],

	{"name", "María"},
	[[Andrea hizo una mueca. A lo mejor preferir una katana y un tubo era
una decisión mas racional que lo que creía.]],

	[[Nos paramos frente a la puerta, y Bake le hizo una seña con la mano
a Falcon. Hicieron tal como en la farmacia: Falcon abrió de golpe, y Bake
apuntó.]],

	{"bg", 1, "add", args={"maria/living.png"}},
	[[La casa estaba oscura por las tablas, pero no se veía ningún
movimiento adentro. Nos metimos con cautela, sin romper el grupo.]],

	[[El piso de arriba crujía como si fuera a salir volando, y con la
puerta abierta se formó una corriente de aire por la casa. Se filtraba claridad
desde la cocina. Debía estar abierto.]],

	[[Fuera de eso, todo lucía tal cual lo dejamos, así que nos dirigimos
a la cocina con Bake al frente. El se metió de un salto apuntando. Miró al
suelo y guardó el arma. Entramos.]],

	{"macro", "bgFade", "maria/cocina.png"},
	[[Encontramos todo revuelto. La puerta estaba abierta y con la
cerradura destruida. En el suelo habían platos rotos y ollas tiradas al azar.
Habían manchas de sangre junto a la entrada.]],

	{"bg", "addsub", {
		default={draw=f0b.doll.draw, color={1,1,1,0}},
		{args={res.doll.bake, 480, 0, -1}, color={1,1,1,1}},
		{args={res.doll.falcon, 160}},
		{args={res.doll.fab, 180}},
		{args={res.doll.andrea, 480, 0, -1}},
	}},
	{"name", "Bake"},
	[["Pareciera que un bitchy se metió y salió."]],

	{"bg", 2, "fade", 2, {"fadein", 1/12}},
	{"name", "Falcon"},
	[["O a lo mejor subió." Mierda, Falcon...]],

	{"name", "Bake"},
	[["Subamos a ver."]],

	{"bg", 2, "fade", 1, 2, {"fadeout", 1/2}},
	{"name", "María"},
	[[Los dos se fueron a revisar el segundo piso,
mientras Fab se acercaba a mirar la puerta. Este lugar era una pesadilla.]],

	{"bg", 2, "fade", 3, {"fadein", .5}},
	{"name", "Fabian"},
	[["¿Para que se metería y saldría un zombie?" dijo apretando y soltando
el picaporte. Andrea se le acercó evitando los platos rotos.]],

	{"bg", 2, "fade", 4, {"fadein", .5}},
	{"name", "Andrea"},
	[["¿Quizás olió que había comida?"]],

	{"name", "Fabian"},
	[["¿Tu dices gente?" Andrea inclinó la cabeza como diciendo
'Si, también.' Fab parecía mas preocupado de esas preguntas que de como ibamos
a dormir seguros. Andrea solo miraba el desastre.]],

	{"name", "María"},
	[[Primero desaparecen dos cuerpos, luego resulta que hubo una de esas
bestias en la casa del vecino todo este tiempo, y ahora algo se metía a la
fuerza, como si la casa no tuviera seguridad.]],

	{"name", "Andrea"},
	[["María, ¿estas bien?" me preguntó Andrea.]],

	{"name", "María"},
	[["No, no..." Como en forma automática, me acerqué a cerrar la puerta
con el pestillo. Era tonto igual; si la cerradura no aguantó, menos lo haría
esa cosita chica. "Es que..." Es que, ¿que?]],

	[[Los chicos empezaron a susurrar de nuevo, quién sabe sobre que ahora.
Quizás sobre mí, que a diferencia de ellos no podía actuar como si esto fuera
entretenido. Miré los platos rotos en el suelo, y me agaché a limpiar.]],

	{"name", "Andrea"},
	{"text", [["Espera, te ayudo." ]], false, true},
	{"bg", 2, "fade", {"fadeout", .5}},
	{"text", [[Andrea se acercó a recoger también.]], true},

	[["Fab, ve por una escoba." Fab miró hacia todos lados confundido.]],

	{"name", "Fabian"},
	[["Ehh, ¿donde hay una escoba?" Ambos me miraron, pero
yo tampoco sabía. Si, yo era una increíble ayuda.]],

	{"bg", 2, "fade", 3, {"fadeout", .5}},
	{"name", "María"},
	[[Fab salió del cuarto, y pronto volvió con pala y escoba. Andrea
acercó el basurero, y empezaron a hechar todo adentro.]],

	{"bg", 2, "fade", 3, 4, {"fadein", .5}},
	[["¿Como lo hacen?" les pregunté. Se giraron ambos a verme.]],

	{"name", "Andrea"},
	[["¿Que cosa?"]],

	{"name", "María"},
	[["Para estar así de calmados." Los dos se miraron.]],

	{"name", "Andrea"},
	[["Será que nos acostumbramos a estar desprotegidos"]],

	{"name", "Fabian"},
	[["Aja."]],

	{"name", "Andrea"},
	[["Aparte, es como un sueño... Una simple pesadilla," agregó.
"Si estuviera en casa con mis padres, y los viera a ellos asustados, creo que
me asustaría más."]],

	{"name", "María"},
	[["¿Entonces por que yo estoy así?" pregunté apretando los puños.
En eso, Bake y Falcon volvieron.]],

	swap(gBP, gFA, .5),
	{"name", "Bake"},
	[["Ya revisamos."]],

	{"name", "Falcon"},
	[["Y no había nada. Lo que haya sido, solo llegó hasta acá."]],

	{"name", "Bake"},
	{"text", [["Y dudo que hayan sido Croft y Rocco con hambre]],
		false, true},
	{"bg", 2, "fade", 1, {"src", res.doll.bake_xd}},
	{"text", [[ xD"]], true},

	{"bg", 2, "fade", 1, {"src", res.doll.bake}},
	{"name", "María"},
	[["¿Que vamos a hacer entonces?"]],

	{"name", "Bake"},
	[["¿Hacer de que?" preguntó Bake, igual que cuando estaban los dos
cuerpos afuera. Ni siquiera sabía como responderle.]],

	swap(gFA, gBP, .5),
	{"name", "Fabian"},
	[["Que pasa si vuelve a atacar, supongo."]],

	swap(gBP, gFA, .5),
	{"name", "Bake"},
	[["Hablabamos con Falcon que pudo ser por los huesos de pollo que
quedaron."]],

	{"name", "Falcon"},
	[["Si, yo tiré los huesos acá." Falcon se acercó a tomar el basurero,
y lo sacudió para mirar entre los trozos. "¿Ves? Ahora no están."]],

	{"name", "Bake"},
	[["Si, y Pipi no come de la basura, así que solo pudo haber sido eso.
Tendremos que tener mas cuidado."]],

	{"name", "María"},
	[[¿Eso era todo? ¿Esperar que no vuelvan? Y si lo hacían igual, ¿que?
No quería que ninguno terminara como cualquiera de los cuerpos despedazados que
encontramos hoy.]],

	{"bg", 2, "fade", 2, {"fadeout", .5, true}},
	{"bg", 2, "fade", 1, {"mvabs", 400, false, 1}},
	{"name", "Bake"},
	[["¿Nena? ¿Te pasa algo?" me preguntó Bake. Negué con la cabeza, pero
era obvio que mentía; no debia tener buena cara.]],

	[["¿No querés descansar? Ha sido un dia pesado."]],

	{"name", "Bake"},
	[[Ya casi detestaba que me trataran bien, pero terminé asintiendo.
Quizás sería lo mejor, a pesar que no era ni mediodía aún.]],

	{"bg", "fade", "root", {"color", {0,0,0,0}, 1}},
	[[Subí al segundo piso, y me fui a la cama. En el espacio que dejé
desordenado en la mañana, me enrollé, y traté de no pensar en nada.]],
}
