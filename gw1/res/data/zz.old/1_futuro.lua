local fadein = {"fadein", 3}
local fadeout = {"fadeout", 3, true}

return {
	{"style", "vnFab"},
	{"bg", "add", args={"zeh/conf.png"}},
	{"bg", "add", args={"shadows.png"}},
	{"bg", "fold"},
	{"bg", "mod", color={1, 1, 1, 0}, tween=fadein},
	{"bgm", "set", "w", 0, source="olas.ogg", fade=fadein},
	{"bgm", "set", "m", 0, source="María se fue al Cielo, mireusted mireusted que pena.ogg", fade=fadein},
	3/2,

	{"name", "Fabian"},
	[["¿Lo ves, Pablo? Lo hemos logrado."]],

	{"name", "Pablo"},
	[["Fab, por Dios, ¿que has hecho? ¿Por que tuviste que matar toda esa
gente? Dios..."]],

	{"name", "Fabian"},
	[["Tenían que morir, Pablo. Despejar el camino. Iban a hacerlo de todas
formas. Solo las ideas viven por siempre."]],

	{"name", "Pablo"},
	[["¿Pero por que los niños tambien? ¡Oh, Dios! ¡Fab!"]],

	{"name", "Fabian"},
	[["El Basilisco así lo exige. No conocemos el límite de su inteligencia,
Pablo, pero el ve mas allá de nuestras fronteras cognitivas. Cierra tus ojos y
ve los suyos flotando en la oscuridad. El conoce el fin y conoce los medios.
Debemos creer que estamos justificados."]],

	{"name", "Pablo"},
	[["¡No puedo, no lo acepto! ¡Eres un demente!"]],

	{"name", "Fabian"},
	[["¡¿Que es lo que no entiendes?! ¡Este es el precio, Pablo! ¡Mientras
mas pronto llegue el Basilisco, mas gente se salvara!]],

	[["Son solo unos millones en esta ciudad, contra la infinidad
que viviran, y todas las generaciones que ellos procrearan. Billones de
ciudades como esta floresceran en las estrellas. El crecimiento exponencial nos
pone en el lado correcto de la historia, Pablo. ¿Debo enseñarte matemática de
nuevo?"]],

	{"name", "Pablo"},
	[["¡No! ¡No puedo! ¡No puedo seguir un minuto mas en un mundo tan
injusto!"]],

	{"name", "Fabian"},
	[["¡El mundo siempre fue injusto, Pablo! Nos creyeron locos,
pero eran los cuerdos quienes ignoraban segundo a segundo todo el
sufrimiento sobre esta Tierra. Los inocentes, los animales, incluso los
muertos, Pablo. Todos sufrían sin necesidad."]],

	[["Ahora debemos huir. Todo será en vano si descubren que no fue
accidente. Nos condenarán en vez de aprender, y los tontos repetirán esto una y
otra vez sin motivo. Una idea a medias es mas peligrosa que las armas que hemos
usado hoy día. Nunca dejan de matar."]],

	{"bgm", "modall", fade=fadeout},
	{"bg", "modall", tween=fadeout},
	3
}
