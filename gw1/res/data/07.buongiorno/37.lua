local gP = 1
local gA = 2
local gF = 3
local gB = 4
local gBAF = {gA,gF,gB}
local gAF = {gA,gF}
local gPB = {gP,gB}
local gPF = {gP,gF}

local swap = res.fun.vn.charSwap

return {
	{"style", "vnMaria"},
	res.fun.macro.title,

	{"bg", "mod", "root", color={.7,.7,.7,0}},
	{"bg", "addsub", {
		{args={"maria/av.png"}, fade={"fadein", 1/3}},
	}},
	{"name", "María"},
	[[Me había logrado calmar tras unos minutos. Estaba recostada en el
asiento del copiloto, vuelta hacia mi lado, con la vista perdida en la
ciudad.]],

	[[Falcon vigilaba la Avenida, con su arma en mano. Ninguno hablaba.
Esperabamos a Bake.]],

	[[En los minutos que estuvimos adentro había comenzado a nevar. Todo
se había empezado a cubrir de blanco rápidamente, y hasta yo podía darme cuenta
de que esta tormenta recíen comenzaba. Era el peor momento para estar fuera
de casa.]],

	[[Bake no se había asomado en todo este tiempo. No podía imaginar que
estuviera revisando caja por caja allá adentro... pero eso debía ser lo que
hacía.]],

	[[Pensé, estariamos terminando si estuvieramos los tres buscando, pero
yo no podía aguantar al lado de seis cuerpos despedazados. Y si yo me quedaba
afuera, discutirían cual de los dos debería quedarse a cuidar a la pobre de
María, que cuando sale es asechada por su propia sombra, la inútil.]],

	[[El único punto bueno hasta ahora es que ningún zombie se nos acercaba.
Rondaban lejos, pero no venían. Quizás no nos sentían dentro del auto, o por el
viento no les llegaba nuestro olor, aunque la verdad no sabía si tenían buen
olfato,]],

	[[Aburridos, Falcon finalmente prendió la radio, pero aquí solo llegaba
estática, que no sonaba tan distinta al viento de afuera. Falcon la apagó y se
guardó las manos en los bolsillos.]],

	[["¿No sale?" pregunté. Era lo primero que alguno de los dos decía.]],

	{"name", "Falcon"},
	[["No."]],

	{"name", "María"},
	[["¿Crees que le haya pasado algo?"]],

	{"name", "Falcon"},
	[["No lo sé... Quizás tuvo que parar para tomar aire."]],

	{"name", "María"},
	[["Quizás." Nos quedamos callados de nuevo. Me debatí sobre tragarme
el miedo y meterme a verlo, pero si iba a tener que devolverme llegando a la
puerta, sería aún mas un estorbo. Por suerte, Falcon se me adelantó y decidió
salir.]],

	{"name", "Falcon"},
	[["Voy a decirle que busquemos el remedio en otro lado. Lo que mas debe
haber en esta ciudad son farmacias." Falcon se bajó... pero no cerró la
puerta.]],

	{"bg", "addsub", {
		default={draw=f0b.doll.draw, color={1,1,1,0}},
		{args={res.doll.falcon, 160}, color={1,1,1,1}},
		{args={res.doll.andrea, 120}},
		{args={res.doll.fab, 520, 0, -1}},
		{args={res.doll.bake, 320, 0, -1}},
	}},
	[["Viene gente," dijo. Levanté la cabeza, y distinguí tres figuras
que venían en la esquina.]],

	{"name", "María"},
	[[No eran zombies, por la forma de caminar, pero por la nieve no los
podía distinguir bien. Uno parecía una mujer... Y otro me provocaba una
sensación en el pecho por la forma de caminar. Era mas alto que los otros
dos.]],

	[[Me bajé del auto a mirarlos, a esperar a que se acercaran. Allí nos
dimos cuenta: el mas alto era Bake.]],

	{"name", "Falcon"},
	[["¿Y este por donde salió?" se preguntó Falcon, tan anonadado como yo,
pero sin perder tiempo fuimos a recibirlo. Venía con dos desconocidos. Un chico
y una chica.]],

	swap(gBAF, gP, 1/12),
	{"bgm", "set", "af", source="andrea y fab (demo).ogg"},
	{"name", "Bake"},
	[["lol, hola xD" rió. Tenía el rostro radiante, como cuando lo conocí
tras la pelea.]],

	{"name", "María"},
	[["¿Que te pasó?" fue lo primero que le dije. Parecía haber corrido una
maratón.]],

	{"name", "Bake"},
	[["Nada, no más que no encontré medicina, me metí a la casa del dueño,
encontré un zombie, huí por varias calles hasta unos apartamentos..." Bake tomó
aire.]],

	[["...y de lo alto ví a estos dos chicos en medio del blanco. Se llaman
Fab y Andrea. Fab es el chico con cara de vándalo, casi me parte la cabeza con
ese tubo xD" A-Ah.]],

	{"name", "Fab"},
	[["Que no soy un vándalo," reclamó el chico tras eso último.]],

	{"name", "Bake"},
	[["Bueno, falopero entonces xD" El chico suspiró.]],

	swap(gP, gBAF, 1/12),
	{"name", "Falcon"},
	[["Bake, para 'vos' todos son faloperos."]],

	swap(gBAF, gP, 1/12),
	{"name", "Bake"},
	[["Era un chiste para ella xD" dijo señalando a Andrea. O-Oye...]],

	{"name", "Andrea"},
	[["La verdad yo lo llamé 'zombie' y pervertido cuando me lo encontré.
Me dió un gran susto," respondió la chica. Bake se puso a reir, mientras el
chico se llevaba la palma a la frente.]],

	{"name", "María"},
	[[Se veían normales, pero ahora ya no sabía que esperar.]],

	[["Ehh, hola," atiné no más a decir. Falcon y yo nos presentamos.]],

	[[La chica parecía de mi edad. Lucía un poncho sobre lo que parecía ser
un abrigo no muy grueso, así que asumí que o el poncho era muy bueno, o como
Bake debía ser de acá. Sostenía una katana con su funda en una mano.]],

	[[El chico mientras tanto parecía veinteañero, mas o menos de mi misma
estatura. Cargaba una mochila, y la susodicha tubería.]],

	[[Eran bien peculiares los dos. Me pregunté si eran hermanos.]],

	{"name", "Bake"},
	[["Bueno, ehm, la tormenta va a empeorar, así que si
queremos comida tenemos que ir por ella ahora ya."]],

	{"name", "Fab"},
	[["Yo traigo algo de comida," dijo el chico. "Arroz y fideos."]],

	{"name", "Bake"},
	[["¿Posta? Entonces vamos a la casa y mañana volvemos xD"]],

	swap(gP, gBAF, 1/12),
	{"bgm", "fade", "af", {"fadeout", 5, true}},

	{"name", "Falcon"},
	[["¿A la casa?" preguntó Falcon.]],

	{"bg", 2, "fade", 4, {"mvabs", 480, false, 0, "fadein", 1/12}},
	{"name", "Bake"},
	[["Si. Después buscamos tus pastillas."]],

	{"name", "Falcon"},
	[["Mierda, no es por eso. ¿Se te olvidó lo que hablamos en la mañana?"
reclamó Falcon. Bake inclinó la cabeza pensando. "Sobre Croft."]],

	{"name", "Bake"},
	[["Ehh, estaba somnoliento, solo recuerdo desde lo de la batería,"
Falcon se golpeó la frente con la palma, suspiró, y se dirigió a los chicos.]],

	{"bg", 2, "fade", 2, {"mvabs", 160, false, 0,
		"src", res.doll.andrea_fome, "fadein", 1/12}},
	{"bg", 2, "fade", 3, {"mvabs", 480, false, 0, "fadein", 1/12}},
	{"bg", 2, "fade", 1, {"fadeout", 1/12}},
	{"bg", 2, "fade", 4, {"fadeout", 1/12, "mvabs", 480, false, 0}},
	{"name", "Falcon"},
	[["Miren, no es por nada, pero no estamos aceptando gente,"
explicó. Los chicos se miraron confudidos.]],

	{"name", "María"},
	[[Entendía la preocupación de Falcon, pero me dió algo de pena
pensar en dejar a los dos chicos los en la calle con esta tormenta.]],

	[[Además que no creía que Croft se haya querido aprovechar de nosotros;
no tenía sentido habersenos unido solo para robar un revólver.]],

	[[Miré a Bake quién lucía indeciso, así que lo tironée a el y a Falcon
para formar un círculo.]],

	swap(gPB, gAF, 1/12),
	{"name", "María"},
	[["Escuchen, no creo que sean mala gente," susurré.]],

	{"name", "Falcon"},
	[["¿Los viste bien? El tio tiene cara de terrorista. Nos va a hacer
volar en la noche."]],

	swap(gF, gPB, 1/12),
	5/3,
	swap(gPB, gF, 1/12),
	1/12,
	{"name", "Bake"},
	[["lol"]],

	{"name", "María"},
	[["O sea, supongo que siempre hay un riesgo, pero..." Los miré de reojo,
y hablaban también en voz baja entre ellos. El chico hacía girar la
tubería, y de pronto se le pegó con un click a la mochila.]],

	[[Mierda, a lo mejor si traía una bomba.]],

	{"name", "Bake"},
	[["Yo tengo un plan. Para salir de la duda, quiero decir."]],

	{"name", "Falcon"},
	[["Bake, no estamos para tus boludeces." Falcon me leyó la mente.]],

	{"name", "Bake"},
	[["No es bola. Ustedes tranquilos."]],

	swap(gAF, gPB, 1/3),
	{"name", "María"},
	[[Bake se giró hacia los chicos, que se callaron apenas Bake se acercó.]],

	{"name", "Bake"},
	[["Pueden venir con nosotros, pero tienen que
mostrar que son de fiar," declaró. Los chicos nos miraron desconfiados.]],

	{"name", "Andrea"},
	[["Eso suena bien sospechoso."]],

	{"name", "Fab"},
	{"text", [["Si, y peligroso. Fijate en el tipo de allá. Parece que lo
molieron a golpes,"]], false, true},

	swap(gPB, gAF, 1/12),
	{"text", [[ Falcon frunció el ceño con el comentario, resaltando aún
mas sus moretones.]], true},

	{"bg", 2, "fade", 2, {"src", res.doll.andrea}},
	{"name", "Bake"},
	[["shit xD No, miren, nuestro último compañero nos abandonó y se llevó
un arma, así que solo queremos asegurarnos," les explicó. Los chicos se miraron
dudosos.]],

	swap(gAF, gPB, 1/12),
	{"name", "Fab"},
	[["Tampoco es que estemos mal solos," dijo aún desconfiando.]],

	{"name", "Andrea"},
	[["Si, pero igual llevamos 3 días cargando esos fideos porque no
tenemos donde hacerlos," dijo la chica.]],

	{"name", "Fab"},
	[["¿Aceptamos?" La chica levantó los hombros. "¿Que es lo que quieren?"]],

	swap(gPB, gAF, 1/12),
	{"name", "Bake"},
	[["Nada. Necesitamos un baterista para nuestra banda."]],

	{"bg", 2, "fade", 1, 4, {"fadeout", 1/12}},
	{"name", false},
	[[...]],

	{"name", "María"},
	[["que ò.ó"]],

	{"bg", 2, "fade", 2, {"fadein", 1/12}},
	{"name", "Andrea"},
	[["Uhmm, yo sé tocar batería."]],

	swap(gB, gA, 1/12),
	{"name", "Bake"},
	[["Aw shit nigga, vos vas enton-- Espera, no. Tenés que demostrarlo
primero xDD ¡Seguidme!"]],

	{"bg", 2, "fade", 4, {"fadeout", 1/3}},
	{"name", "María"},
	[[Bake se giró y se puso a caminar a pesar de que el viento agarraba
fuerza y la nieve no paraba. Todos fueron de inmediato tras el.]],

	[[¿Por que todos lo siguen? ¿Que está pasando? ò.ó]],

	{"bg", 2, "mod", 1, args={res.doll.falcon, 320, 0, -1},
		fade={"fadein", 1/12}},
	[["F-Falcon, ¡dí algo!"]],

	{"name", "Falcon"},
	[["Estoy tan impactado como tú. No sé como el que Croft no tocara no me
pareció sospechoso." ò.ó]],

	{"bg", 2, "fade", 1, {"fadeout", 1/12}},
	{"name", "María"},
	[[Bake caminó unas cuadras con nosotros siguiendolo en fila india. Nos
llevó hasta una tienda con un vidrio roto por completo... La tienda de
música.]],

	[[ò.ó... Esto era una broma. Tenía que serlo.]],

	{"bg", 2, "fade", 4, {"mvabs", 320, false, 0, "fadein", 1/12}},
	{"name", "Bake"},
	[["Es bien simple. Si tocan bien, los aceptamos," dijo volteandose, y
miró al chico. "Vos tener que hacer algo también, no pasás por arrastre."]],

	swap(gAF, gB, 1/12),
	{"name", "Fab"},
	[["Yo toco el teclado."]],

	swap(gB, gAF, 1/12),
	{"name", "Bake"},
	[["Probalo xD"]],

	swap(gAF, gB, 1/12),
	{"name", "Fab"},
	[["Pero si no hay luz."]],

	swap(gB, gAF, 1/12),
	{"name", "Bake"},
	[["Inventá algo o no entrás a mi casa." El chico miró la tienda, y se
empezó a quitar la mochila.]],

	swap(gAF, gB, 1/12),
	{"name", "Fab"},
	[["Hold my tube," dijo pasándole sus cosas a la chica.]],

	{"bg", 1, "fade", {"fadeout", 1/3}},
	{"bg", 2, "fade", 2, {"fadeout", 1/3}},
	{"bg", 2, "fade", 3, {"fadeout", 1/3, "mvabs", 320, false, 0}},
	{"bg", "fade", "root", {"color", {.5,.5,.5,1}, 3}},
	{"name", "María"},
	[[Entramos siguiendo al chico, y este tras hechar un vistazo fue a
tomar un acordeón.]],

	{"bg", 2, "fade", 2, {"fadein", 1/12}},
	{"name", "Andrea"},
	[["Enséñales Fab," lo animó la chica.]],

	{"bg", 2, "fade", 2, {"fadeout", 1/12}},
	{"name", "María"},
	[[El chico se colocó el acordeón y se sentó en una silla. Observó
las teclas de ambos lados, las sintió con los dedos, y asegurándose que
Bake estuviera mirando, empezó a tocar.]],

	{"bgm", "set", "acc",
		source="prelude2_accordeon2 (godlike samples, crap midi).ogg",
		fade={"delay", 4/3, "fadeout", 1/48, true}},
	2/3,

	{"bg", 2, "fade", 4, {"fadein", 1/12}},
	{"name", "Bake"},
	[["Ahí está bien, vos pasás," dijo Bake cuando el chico no llevaba ni 3
notas. Los cuatro nos giramos a verlo.]],

	swap(gF, gB, 1/12),
	{"name", "Fabian"},
	[["WTF"]],

	swap(gB, gF, 1/12),
	{"name", "Bake"},
	[["Solo quería comprobar que hicieras algo xD La verdad lo que mas
hace falta es la batería."]],

	swap(gF, gB, 1/12),
	{"name", "María"},
	[[El chico se quedó anonadado. Miró a la chica, y simplemente levantó
los hombros. Dejó el acordeón a un lado y fue a tomar sus cosas.]],

	{"bg", 2, "fade", 3, {"fadeout", 1}},
	[[El viento estaba agitando los árboles con mucha fuerza, así que la
chica sin perder mas tiempo fue a buscar unas baquetas y se sentó frente a una
batería. Aún no creía que estuvieramos perdiendo el tiempo en esto.]],

	{"bg", 2, "fade", 2, {"fadein", 1/12}},
	{"name", "Andrea"},
	[["¿Como lo hacemos? ¿Marcas un tiempo o quieres algo en especial?"]],

	swap(gB, gA, 1/12),
	{"name", "Bake"},
	[["Solo véndemelo."]],

	swap(gA, gB, 1/12),
	{"name", "Andrea"},
	[["Bueeeno," dijo acomodándose. Buscó los pedales y empezó a
tocar.]],

	{"bg", 2, "fade", 2, {"fadeout", 1/3}},
	{"bgm", "set", "tb", source="Tension Baroque (andrea).ogg"},
	{"name", "María"},
	[[Ya lo he dicho, soy un cero a la izquierda en la música. Andrea
tocaba y yo ni sabía si era buena o mala.]],

	[[La expresión de Bake no cambiaba en nada, y pensé que se debía a que
era muy simple lo que hacía... Pero por otro lado, sentía un impulso por
moverme al ritmo.]],

	{"bg", 2, "mod", 1, args={res.doll.falcon, 160, 0, -1},
		fade={"fadein", 1/12}},
	{"bg", 2, "fade", 3, {"mvabs", 480, false, 0, "fadein", 1/12}},
	[[Miré a Falcon, y el de hecho lo estaba haciendo, igual que Fab.]],
	{"bg", 2, "fade", 1, 3, {"fadeout", 1}},
	4,

	{"bgm", "fade", "tb", {"delay", 1, "fadeout", 4, true}},
	[[Bake dejó tocar a Andrea hasta que se detuvo por su cuenta, a
diferencia de Fab.]],

	{"bg", 2, "fade", 4, {"fadein", 1/12}},
	{"name", "Bake"},
	[["¿Eso es todo?" preguntó Bake, por lo visto nada convencido.
Andrea inclinó la cabeza.]],

	swap(gA, gB, 1/12),
	{"name", "Andrea"},
	[["Pues... si. Tampoco es para lucirse."]],

	swap(gB, gA, 1/12),
	{"name", "Bake"},
	[["Nena, en nuestra banda tocamos rock y metal. No te vas a oír
sobre mi guitarra."]],

	{"bg", 2, "fade", 2, {"src", res.doll.andrea_fome}},
	swap(gA, gB, 1/12),
	{"name", "Andrea"},
	[["¿Y que quieres que haga? ¿Que toque a 200 por minuto?"]],

	swap(gB, gA, 1/12),
	{"name", "Bake"},
	[["Si querés unirtenos, es lo mínimo." Andrea se veía casi insultada
con sus palabras. Fab tosió incómodo.]],

	swap(gPF, gB, 1/12),
	{"name", "Fabian"},
	[["Tampoco estamos desesperados."]],

	swap(gA, gPF, 1/12),
	{"name", "Andrea"},
	[["Entonces marca tú el compás si quieres algo rápido," le dijo
molesta.]],

	swap(gB, gA, 1/12),
	{"name", "María"},
	[[Bake se acercó sonriente, alzó ambas manos...]],

	{"bgm", "set", "clap", source="andrea metal clap.ogg",
		fade={"fadein", 1/12},
	},
	[[...y empezó a aplaudir tan veloz como podía.]],

	swap(gA, gB, 1/12),
	{"name", "María"},
	[[Andrea lo miró fijamente, como si eso fuera una broma y ella
estuviera silenciosamente enojada...]],

	{"bgm", "set", "drums", source="andrea metal loop.ogg"},
	{"bg", 2, "fade", 2, {"fadeout", 1/12}},
	[[Y luego alzó las baquetas y partió golpeando el platillo.
Empezó a tocar tán rápido como Bake.]],

	[["Dios mio..." murmuré. ¿Ese era el estilo metal? ¿Golpear todo en
cada milisegundo? Los chicos la miraban fijamente.]],

	{"bg", 2, "fade", 1, 3, {"fadein", 1/12}},
	{"name", "Falcon"},
	[["¿Es doble pedal esa batería?"]],

	{"name", "Fabian"},
	[["Solo veo uno," replicó, y Falcon silbó sorprendido. Me daba la
impresión que eso significaba el doble de difícultad. Quizás más.]],

	swap(gB, gPF, 1/12),
	{"name", "María"},
	[[Seguimos mirando a Bake mientras Andrea tocaba. En los primeros
segundos de impresión pensé que ya debía ser suficiente... Pero Bake no paraba
de aplaudir. "¿Cuanto rato van a estar así?" le pregunté a Falcon.]],

	{"name", "Falcon"},
	[["Pues, si va en serio con lo del metal, a lo menos 4 minutos."]],

	{"name", "María"},
	[[...ò.ó wtf??]],

	[[¿Que era esto, una prueba olímpica? ¿Solo para formar una
banda?]],

	{"bg", 2, "fade", 4, {"fadeout", 1/12}},
	[[Miré de nuevo a Andrea, que se esmeraba en seguirle el ritmo a
Bake... No iba a durar más.]],

	{"bgm", "fade", "drums", {"fadeout", 1/12, true}},
	{"bgm", "fade", "clap", {"fadeout", 1, true}},
	[[A menos de un minuto de partir empezó a quedarse atrás y luego se
detuvo, completamente exausta. Se agarraba el pie.]],

	{"bg", 2, "fade", 4, {"fadein", 1/12}},
	{"name", "Bake"},
	[["Nena, no tocamos canciones tan cortas."]],

	{"name", "María"},
	[["Bake, no seas tan cruel."]],

	{"name", "Bake"},
	[["Pero si Falcon quería gente de fiar."]],

	{"name", "María"},
	[[Que demonios tenía que ver la habilidad musical con la confianza,
por las retutas. Yo no servía ni para hervir agua y aquí estaba >.>]],

	swap(gPF, gB, 1/12),
	{"name", "Falcon"},
	[["Ehh, igual lo primero me dió seguridad." Y por que Falcon actuaba
como si esto tuviera sentido. "No sé si los blast beats sean tan importantes."]],

	{"bg", 2, "mod", 4, args={res.doll.bake, 160}},
	swap(gB, gPF, 1/12),
	{"name", "Bake"},
	[["Es que quería tocar unas de Metallica."]],

--	{"read", ebinSolo},
	{"bg", 2, "mod", 1, args={res.doll.falcon, 480, 0, -1}, fade={"fadein", 1/12}},
	{"name", "Falcon"},
	[["Bake, anoche ni siquiera podías con Heroes Desechables xDDD"]],

	{"name", "Bake"},
	[["Pero es que ya llevabamos dos horas tocando xd es distinto xddd"]],

	{"name", "Falcon"},
	[["Lo que digas xD" se burló. "Yo voto por que vaya."]],

	{"name", "Bake"},
	[["María, ¿tu que dices?" me preguntó Bake. Mierda, ¿yo que sabía?]],

	{"name", "María"},
	[["Estoy de acuerdo."]],

	{"bg", 2, "fade", 1, 4, {"fadeout", 1/12}},
	{"name", "María"},
	[[Andrea se quedó cabisbaja a pesar de la noticia, y Fabian se acercó a
verla. Mientras tanto, Bake y Falcon salieron a la calle. Yo los seguí.]],

	{"bg", "fade", "root", {"color", {.6,.6,.6,1}, 3}},
	{"bg", 1, "fade", {"fadein", 1}},
	{"bg", 2, "fade", 1, {"fadein", 1}},
	{"bg", 2, "fade", 4, {"fadein", 1}},
	[[No sé si era idea mía, pero todo se veía mas oscuro que cuando
entramos.]],

	{"name", "Falcon"},
	[["Uf, se ve feo el cielo."]],

	{"name", "Bake"},
	[["Si, perdimos demasiado tiempo. Hay que correr a la casa."]],

	{"name", "María"},
	[["¿Que pasó? ¿Va a caer nieve?"]],

	{"name", "Bake"},
	[["Parece de hecho una tormenta. Una buena," fue todo lo que dijo.
Falcon parecía de acuerdo.]],

	{"name", "María"},
	[[Nos volteamos a ver los chicos que aún no salían. Ambos se rieron de
algo.]],

	{"name", "Falcon"},
	[["¿Son novios esos dos?" le preguntó Falcon a Bake.]],

	{"name", "Bake"},
	[["No sé, no les pregunté xd"]],

	{"name", "Falcon"},
	[["¿Y de que hablaron mientras venian?" Esa era una buena pregunta.]],

	{"name", "Bake"},
	[["Hmm, de nuestros nombres xD" Dios.]],

	{"name", "Falcon"},
	[["Bueno, si son novios, tienen mucha suerte de poder seguir juntos..."
dijo medio suspirando.]],

	{"name", "María"},
	[["¿Por que para ti todos son novios? A lo mejor solo son amigos.
O hermanos."]],

	{"name", "Bake"},
	[["Si, seguro xD"]],

	{"name", "Falcon"},
	[["No creo que sean hermanos porque no se parecen en nada. Aparte
se llevan demasiado bien."]],

	{"name", "María"},
	[["No siempre se parecen."]],

	{"name", "Falcon"},
	[["María, eso siempre tiene otra explicación xD"]],

	{"name", "Bake"},
	[["Ñam, bueno, yo me llevo bien con mi hermana."]],

	{"name", "María"},
	[["¡¿H-Hermana?!"]],

	{"name", "Falcon"},
	[["¿Tienes hermana?" preguntó tan sorprendido como yo.]],

	{"name", "Bake"},
	[["Pues si xD"]],

	{"name", "María"},
	[["¿Por que no nos dijiste?"]],

	{"name", "Bake"},
	[["No preguntaron xD"]],

	{"name", "María"},
	[["¡Te pregunté el primer día por tu familia!" reclamé.]],

	{"bg", 2, "fade", 4, {"src", res.doll.bake_xd, "delay", 1,
		"src", res.doll.bake}},
	{"name", "Bake"},
	[["Ah, verdad xD Perdoná xdd"]],

	{"name", "Falcon"},
	[["Pensé que eras hijo único por las fotos. ¿Está con tus padres?"]],

	{"name", "Bake"},
	[["No, está acá en la ciudad, en algún lugar. Se peleó feo con
mis viejos hace unos años y se fue de la casa. Entre que la veo tan poco y el
apocalípsis, se me olvida que existe xD"]],

	{"name", "Falcon"},
	[["Uf, ¿pero está bien?"]],

	{"name", "Bake"},
	[["No lo sé, pero sabe cuidarse mejor que yo." Si Bake lo decía, a
lo mejor era cierto...]],

	{"name", "María"},
	[[Antes de poder seguir con el tema, los dos chicos salieron de la
tienda.]],

	swap(gAF, gPB, 1/12),
	{"name", "Fabian"},
	[["El cielo se ve feo," comentó mirando al horizonte. La cordillera
estaba prácticamente tapada.]],

	{"name", "Falcon"},
	[["Y se pondrá peor. Hay que irnos rápido,"
dijo Falcon. Sin decir mas nos apresuramos de vuelta a la camioneta.]],
}
