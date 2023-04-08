local function laAmigaSale(_, _, delay)
	return {
		{"bg", "mod", 2, tween={"delay", delay, "fadeout", 1, true}},
		{"bg", "add", 2, args={"cafe/amiga4.png"},
			color=res.palette("fivepm", 0),
			tween={"delay", delay, "fadein", 1}},
	}
end

return {
	{"bgm", "set", "song", 0,
		source="muchtoolow2.ogg",
		fade={"fadeto", 2/3, 4}},

	{"style", "vnBake"},
	[[...Much too hiiiiiigh, much too hiiiiiaiaiaiiaIAIIIAIIgh... (8)]],
	[[(much too high...) (8)]],

	{"name", "Bakeritsu"},
	[[Lo recuerdo como si hubiera sido ayer. Ocurrió ayer martes en la
tarde.]],

	{"bg", "add", args={"cafe/bg.png"}, color=res.palette("fivepm")},
	{"bg", "add", args={"cafe/amiga1.png"}, color=res.palette("fivepm")},
	{"bg", "add", args={"cafe/cup.png", 279, 365},
		color=res.palette("fivepm")},

	{"bg", "add", args=f0b.elem.screenFill, color={0,0,0,1},
		tween={"fadeout", 3, true}},
	{"macro", res.fun.macro.date, {2011, 11, 8, 17, 34}},

	[[Estaba tocando "One in a Million" para una amiga en una cafetería
cerca de su casa. No recuerdo su nombre, pero estaba bien buena (xD).

Terminando de tocar sucede la explosión.]],

	{"bgm", "mod", "song", fade={"fadeto", 0, 1}},
	1,

	{"name", false},
	{"bg", "mod", 1, color=res.palette("redbg")},
	{"bg", "mod", 3, color=res.palette("redbg")},
	{"sfx", "sfx/explosión lejana.flac", .5},
	[[......*boom*]],

	{"bg", "sync"},
	{"bg", "mod", 2, tween={"fadeout", 1, true}},
	{"bg", "add", 2, args={"cafe/amiga2.png"},
		color=res.palette("fivepm", 0), tween={"fadein", 1}},

	{"bgm", "mod", "song", fade={"cmd", {setPitch=1/3}, "fadeto", 2, 2}},

	{"name", "amiga"}, [["¿Que fue eso?"]],
	{"name", "Bakeritsu"}, [["¿Que fue que?"]],
	{"name", "amiga"}, [["Escuché una explosión."]],
	{"name", "Bakeritsu"}, [["huh"]],
	[[Parecía hablar en serio, pero por mas que puse atención no oí nada
mas.]],

	[[Mis amigos tampoco sabían de que hablaba, afuera todo se veía normal.
"Debió ser un camión," dije, pero a los minutos notamos que había un humo raro
en la calle.]],

	{"bg", "mod", 2, tween={"fadeout", 1, true}},
	{"bg", "add", 2, args={"cafe/amiga3.png"},
		color=res.palette("fivepm", 0), tween={"fadein", 1}},
	[[La chica se veía muy inquieta con todo esto, pero a mi no me parecía
importante. Le dije en todo caso que mejor no salieramos, por las dudas.]],

	[[Quizás fue la decisión correcta. Al rato la gente de afuera se veía
mareada o vomitando.]],

--	{"macro", laAmigaSale, .5},
	[[Ella entonces dijo que iria a ver que pasaba.]],

	{"select", nil, {
		"No vayas.",
		"Espera..."}
	},
	{"case", nil, {
		{
			[["Deja que pase, no creo que sea nada," le dije para
			que se calmara.]],
			{"name", "amiga"},
			[["¿Pero y si es grave?" respondió nerviosa.]],

			{"macro", laAmigaSale, 0},

			{"name", "Bakeritsu"},
			[[La chica partió de todas formas a asomarse mientras
			nosotros nos quedamos esperando.]],

			{"name", "amigo"},
			[["...Está buena en todo caso," dijo mi amigo.]],
			{"name", "amigo2 que secretamente es gay"},
			[["Yeah."]],
			{"name", "Bakeritsu"},
			[["lol, si," dije mientras mis amigos reían en
			silencio.]],
		},

		{
			[["Espera," le dije antes que se fuera. Ella me miró a
			los ojos. Su labio temblaba.]],
			{"name", "amiga"},
			[["¿Que?"]],
			{"name", "Bakeritsu"},
			[["...Traeme un helado ya que te paraste, lol."]],

			{"macro", laAmigaSale, .75},

			[[La chica me miró feo y partió mientras mis amigos
			reían.]],
		},
	}},		

	{"bgm", "rm", "song"},
	{"bg", "sync"},
	{"bg", "rm", 1, 2},
	{"bg", "mod", color=res.palette("redbg")},

	{"sfx", "freesound/71741__audible-edge__nissan-maxima-handbrake-turn.cut.flac"},
	{"sfx", "freesound/204777__ngruber__breaking-glass.cut.flac", 1/3, .8, 4/3},
	{"sfx", "freesound/675902__craigsmith__s38-24-big-heavy-car-crash.16.flac",
		1, 1, 4/3},
	{"sfx", "freesound/488158__sleepskraper__female_scream.flac", 1, 1.05, 2},
	[[No dió ni diez pasos cuando un auto atraviesa el vidrio y justo
golpea a la que estaba bien buena.]],

	[["Oh shit"]],

	{"bg", "mod", tween={"mvdiff", 0, -120, 2}},
	[[Apenas bajó el polvo corrimos a ayudar y a putear al conductor y a la
chica. El dueño de la cafetería apareció furioso y cagó al conductor a palos,
mientras mis amigos corriamos el auto.]],

	[[La chica parecía estar mas mal de lo que se veía, para haber sido
atropellada. Llamamos una ambulancia de inmediato, y sorprendentemente llegó en
pocos minutos. La subieron a ella y al conductor que ahora tenía contusiones y
se fueron.]],

	[["¿Que demonios le pasa a la gente?" pensé.]],

	{"name", "amigo"},
	[["Si, es muy raro," respondió uno de mis amigos.]],

	{"name", "Bakeritsu"},
	[[Nos metimos mas adentro a esperar a que el extraño fenómeno pasara,
pero al final la curiosidad mató al gato. Nos subimos al auto tapandonos la
cara y fuimos a mi casa.]],

	{"bg", "add", 1, args={"cafe/ext.png"},
		color=res.palette("fivepm", 0), tween={"fadein", 3}},
	{"bg", "mod", tween={"fadeout", 3, true}},
	[[En el camino había mucha gente tirada en las calles.]],

	[[No sabiamos que estaba pasando, pero lo que había dicho la chica
sobre la explosión nos empezó a preocupar. A momentos se sentía un olor
metálico en el aire... Casi como sangre.]],

	{"bg", "sync"},
	{"bg", "add", args=f0b.elem.screenFill,
		color=res.palette("sixpm", 1, .8)},
	{"bg", "add", args={res.fun.clock.wall(res.style.clockMono, 19, 22,
		"Saikō")}, color=res.palette("sixpm")},
	{"bg", "fold"},
	{"bg", "mod", tween={"fadein", 2/6}},
	[[Llegamos casi oscuresciendo, y nos bañamos por las dudas. Faltabamos
solo yo y mi amigo cuando el me dice que sería mejor que nos bañaramos juntos,
para lavarnos mejor. Asi que eso hicimos.]],

--	{"bg", "mod", tween={"fadeout", 4/6, true}},
	{"bg", "rm"},
	{"wait", 1},
	{"bg", "add", args={"bake/y su amigo.png"},
		color=res.palette("sixpm", 0, 0.9), tween={"fadein", 4/6}},
	{"wait", 1},
	[[Posiblemente eso fue lo que me salvó.]],

	{"bg", "sync"},
	{"bg", "mod", tween={"fadeout", 4/6, true}},
	{"wait", 4/6},

	{"bg", "add", args={"bake/amigos-en-el-living.png"},
		color={.8, .6, 1, 0}, tween={"fadein", 4/6}},
	[[Envueltos solo con la luz del crepúsculo, salimos de la ducha y nos
fuimos al living. Mis amigos ya habían prendido la tele...]],
	{"bg", "sync"},
	{"bg", "mod", tween={"fadeout", 4/6, true}},
	{"wait", 1},
}

