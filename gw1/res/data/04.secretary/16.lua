local comoEstaFalcon = {
	[[Dejé tiradas las botas y me dediqué a la dolorosa tarea de subir con
un pie esguinzado y la cadera moreteada.]],

	[[Esto de andar atropellada no era muy sano, pero quería ver si Falcon
se encontraba bien. Aparte que algo de compañía nunca le viene mal a nadie.]],

	[[Y no es por desconfiar de Bake, de hecho confio bastante para haberlo
conocido recíen ayer, pero por alguna razón cuestionaba su habilidad para
saber si algo era grave.]],

	{"macro", "bgFade", "maria/pasillo.png"},
	[[Llegué a duras penas arriba y toqué a la puerta. La
verdad iba a entrar igual porque no esperaba respuesta, pero sorprendentemente
Falcon me respondió casi de inmediato.]],

	{"macro", "bgFade",
		{args={"maria/pieza.png"}, color={.8, .8, .8, 1}}
	},
	[[Abrí y encontré a Falcon en pie, poniéndose su abrigo con chapa.]],

	{"bg", 2, "add", args={res.doll.falcon, 240}},
	{"name", "Falcon"},
	[["Hola," me dijo algo desanimado. Noté que se había puesto ropa nueva
debajo. Usaba una camisa de Green Park, así que a lo mejor Bake le había
prestado ropa. En el mueble junto a la alarma tenía la pistola y un
cartucho.]],

	{"name", "María"},
	[["¿Estás bien? Bake me dijo que tenías fiebre."]],

	{"name", "Falcon"},
	[["Si, amanecí adolorido entero. No sé si será que me resfrié porque
dormí en el auto estos días o que, pero sea lo que sea ya se me pasó." Falcon
se guardó el arma.]],

	[["¿Que pasó abajo? Escuché ladridos y casi me caí de la cama pensando
que eran zombies."]],

	{"name", "María"},
	[["No, no. Ehh, solo digamos que tenemos un nuevo integrante. Estamos
comiendo galletas abajo. ¿Vienes?"]],

	{"name", "Falcon"},
	[["Ya. Muero del hambre," dijo sonriendo.]],

	{"macro", "bgFade", "maria/pasillo.png"},
	{"bg", 2, "mod", fade={"fadeout", 1}},
	{"name", "María"},
	[[Salí a esperarlo al pasillo, y cuando estuvo listo fui con en el
hasta la escalera.]],

	{"bg", 2, "mod", fade={"fadein", 0}},
	{"name", "Falcon"},
	[["¿Te pasó algo en el pie?"]],

	{"name", "María"},
	[["Me accidenté un poco. Creo que es un esguince." Falcon me pidió ver,
y con levantar la manga del pantalón bastó.]],

	{"name", "Falcon"},
	[["Si, es un esguince. Va a estar así unos días."]],

	{"name", "María"},
	[["Mierda."]],

	{"name", "Falcon"},
	[["Igual si reposas creo que se te va a pasar mas luego."]],

	{"bg", 2, "mod", fade={"fadeout", 2/3, true}},
	{"macro", "bgFade", res.fun.gfx.comedor()},
	{"name", "María"},
	[[Bajamos los dos la escalera, cual peor que el otro, y de ahí fuimos
al comedor donde estaban Bake y Croft tomando mate y café, respectivamente.]],

	{"name", "Croft"},
	[["Así que ahora solo guardo una botella de la que nunca bebo."]],

	{"name", "Bake"},
	[["lol, yo no aguantaría," comentó Bake tomando de su mate, y sonrió al
ver a Falcon. "Despertó el bello durmiente."]],

	{"name", "Falcon"},
	[["Estaba con fiebre ¬¬"]],

	{"name", "Bake"},
	[["lol, si sé. Este es Croft. Atropelló a María esta mañana." Falcon
levantó una ceja, pero le dió la mano a Croft y nos sentamos. "Hay hamburguesa
y papa frita. Van a tener que compartir."]],

	{"name", "Falcon"},
	[["¿Queda muy poco?"]],

	{"name", "Bake"},
	[["Queda una hamburguesa y una papa frita, ya les dije xD Tambien hay
tostadas frias de la mañana." Bueno, será.]],

	{"name", "María"},
	[[Nos pusimos a comer lo que había junto con las galletas de Croft, y
le preguntamos sobre como había sobrevivido.]],
}

return {
	{"style", "vnMaria"},
	{"name", "María"},
	{"macro", "titleDate", {2011, 11, 12, 13, 50}},
	[[Llegamos cerca de la 2 de la tarde a la casa. El día se estaba
empezando a nublar de nuevo, y Croft comentó que iba a nevar otra vez a la
tarde.]],

	[[Me pregunté si necesitaban el canal del clima acá, porque parece que
todos saben al ojo lo que va a pasar.]],

	[[En fin. Croft me ayudó a bajar y fuimos hasta la puerta, con Pipi
olfateandonos los pies. Estaba a punto de tocar cuando de pronto Pipi se acercó
a oler a Rocco y se empezaron a ladrar.]],

	{"bg", "addsub", {}},
	{"bg", "addsub", {
		{args={res.doll.croft, 480, 0, -1}},
		{args={res.doll.bake, 160}, color={1,1,1,0}},
		default={draw=f0b.doll.draw}
	}},
	{"name", "Croft"},
	[["¡Eh! ¡Rocco! ¡Quieto!" Croft se metió sin temor entre los dos y tomó
a Rocco en brazos, aunque Pipi siguió ladrándole.]],

	{"name", "María"},
	[["Pipi. ¡Pipi! No me hace caso."]],

	{"bg", 2, "mod", 1, fade={"fadeout", 1/12}},
	[[De pronto la puerta se abrió y apareció Bake apuntándole a Croft con
una pistola.]],

	{"name", "Croft"},
	[["<:3"]],

	{"name", "María"},
	[["¡Espera! ¡No dispares!" grité de inmediato. Bake bajó el arma.]],

	{"bg", 2, "mod", 2, fade={"fadein", 1/12}},
	{"name", "Bake"},
	[["Disculpá, pensé que era una de esas cosas verdes por los ladridos.
¿Quién es el?"]],

	{"name", "María"},
	[["Se llama--"]],

	{"name", "Bake"},
	[["¡POR DIOS! ¡¿Que te pasó en la cabeza?!" dijo tomándome la cabeza
por el mentón. "Tenés una flor de moretón." Le alejé la mano.]],

	{"name", "María"},
	[["Larga historia. El es Croft y su perro Rocco."]],

	{"bg", 2, "mod", 1, fade={"fadein", 1/12}},
	{"name", "Croft"},
	[["Hola," dijo extendiendole la mano. Bake guardó el arma y se la
estrechó.]],

	{"name", "Bake"},
	[["Bakeritsu, pero todos me llaman Bake. ¿Que es eso que gotea?" Los
dos miramos a Croft, y este miró a Rocco que lo miró de vuelta.]],

	{"name", "Croft"},
	[["¡Hijo de--!" Soltó a Rocco y este salió corriendo mientras Croft se
sacudia el brazo. Lo había meado encima. "¡No podías hacer todo junto!" lo
regañó.]],

	{"bg", 2, "mod", 1, fade={"fadeout", 1/3}},
	{"name", "María"},
	[[Rocco terminó de mear en un árbol mientras Croft se quitaba el
abrigo. Por suerte parecía que era impermeable.]],

	{"bg", 2, "mod", 2, fade={"src", res.doll.bake_xd}},
	{"name", "Bake"},
	[["xD" dijo Bake.]],

	{"bg", 2, "mod", 2, fade={"src", res.doll.bake}},
	{"name", "María"},
	[["¿Ya despertó Falcon?"]],

	{"name", "Bake"},
	[["¿Falcon? Está con fiebre en la cama."]],

	{"name", "María"},
	[["¿Que? ¿Como con fiebre?"]],

	{"name", "Bake"},
	[["Si, lo fui a ver luego que salieras y estaba así, dijo que le dolía
todo. Igual ya le está bajando, pero se durmió de nuevo y no ha comido nada."]],

	{"name", "María"},
	[[No imaginé que estuviera tan mal. No debí haber salido, si al final
de nuevo volví sin nada.]],

	{"bg", 2, "mod", 2, fade={"fadeout", 1/12}},
	{"name", false},
	[[*crack*]],
	1,

	{"bg", 2, "modall", fade={"fadein", 1/12}},
	{"name", "Croft"},
	[["Traje galletitas."]],

	{"name", "Bake"},
	[["Coooool," dijo invitándonos a entrar.]],

	{"bg", 1, "add", args={"maria/living.png"}, fade={"fadein", 1}},
	{"bg", 2, "modall", fade={"fadeout", 1, true}},
	{"bgm", "set", "normal", source="un día normal (demo).ogg"},
	{"name", "María"},
	[[Pasamos con Croft, que alcanzó a poner el pie para no dejar entrar a
Rocco en castigo, y se fue con Bake directamente a la mesa a comer y tal vez a
charlar un poco.]],

	[[Yo los seguí de mas atrás por mi cojera, pero me detuve al pasar
frente a la escalera.]],

	{"select", nil, {
		[[Subir a ver a Falcon.]],
		[[Dejarlo tranquilo.]],
	}},
	{"case", nil, {
		comoEstaFalcon,
		{
			[[A lo mejor solo iba a molestarlo si lo despertaba.]],

			{"macro", "bgFade", res.fun.gfx.comedor()},
			[[Seguí hasta la mesa y me senté junto a los chicos.
			Croft ya le estaba contando a Bake sobre como me
			pasó por encima, y que aparentemente lo rodearon tres
			zombies cuando me cargaba a la camioneta. Bake había
			puesto a hervir agua y había traido café a la mesa.]],

			{"name", "Bake"},
			[["¿Querés comida?" me preguntó. "Hay hamburguesa
			y papa frita xD Solo queda una papa xD"]],

			{"name", "María"},
			[["Ehh, ya."]],

			[[Bake se fue a calentar la comida, y mientras Croft
			hablaba de como alcanzó a agarrar solo su llave de cruz
			para defenderse y yo me hechaba galletas para pasar el
			hambre, Falcon bajó recién levantado.]],

			{"name", "Falcon"},
			[["Ehm, hola," dijo al ver a Croft. "Quien es el?"]],

			{"name", "Bake"},
			[["Se llama Croft. Es un chico que atropelló a María en
			la mañana, lol."]],

			{"name", "Falcon"},
			[["¿Q-Que?"]],

			{"name", "Bake"},
			[["Con su camioneta."]],

			{"name", "Falcon"},
			[["lol, ¿y estas bien?" me preguntó. Mas o menos, le
			hice con la mano.]],

			{"name", "María"},
			[["Bake dijo que tenías fiebre."]],

			{"name", "Falcon"},
			[["Si. Desperté terrible, pero ya se me está pasando.
			¿Me dejaron galletas?"]],

			{"name", "Bake"},
			[["No, vos tenés comida," dijo entrando con un poco de
			comida para ambos y con el agua caliente.]],

			{"name", "Falcon"},
			[["Aww :_3"]],

			{"name", "María"},
			[[Croft terminó de contar sobre nuestra huida de los
			tres zombies, y le preguntamos sobre como había pasado
			estos días.]],
		}
	}},
	{"bgm", "mod", "normal", fade={"fadeout", 2, true}},
	[[Croft bajó la mirada hacia su café. Tomó un sorbo y suspiró...]],
	{"bg", "mod", "root", fade={"color", {0,0,0,0}, 2}},
	2,
}
