return {
	{"style", "vnMaria"},
	{"bgm", "set", "wind", 0.5, source="wahwahwhite noise.flac",
		setup={setFilter={type="lowpass", volume=1, highgain=0}},
		fade={"fadeto", 1, 6},
	},
	res.fun.macro.title,

	{"name", "María"},
	{"bgm", "set", "intro", 0, source="newgw-dolce.ogg",
		fade={"fadeto", 1, 12}},
	[[Tuve un sueño mientras dormía.]],

	{"bgm", "set", "w", 0, source="olas.ogg",
		fade={"fadeto", 0.5, 12}},
	{"bg", "add", args={"Flash/Atardecer.png"}, fade={"fadein", 6}},
	[[Me encontraba sola en una inmensa playa junto a la ciudad.]],

	[[Sus restos se veían en la distancia, los rascacielos semejantes a la
carcasa de una criatura que día a día se descomponía. El sol de la tarde se
reflejaba fragmentado en las ventanas rotas.]],

	[[En eso, noté que había una mochila junto a mis pies.]],

	[[Habían cosas de los demás adentro. Tenía las armas de los chicos,
pero también las pastillas antivirales y paquetes de arroz.]],

	[["¿Donde está el tubo?" No sé por que me preocupaba eso. Miré a mi
alrededor como esperando encontrarlo, pero la playa estaba limpia.]],

	[[Revisé de nuevo y encontré un imán gigante entre las cosas. Era raro,
pero pensé que todo estaba en orden entonces.]],

	[[Me puse la mochila. ¿Hacia donde debía caminar? Todo lo que veía
era la ciudad y las montañas en la distancia.]],

	[[Aún indecisa, una paloma negra llegó a pararse a unos metros de mi.
Mi pecho se apretó y mis ojos se humedecieron al verla, como si viera una vieja
amiga que pensé no volvería a ver.]],

	[["Ruu." La paloma se volteó de un salto hacia el océano.]],

	{"bgm", "mod", "w", fade={"fadeto", 1, 3}},
	[[Me voltée a mirar las olas, y el viento levantó la bruma marina sobre
nosotras. El olor salado y el ruido nos envolvieron, y atraida por estos me
acerqué al borde.]],

	{"bg", "add", draw=f0b.draw.screenFill, color={1,.62,.25,0}},
	{"bg", "add",
		draw=f0b.draw.screenFill,
		color={.75,1,1,0},
		shader=res.shader.fbmRipple{
			mul={1,1}, add={-.5,-2}, rolloff=.8, amplitude=0.2,
			mv=res.fun.complex.shaderTime(0, 1/8),
			alphaMask=2/3,
		},
	},
	{"bg", "mod", 2, 3, fade={"fadein", 3}},
	{"bg", "mod", 1, fade={"delay", 3, true}},
	[[El ruido del mar se hizo mas fuerte. Quería ver el agua antes de
decidir.]],
	{"bg", "fn", 0, function(layer)
		layer.shader.time=res.fun.complex.shaderTime(
			8, 0, (-love.timer.getTime()+2.25) * 8
		)
	end},
	{"bgm", "mod", "w", "intro", fade={"fadeout", 4, true}},
	{"bg", "modall", fade={"delay", .5, "fadeout", 2.5, true}},
	{"wait", 4, true},
}