--[=[	[[Resultó que esto era mas grande de lo que pensamos. Estaba la
explosión en todos los canales, muchos decian que habían muerto unas 20 personas.]],

	[[Tambien hablaban del radio infectado, y cuanto duraría esta capa.
Eran muchos kilómetros increiblemente, eran unos 100 km. Aunque no hicieron
nada para evacuar, era obvio lo que teniamos que hacer pero no nos dimos
cuenta. Seguimos mirando...]],

	[[De pronto, lo que parecía un ingeniero mordió el cuello de un
periodista dejandolo casi decapitado.]],
--	{"sfx", "munch"},
	false,
	[[Y así empezó la cadena de zombies mutados. Luego con la radiación se
propagaría la enfermedad que causaría zombies pero no mutados.]],
	{"bg", "set", 1, args=common.sub.subtitle("20:52")},
	false,
	{"bg", "rm", 1},
	[[Con mis amigos fuimos a ver a la chica al hospital, el cual estaba
increiblemente lleno. Había demasiada gente, el solo estar en la sala de estar
te daba claustrofobia. Era demasiado insoportable el ambiente asi que nos
fuimos cada uno para su casa.]],

	{"bg", "set", 1, args=common.sub.subtitle("21:31")},
	false,
	{"bg", "rm", 1},
	[[Llegué a mi casa, no había nadie, mis padres se habian ido de
vacaciones, así que cerré todo con llave, agarré el arma de mi viejo y música a
todo lo que daba.]],
--	{"bg", "mplay", "elreal", wait=10},
--	{"bg", "mstop", 3},
	[[Me fuí a dormir una vez me aburrí del ruido. Durante la noche oí las
sirenas policiales en la lejanía, pero poco a poco fueron desapareciendo. En la
mañana, estaba todo silencioso.]],
	false,
}
--]=]
