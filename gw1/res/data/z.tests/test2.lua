local frDie = {"bg", "mod", args={"franziska/die.png"}}
local bgmStopAll = {"bgm", "modall", fade={"fadeout", 1/6, true}}

local franDies = {"read", {
	frDie,
	{"name"},
	[[Frankiska levanta su arma, pero no hace nada.]],
	{"bg", "mod", args={"franziska/normal.png"}},
	{"name", "Francisca"},
	[[Lo siento, no puedo.]],
	{"bg", "rm"},
	{"name"},
	[[Francisca se dispara, y muere.]],
}}

local final = {
	{"=", "dead", false},
	{"select", nil, {
		[["Fascinante."]],
		[["Demasiada información, puta. Acabemos la entrevista."]],
		[["Tras oír tu cuento, me he convertido en llanto. Por favor,
			mátame."]]}
	},
	{"case", nil, {
		{
			[["¡Gusana inútil! ¡Muere!"]],
			franDies,
		},
		{
			[["..."]],
			[["Bueno."]],
			{"bg", "rm"},
		},
		{
			[["Está bien."]],
			franDies,
		},
	}},

}

local hermanos = {
	[["Si. Franzczsckisko, y Francio. Yo soy la mayor."]],
	[["No los he visto hace mucho, así que no sé en que andan por estos
días."]],
	[["Franxzaxisko dijo que buscaría algo en un desierto. Siempre pensé
que era una broma, pero resultó ser cierto. O eso espero. Nunca entendí su
sentido del humor."]],
	[["Francio se mudó con unos amigos del servicio a Inglaterra. Nunca
hablaba mucho sobre lo que le pasaba, pero creo que tuvo un problema feo con
una mujer."]],
	[["Nunca fui cercana con ellos, a pesar de haber crecido juntos en la
miseria. Hay días en que pensar en eso me da algo de pena... Es una sensación
extraña, no sabría describirla."]],
	[["Sigo esperando que ellos se acerquen a mí eso si. No pienso
buscarlos."]],

	{"read", final},
}

local laFamilia = {
	[["Al siempre fue un mal padre. Alcohólico. Inestable. Nunca quiso a mi
madre, y creo que nunca le importaron los hijos que tuvo."]],
	[["A veces se iba durante semanas sin explicación, y luego regresaba
con regalos baratos como si con eso se arreglara lo que había roto en
nosotros."]],
	[["Mi madre siempre fue demasiado tolerante con el, decía que Al
siempre pensaba en nosotros, pero yo me daba cuenta."]],
	[["Un día, dijo formalmente que no podía seguir con nosotros. Dijo que
le gustaban los lagartos, no las mujeres. Que esta familia que había formado
era falsa para el, no podía amarla."]],
	[["Mi madre quedó devastada, mientras el salía sonriente a subirse al
descapotable de un lagarto con el que salía."]],
	[["Ese desgraciado... ¿Tenía que hacernos todo este daño por estupidez
suya?"]],
	[["¿Por que no pudo pretender hasta que hubieramos crecido? ¿Por que no
pudo desaparecer antes de que pudieramos recordarlo?"]],
	[["Lo detesto."]],
	[["Un día me lo encontré en la calle. Durante el desastre. Yo tenía mi
rifle de balas explosivas a mano."]],
	[["Sentí la ira acumulada de todos esos años volviendo cuando me miró,
pero el ni siquiera se inmutó. Era como si de nuevo yo no le importara."]],
	[["Traté de levantar el rifle para apuntarle... Pero no pude. Rompí en
lágrimas."]],
	[["El se fue una vez más, como siempre hacía. Me dejó hecha un
desastre, como siempre hacía."]],

	{"read", final},
}

local laHistoriaDeAl = {
	[["¿A mi? Nada. Pero le hizo mucho daño a mi madre."]],
	[["A todos nosotros, en realidad."]],

	{"select", nil, {
		[["¿Por que?"]],
		[["Oh, ¿tienes hermanos?"]],
		[["Me cago en Buda."]]}
	},
	{"case", nil, {
		laFamilia,
		hermanos,
		{
			bgmStopAll,
			[["¿Que esperas conseguir diciendo eso? ¿Que mierda
			tienes en la cabeza?"]],
			frDie,
			[["No respondas, pierdo tiempo de matarte."]],
		}
	}},
}

local elGusanoDeAl = {
	{"bgm", "mod", "raev", fade={"fadeout", 1/3, true}},
	[["¿Al? ¿Ese depravado?"]],
	[["...Es mi padre."]],

	{"bgm", "set", "crotal", 1, source="crotal.ogg"},
	{"bg", "mod", args={"franziska/shock.png"}},
	{"select", nil, {
		[["¿En serio?"]],
		[["¿Que te hizo?"]]}
	},
	{"case", nil, {
		{
			bgmStopAll,
			[["Maldita gusana, ¿crees que miento?"]],
			frDie,
			[["Morí."]],
		},
		laHistoriaDeAl,
	}}
}

local falconEsUnInsecto = {
	[["¡Eso fue culpa de Falcon!"]],
	[["Armó un bardo para que permaneciera muerta."]],

	{"select", nil, {
		[["Hablemos de Isma."]],
		[["Hablemos mejor de Al."]]}
	},
	{"case", nil, {
		{
			frDie,
			[["No."]],
		},
		elGusanoDeAl
	}},
}

local fabTeniaRazon = {
	[["...Si. Se acerca más a la realidad."]],
	[["Pero eso no significa que me agrade ese insecto."]],

	{"select", nil, {
		[["Pero luego dijo que pediste que te mataran."]],
		[["Pero Martín si te agradaba, ¿eh?"]]}
	},
	{"case", nil, {
		falconEsUnInsecto,
		{
			bgmStopAll,
			frDie,
			[["Muere, desgraciada."]],
		}
	}},
}

local malditosInsectos = {
	[["¡Eso es mentira!"]],
	[["Maldito."]],

	{"select", nil, {
		[["Pero yo lo ví."]],
		[["¿Entonces Fab tenía razón?"]]}
	},
	{"case", nil, {
		{
			frDie,
			[["¿Ah si? Mira este cañón, gusana."]],
		},
		fabTeniaRazon
	}}
}

return {
	{"let", "dead", true},

	{"style", "vnMaria"},
	[[Repentinamente, te encuentras frente a frente con Franszciska.]],
 
	{"bg", "add", args={"franziska/normal.png"}},
	{"name", "Franzszczcskiszka"},
	[["¿Que quieres?"]],

	{"bgm", "set", "raev", 2/3, source="raev.ogg"},
	{"select", nil, {
		[[Dí "Me gusta el pan con pollo."]],
		[[Dí "Falcon tuvo razón, si morí."]]}
	},
	{"case", nil, {
		{
			[["¿Que diga que?"]],
			bgmStopAll,
			frDie,
			[["Muere, gusana."]],
		},
		malditosInsectos,
	}},

	bgmStopAll,
	{"bg", "rm"},
	{"name"},
	{"case", "dead", {
		[true] = {
			[[Has muerto.]],
			{"return", false}
		},

		[false] = {
			[[Has sobrevivido a la entrevista con Fraziskana.
				Bien hecho, pero no hay premio.]],
			{"return", true}
		}
	}},
}
