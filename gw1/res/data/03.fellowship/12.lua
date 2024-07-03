local pipiElPerroMaravilla = {
	[[Pipi... ¡Pipi! Pipi dormía en una cama. Fui desenrollándome de a poco
mientras recuperaba la sensación del cuerpo, ya que el frío casi me había
paralizado, y caminé torpemente hasta la puerta bajo la escalera. La abrí.]],

	{"bg", "mod", fade={"fadeout", 1, true}},
	[[Me encontré con lo que pareció haber sido la habitación de una mujer.
El lugar olía a perro, literalmente, pero alli estaba Pipi envuelta en
frazadas.]],

	[[Con el olor se me había ido el entusiasmo, y ni pensar en todos los
pelos que botan y quizás que otras cosas más, pero era mejor que morir de
hipotermia. Empecé a mover a Pipi de lugar.]],

	{"name", "Pipi"},
	[["¿Gau?" bostezó.]],

	{"name", "María"},
	[["Hazme un espacio, Pipi. Me muero del frío."]],

	[[Empujé a Pipi y desarmé su nido para meterme bajo las frazadas. Pipi
se empezó a agitar y a gruñir. "Pipi, solo soy yo."]],

	[[Toda la cama se sentía rara al tacto, no sé si por los pelos
o que se yo, y el olor era un tema aparte, pero poco pude pensar en eso porque
Pipi empezó a ladrarme de pronto.]],

	{"name", "Pipi"},
	[["¡Grrr! ¡Guau! ¡Guau!"]],

	{"name", "María"},
	[["¡Shh, Pipi! Vas a despertar a los chicos," dije tratando de calmarla.
Pipi ladró mas fuerte aún. "¡Pipi!" Intenté cerrarle el hocico.]],

	[[Pipi se calló y dejó de moverse, y pensé que a lo mejor ya me había
reconocido. Me acomodé en la cama, pero Pipi se me apegó de inmediato.]],

	[["Pipi, quisiera algo de espa--" De pronto sufrí un fuerte dolor que
me estremeció el cuerpo. Pipi me había agarrado el cuello.]],

	[[No pude reaccionar. No pude gritar. Pipi gruñó y traté de apartarla,
alejar su cabeza, pero Pipi me soltó solo para morderme con mas firmeza.]],

	[[De mis gritos solo se oyeron gárgaras. Empecé a ahogarme con un
liquido, y solo en mi desesperación Pipi me soltó.]],

	[[Solo alcancé a sentir algo cálido cuando traté de tocarme el cuello,
mientras dejaba de sentir mi cuerpo.]],

	[[La fuerza se me iba, el liquido brotaba a golpes y ya no podía
moverme. Me desmayaba. Alcancé a oír unas voces en la puerta, a ver una luz y
unas sombras, y...]],

	{"bg", "mod", "default", color={1,1,1,1}},
	{"macro", "badend", 1},
	{"return", false},
}

local soyMuyTestaruda = {
	[[Cerré los ojos y redoblé mis esfuerzos. Ya ni sabía que era lo que
quería demostrar, pero seguía decidida. Me puse a contar ovejas.
Si o si tenía que llegar hasta la mañana.]],

	[[Terminé quedando en una especie de limbo, en que a veces soñaba con
las bestias, con los chicos, con mi vida anterior, en que a veces despertaba
sobresaltada con las ráfagas, con el crugir de la casa, con el frío.]],

	[[En que a veces soñaba con el océano negro. El viento se oía igual que
las olas en la playa.]],

	[[Así pasé por horas, en ese purgatorio en que a cada minuto sentía que
no podría soportar el siguiente. Resistí.]],

	[[Creí que soñaba cuando veía la luz, y creí que despertaba aún en la
oscuridad, perseguida por esa sombra. Luego unos pájaros cantaron, y me dí
cuenta de que podía ver mis manos. Asomé la cabeza. Estaba amaneciendo.]],

	[[Y no había dormido nada.]],

	[[Aliviada porque la temperatura pronto empezaría a subir, me dije
que ahora lograría conciliar bien el sueño, que descansaría algo por fin. Que
ingenua.]],

	[[A los minutos escuché que unos de los chicos se bajaba de un salto de
la cama, estremeciendo toda la casa.]],

	{"name", "Bake"},
	[["Oh, bitchy-bitch. Me dolió xD"]],

	{"name", "María"},
	[[Con pasos fuertes Bake bajó la escalera lleno de energía, casi a
saltos.]],

	{"name", "Bake"},
	[["Shit, María está durmiendo xD" dijo deteniéndose en seco, y se fue
a la cocina tratando de no hacer ruido. Venía en boxers y camisa como si fuera
verano.]],

	{"name", "María"},
	[[Evidentemente, había perdido la noche.]],
}

