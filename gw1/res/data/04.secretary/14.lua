return {
	{"style", "vnMaria"},
	{"name", "María"},
	res.fun.macro.title,

	{"macro", res.fun.macro.date, {2011, 11, 12, 9, 59}},
	[[Caminaba absorta en mis pensamientos. Encontraba el silencio de la
ciudad casi desesperante a estas alturas, y ni siquiera los pájaros se oían ni
los perros ladrando.]],

	[[En cierto modo, era como si no pertenecieramos a esta ciudad.]],

	[[Bueno, yo en realidad no pertenecia. Pero aun si lo hiciera, sentía
que ya nadie debía permanecer aquí, y que los que quedabamos estabamos
transgrediendo un sepulcro.]],

	[[No sabía que le pasaba a Bake, si era por la herida o por algo que
había hecho mal. No pude evitar pensar que era en parte mi culpa por no poder
valerme sola.]],

	[[Distinguí a la distancia algunos edificios grandes, y fuí en
dirección a ellos. El hotel no lo recordaba bien por fuera, pero estaba
convencida de que si lo veía de frente lo reconocería de inmediato.]],

	[[¿Pero que hay de la sombra?]],

	[[La mera idea me hizo parar de inmediato, y no pude dar un paso mas.
No iba a debatirme sobre si era invento de Bake o que, o si tenía sentido que
aquella cosa siguiera rondando la misma area, no quería arriesgarme a nada.]],

	{"bgm", "set", "mula", 0,
		source="freesound/561724__ezzin__tractor-start.run_loop.flac",
		setup={setPitch=4/3},
		fade={"fadeto", 1/64, 4}},
	[[Di media vuelta y crucé de nuevo la calle. Me decía a mi misma que
no estaba entrando en pánico, pero claramente lo estaba.]],

	{"bgm", "mod", "mula", fade={"fadeto", 1/32, 4}},
	[[Tanto, que de nuevo no miré a ambos lados, y no me dí cuenta del auto
que patinaba por el hielo directo hacia mi.]],

	{"bgm", "mod", "mula", fade={"fadeto", 1/16, 4}},
	{"name", "-----"},
	[["¡CUIDADOOOO!"]],

--[[	{"bgm", "set", "mula", 0,
		source="freesound/561724__ezzin__tractor-start.run_loop.flac",
		setup={setPitch=4/3},
		fade={"fadeto", .125, 4}},]]
	{"bgm", "mod", "mula", fade={"fadeto", 1/8, 3}},
	{"bgm", "set", "auto", 0,
		source="freesound/71739__audible-edge__chrysler-lhs-tire-squeal-04.16.flac",
		fade={"fadein", 1.5},
		setup={seek=2.5, setPitch=3/3}},
	3,
	{"bgm", "rmall"},
	1.5,
}
