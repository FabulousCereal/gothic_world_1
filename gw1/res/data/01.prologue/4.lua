local endFade = {"fadeout", 1/24, true}
return {
	{"bgm", "set", source="Grave Maria.ogg"},
	{"style", "vnBake"}, {"name", "Bake"},
	[[Me senté junto a mis amigos sin despegar la vista de la pantalla.
Resultó que esto era mas grande de lo que pensamos.]],

	{"bg", "add", args={"fab/tv.png"}},
	{"style", "vnFab"}, {"name", "Televisión"},
	[["A eso de las 17:34 horas en XXXXX, XXXXXXXXX, se habría registrado
una enorme explosión en una fábrica de tapas de inodoros en la comuna de XXXX
en la zona sur de la ciudad."]],

	{"style", "vnFalcon"}, {"name", "------"},
	[[Advertían que no salieran de sus hogares, que el humo era tóxico, el
gobierno había declarado estado de emergencia mientras yo dormía al lado de la
fábrica.]],

	{"bg", "mod", args={"bake/noticias.png"}, color=res.palette("tenpm")},
	{"style", "vnBake"}, {"name", "Bake"},
	[[Estaba la explosión en todos los canales. Decían que habían muerto
unas 20 personas y no se cuantos heridos. También hablaban del radio
contaminado, y cuanto duraría esta capa.]],

	{"bg", "mod", args={"fab/tv.png"}, color={1,1,1,1}},
	{"style", "vnFab"}, {"name", "Televisión"},
	[["De tener que salir, las autoridades recomiendan cubrirse la nariz y
la boca con un paño húmedo..."]],

	{"bg", "mod", args={"falcon/tv.png"}, color=res.palette("tungsten")},
	{"style", "vnFalcon"}, {"name", "------"},
	[[Los síntomas incluyen mareos, nauseas, falta de concentración,
ahogamiento. Gané el puto bingo.]],

	{"style", "vnBake"}, {"name", "Bake"},
	[[La nube era de muchos kilometros increíblemente, cubría unos 100 km.
Aunque no hicieron nada para evacuar era obvio lo que teniamos que hacer pero
no nos dimos cuenta. Seguimos mirando...]],

	{"bg", "mod", args={"fab/tv.png"}},
	{"bg", "add", args={"fab/tv-over.png"}},
	{"style", "vnFab"}, {"name", "Televisión"},
	[["Se desconoce si el humo produce efectos permantentes..."]],

	{"style", "vnFalcon"}, {"name", "------"},
	[[No sabía si tenía familia o amigos. ¿Que iba a hacer ahora?]],

	{"style", "vnBake"}, {"name", "Bake"},
	[[De pronto, lo que parecía un ingeniero mordió el cuello de un
periodista dejandolo casi decapitado.]],

	{"style", "vnFalcon"}, {"name", "------"},
	[[El periodista comenzó a balbucear frente a la camara, atacando al
camarógrafo.]],

	{"style", "vnFab"}, {"name", "Fabian"},
	{"bgm", "rmall"},
	{"bg", "rmall"},
	[[La tele se apagó junto con la lúz.]],
	[[Me acerqué a mirar por la ventana, y todo el sector en que me hayaba
había quedado a oscuras. Podía aún ver la luz anaranjada a lo lejos en la
ciudad, reflejado en el humo que cubría el cielo.
Ni siquiera la luna era visible...]],

	{"style", "vnMaria"}, {"name", "María"},
	[[Me quedé inmóvil frente a la televisión aún luego de que la luz se
fuera. Abrazaba mis pies fuertemente. No creía lo que estaba pasando afuera.]],

	{"bgm", "set", source="dedededededos.ogg"},
	{"bg", "add",
		args=res.fun.card.card(res.style.title.fontFamily, 72, "Gothic World", "center")},
	6.3,
	{"bgm", "modall", fade=endFade},
	{"bg", "modall", fade=endFade},
	{"wait", 1, true},
}