local soyTestaruda = {
	[[Ninguna otra opción me gustaba. Padecía la combinación mortífera de
principios y porfía, así que de una u otra forma esto tenía que funcionar.]],

	[[Me enrollé en posición fetal y me hice un nido encima de un solo
cojín. No iba a acostarme con ningún chico, ni aunque tuviera que dormir acá
con la frente pegada a las rodillas. Intenté hacerme dormir rápido antes que el
frío y el dolor me impidieran hacerlo.]],

	[[No sé si lo logré, si lo hice no se cuanto duré, pero de todas
formas, al rato estaba despierta de nuevo. Afuera seguía oscuro y yo temblaba
sin control, al punto que sentía hasta ganas de vomitar. No sabía la hora. No
sabía cuanto faltaba para la mañana.]],

	[[Mi cuerpo se sentia hecho de hielo y me rogaba buscar calor, el
estruendo del viento se asemejaba a un huracán a punto de golpear la casa. No
aguantaba más.]],

	{"select", "quien", {
		[[Fue divertida esta aventura pero ahora si me voy con Bake.]],
		[[Ir con Falcon antes de perder los dedos.]],
		[[Si dormi un poco, puedo hacerlo de nuevo.]],
		[[Dormir... con Pipi.]],
	}},
	{"case", "quien", {
		{
			[[Las piernas y brazos los tenía como pegados, tampoco
			podía enderezar la espalda. No sé como logré pararme y
			caminar en la oscuridad hasta la pieza de Bake.]],

			{"bg", "mod", fade={"fadeout", 1, true}},
			[[El viento prácticamente azotaba las paredes aquí
			arriba, pero Bake dormía plácido como tronco. Que puta
			envidia.]],

			[[Le dí la vuelta a la cama, haciendo crugir todo el
			piso, y me metí del otro lado. La cama entera estaba
			calentita, o quizás era que yo no podía estar mas
			congelada. Ah, Dios...]],

			[[Mis preocupaciones quedaron todas olvidadas cuando
			noté que el calor de la cama radiaba de Bake, y sin
			dudarlo terminé casi pegada a el a pesar de su
			espalda.]],

			[[Allí quedaron mis principios, en la basura.
			zzzzZZZZZZzzzz...]],
		},
		{
			[[Fue un suplicio salir de donde estaba, tenía cada
			coyuntura fija en su lugar.]],

			{"macro", "rFade", "maria/pasillo.png"},
			[[Tras un arduo trabajo para levantarme y caminar,
			llegué al segundo piso, que parecía a punto de salir
			volando por el viento tormentoso. Me metí a oscuras a
			la habitación de Falcon.]],

			{"macro", "rFade", "maria/pieza.png"},
			[[Estaba durmiendo mirando hacia la pared, tapado hasta
			la cabeza y ocupando tan solo la mitad de esa estrecha
			cama. Gracias Falcon, eres un santo.]],
			
			[[Sin dudarlo un segundo empecé a meterme, con cuidado
			de no despertarlo o pasar a llevarle el pie o alguna
			herida, quedando espalda con espalda. Suspiré...]],

			[[Me había vendido por completo por un poco de calor, y
			no me importaba en lo mas mínimo.
			"zzzzZZZZzzz", ronqué.]],
		},
		soyMuyTestaruda,
		pipiElPerroMaravilla,
	}},
}

local camaDeFalcon = {
	[[Tenía mis dudas sobre dormir con Falcon, pero sinceramente, era
lo mismo fuera con quien fuera. Dejé mejor a Bake y su espalda tranquilos y
entré a su habitación, ahora de Falcon.]],

	{"macro", "rFade", "maria/pieza.png"},
	[[Me acerqué a ver si quedaba espacio, y en la oscuridad alcancé a
notar que Falcon estaba vuelto hacia la pared. Falcon, eres un santo. Me metí
como pude, quedando espalda con espalda.]],

	[[El no parecía haberse dado cuenta. De verdad debía estar cansado.]],

	[[En fin, la cama no resultó tan estrecha como esperaba. Con no moverme
mucho en sueños no me caería.]],
}

