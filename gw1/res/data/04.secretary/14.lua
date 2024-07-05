return {
	{"style", "vnMaria"},
--	{"bgm", "set", "wind", source="wahwahwhite noise.ogg",
--		setup={setFilter={type="lowpass", highgain=0}}},
	{"bgm", "set", "hero",
		source="RECSNG11 - Fall of the Hero (boceto).ogg"},
	{"macro", "titleDate", {2011, 11, 12, 9, 59}},

	{"name", "María"},
	[[Caminaba absorta en mis pensamientos. Encontraba el silencio de la
ciudad casi desesperante a estas alturas, al punto de tener que contener ganas
de gritar.]],

	[[En cierto modo, era como si no pertenecieramos a esta ciudad
maldita.]],

	[[Bueno, yo en realidad no pertenecia. Pero aun si fuera así, sentía
que ya nadie debía permanecer aquí. Que los que quedabamos estabamos
transgrediendo un sepulcro.]],

	[[Ejem... dejando mis desvarios dramáticos atrás, no entendía que le
pasaba a Bake. Si era por la herida o por algo que había hecho mal.]],

	[[No pude evitar pensar que era en parte mi culpa por no poder valerme
sola.]],

	[[Distinguí a la distancia algunos edificios grandes, y fuí en
dirección a ellos. El hotel no lo recordaba bien por fuera, pero estaba
convencida de que si lo veía de frente lo reconocería de inmediato.]],

	{"bgm", "fade", "hero", {"fadeout", 2, true}},
	[[¿Pero que hay de la Sombra?]],

	[[La mera idea me hizo parar de inmediato, y no pude dar un paso mas.
No iba a debatirme sobre si era invento de Bake o que, o si tenía sentido que
aquella cosa siguiera rondando la misma area.]],

	{"bgm", "set", "mula", 0,
		source="freesound/561724__ezzin__tractor-start.run_loop.flac",
		setup={setPitch=4/3},
		fade={"fadeto", 1/32, 4}},
	[[Di media vuelta y crucé de nuevo la calle. Mi respiración se
aceleraba mientras me decía a mi misma que no estaba entrando en pánico.]],

	{"bgm", "fade", "mula", {"fadeto", 1/16, 4}},
	[[Tanto, que de nuevo no miré a ambos lados, y no me dí cuenta del auto
que patinaba por el hielo directo hacia mi.]],

	{"bgm", "fade", "mula", {"fadeto", 1/8, 4}},
	{"name", "-----"},
	[["¡CUIDADOOOO!"]],

--[[	{"bgm", "set", "mula", 0,
		source="freesound/561724__ezzin__tractor-start.run_loop.flac",
		setup={setPitch=4/3},
		fade={"fadeto", .125, 4}},]]
	{"bgm", "fade", "mula", {"fadeto", 1/4, 3}},
	{"bgm", "set", "auto", 0,
		source="freesound/71739__audible-edge__chrysler-lhs-tire-squeal-04.16.flac",
		fade={"fadein", 1.5},
		setup={seek=2.5, setPitch=3/3}},
	3,
	{"bgm", "rmall"},
	1.5,
}
