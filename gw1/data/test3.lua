local a = {}

local b = {
	[[Exit whenever you want.]],
	{"select", {"a", "b", "c"}},
	{"case", {a, a, a}},
}

a[1] = [[Pick any.]]
a[2] = {"select", {"a", "b", "c"}}
a[3] = {"case", {b, b, b}}

return {
	[[Pick one.]],
	{"select", {"a", "b", "c"}},
	{"case", {a, a, a}},
}