local camaDeBake = {
	{"bg", "mod", fade={"fadeout", 1, true}},
	[[En sigilo entré a la pieza donde estaba Bake. Apenas distinguía nada,
así que tuve que tantear para encontrarlo y de ahí meterme del otro lado.]],

	[[Descubrí entonces que Bake dormía solo con dos frazadas.]].

	[[Yo en el norte dormía con tres.]],

	[[Suspiré. Me detesto tanto a mi misma por venirme a meter acá.]],

	[[Me cubrí hasta la nariz con las frazadas y seguí con frío. Cuando me
acomodaba en posición fetal como último recurso, noté una calidez que radiaba
de Bake.]],

	[[¿Será mucho atrevimiento apegarme mas? Fui acercándome discretamente
hasta que podía casi tocar su espalda. Era como una estufita, que genial. No
sabía como Bake no moría de frío, pero menos mal que no lo hacía.]],
}

local toallas = {
	[[Pensé y pensé en mis opciones, y al final tomé todas las toallas que
había y fui a tirarlas al sillón.]],

	[[Me acurruqué temblando bajo las toallas, con abrigo y calcetines
puestos. Pensé que lograría dormir bien.]],

	[[Que ingenua. Parecía que no me podía calentar de ninguna
manera con esas toallas de playa.]],

	[[Para variar, a los minutos las curvas, resortes, y partes duras del
sillón se hacieron notar una a una. Me encontré en una gruta. Como cama este
sillón era casi peor que el suelo.]],

	[[Terminé dando vueltas tratando de acomodarme mientras la temperatura
seguía bajando y el frío me calaba más los huesos. Cuando oí el reloj de Falcon
sonar desde arriba, supe que aquí no iba a acabar bien la noche.]],

	{"select", "quien", {
		[[Ir a dormir con Bake.]],
		[[Ir a dormir con Falcon.]],
		[[Si o si duermo sola.]],
	}},
	{"case", "quien", {
		camaDeBake,
		camaDeFalcon,
		soyTestaruda,
	}},
}

local enElSillon = {
	[[Miré el sillón una vez mas. Me recosté en el y se me heló la espalda.
Demonios.]],

	[[Tan estúpida yo. Debí haber abierto la boca apenas hablaron de
dormir.]],

	[[Me puse a dar vuelta el primer piso en busca de alguna frazada. Mas
me valía encontrar una, o de lo contrario iba a cubrirme con las toallas del
baño.]],

	[[Living. Comedor. Cocina. Lavadora...]],

	[[Baño.]],

	[[OK, quizás estaba siendo demasiado paranoica. ¿De verdad creía que
los chicos me iban a hacer algo? No estaban los tiempos para eso. Creo...
¿Creo?]],

	[[Y, ehh, debian estar durmiendo como ladrillos, ¿no?]],

	[[Yo solo no quería mas de este puto frio.]],

	{"select", "quien", {
		[[Ir con Bake.]],
		[[Ir con Falcon.]],
		[[¿Son largas las toallas?]],
	}},
	{"case", "quien", {
		camaDeBake,
		camaDeFalcon,
		toallas,
	}},
}

local conQuien = {
	{"select", "quien", {
		[[Dormir con Bake.]],
		[[Dormir con Falcon.]],
		[[Dormir en el sillón.]],
	}},
	{"case", "quien", {
		{
			[[Bake parecía la mejor opción. Lo conocía un par de
			horas mas que a Falcon. La cama tenía mucho espacio. Me
			había ayudado, y hasta donde sabía no era ningún
			perv... Ah, la puta nota.]],
			[[Bueno, dijo que no había abusado... Y yo le creía,
			¿verdad? Bake me parecía sincero, ¿verdad?]],
		},
		{
			[[Si me daban a elegir entre Bake y Falcon,
			Falcon se notaba era algo mas considerado y sensato que
			Bake. Solo un poco.]],
			[[Quiero decir, no creía que Bake fuera malo, peeeero es
			solo que Falcon me daba mas confianza de tener buen
			juicio.]],
			[[Aparte, Bake tiene su espalda recién herida. Buen
			punto.]],
			[[Por otro lado si ni el sabía quien era, ¿que podía
			esperar yo? Muchos de mis supuestos 'amigos' resultaron
			tener otros intereses dado el momento.]],
		},
		{
			[[Le heché una mirada al sillón. Iba a dormir en un
			hoyo, con frío. Lo único que tenía de abrigo era la
			ropa que traía puesta. ¿No había otra opción?]],
		},
	}},

	{"select", nil, {"Reconsiderar", "Respuesta definitiva"}},
	{"case", nil, {
		nil,
		{
			{"case", "quien", {
				camaDeBake,
				camaDeFalcon,
				enElSillon,
			}},
			{"map", "quien", {"Bake", "Falcon", "sola"}},
			{"global", "set", "DespiertaDonde", "quien"},
			{"break"},
		},
	}},
}

return {
	{"style", "vnMaria"},
	{"name", "María"},
	res.fun.macro.title,

	{"bg", "mod", "default", color=res.palette("flashlight", 1, .5),
		shader=res.shader.contrast},
	{"bg", "add", args={"maria/living.png"}, fade={"fadein", 1}},
	[[Opté por quedarme un ratito mas dando vueltas. No se si era por enojo
o gracias a mi pequeña 'siesta' de la mañana, o quizás hasta por el mate, pero
no tenía ganas de pegar pestaña aún.]],

	[[A medida que dejé de oír a los chicos caminando arriba y el silencio
se asentaba, aquella inquietud que me había acompañado todo el día volvió.]],

	[[Me sentía ansiosa cada vez que pensaba en mi situación. En
estar sola en una ciudad que nunca había visitado y con gente que en realidad
no conozco. En las bestias rondando allá afuera. El fin de toda la
civilización, quizás.]],

	[[¿Que había sido la explosión, en todo caso?]],

	[[Entendí que fue una fábrica de inodoros que se había incendiado, pero
eso me parecía demasiado ridículo. ¿Que había en ese humo que podía convertir a
la gente en esto? ¿Y a donde se habían ido todos?]],

	[[Mas aún, ¿que era esa Sombra de la que habló Bake? Podía imaginar que
yo en pánico viera cualquier cosa, ¿pero Bake? ¿Y justo al mismo tiempo?]],

	[[Por otro lado, que un zombie me tuviera a su alcance y se fuera
sin hacerme nada tenía incluso menos sentido.]],

	[[¿Y que hay de Falcon? ¿Como no se convirtió si estuvo casi en el
centro de todo?]],

	[[Ninguna de esas cosas parecían tener ningún sentido.]],

	{"macro", "rFade", "maria/cocina.png"},
	[[Me aseguré que las puertas estuvieran bien cerradas y las tablas bien
clavadas. Miré por la ventana de la cocina a la oscuridad del exterior, donde
los dos cuerpos quedaron esta mañana.]],

	[[No saber que había pasado con ellos también me inquietaba, pero no
pensaba salir a investigar a estas horas.]],

	[[Me limité a mirar desde adentro, segura, intentando no pensar en la
posibilidad de que aparecieran de golpe, o peor aún...]],

	{"bg", "mod", fade={"fadeout", 1/12}},
	[[Detrás mío.]],

	{"bg", "mod", fade={"fadein", 6}},
	[[Mierda, mierda, mierda. ¿Para que me asusto yo sola? Literalmente
siempre hacía lo mismo.]],

	[[Traté de enfocarme en otra cosa antes de acabar en pánico. El viento
helado que soplaba, el sonido de los árboles, la nieve blanca que desaparecía
en un océano de negro... ¿Un océano?]],

	[[¿No había soñado algo así, una vez? ¿Con un océano? La palabra me
produjo una sensación incómoda en el pecho, como si me apretara, pero el por
que me eludía.]],

	[[Tal vez lo había vivido, pero no recordaba donde ni como. Estuve un
rato sintiéndolo, pensando en si alguna vez estuve en una playa de
noche, pero sin éxito.]],

	[[De pronto, una tenue luz recorrió los árboles y las casas.
¿Una linterna? ¿Un auto? Agudizé el oído y me pareció sentir un motor.]],

	{"bg", "mod", "default",
		shader=res.fun.complex.purkinje(),
		color={1/6, 1/6, 1/6, 1},
	},
	{"macro", "rFade", "maria/living.png"},
	[[Me dirigí al living y miré por entre las tablas, apagando la linterna
para no encandilarme.]],

	[[Solo alcancé a ver una camioneta vieja y destartalada que se fue
antes que pudiera hacer algo, con dos ocupantes en su interior.]],

	[[Y al menos uno era un perro, de eso no tengo duda.]],

	[[Así como vino se había ido, y lo único que gané con eso fue saber que
hay al menos cuatro personas vivas en la ciudad.]],

	[[A lo mejor la ciudad era como un bosque. Había que tener paciencia
para ver quién la habitaba.]],

	[[O alguna cuestión así. No sé. Con tanta oscuridad y silencio ya me
pesaban los ojos. Tal vez ya era hora de dormirme.]],

	[['¿Sabes que se te olvidó traer?' pensé para mi misma. 'Un cepillo de
dientes.' Si, y un pijama, y ropa para cambiarme. Como siempre tarde, María,
como siempre. Iba a tener que dormir la ropa puesta no más.]],

	[[El tema era... ¿donde?]],

	{"let", "quien"},
	{"read", conQuien, true},
}
