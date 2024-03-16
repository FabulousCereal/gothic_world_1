-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local defaultTime = 7/3

local badends = {
	"Cave canem",
}

local function title(vars, _, showTitle, time)
	local idx, name
	if showTitle then
		idx = vars._idx1
		name = vars._title1
	else
		idx = vars._idx2
		name = vars._title2
	end
	local str = string.format("Parte %d\n%s", idx, name)
	return {
		{"bg", "add",
			args=res.fun.card.card(res.style.title.fontFamily,
				48, str, "center")},
		time or defaultTime,
		{"bg", "rm"},
	}
end

local function fade(name, color, idx, secs, op)
	local c = color or nil
	local s = secs or 2/3
	local next = idx and idx+1 or nil
	return {
		{"bg", "mod", idx, fade={op, s, true}},
		{"bg", "add", next, args={name}, fade={"fadein", s}, color=c},
	}
end

return {
	rFade = function(_, _, name, color, idx, secs)
		return fade(name, color, idx, secs, "delay")
	end,

	xFade = function(_, _, name, color, idx, secs)
		return fade(name, color, idx, secs, "fadeout")
	end,

	title = title,

	date = function(_, _, args)
		local months = {"Enero", "Febrero", "Marzo", "Abril",
			"Mayo", "Junio", "Julio", "Agosto",
			"Septiembre", "Octubre", "Noviembre", "Diciembre"}
		local year, month, day, hour, min = unpack(args)
		local idx = args.idx
		local wait
		if args.wait then
			wait = {"wait", unpack(args.wait)}
		else
			wait = defaultTime
		end

		local dateString = string.format("%u/%s/%u",
			day, months[month], year)
		local timeString = string.format("%.2u:%.2u", hour, min)
		local genSub = res.fun.card.subtitle
		local white = {1, 1, 1, 1}
		return {
			{"bg", "add", idx, args=genSub(dateString, "center"), color=white},
			wait,
			{"bg", "mod", idx, args=genSub(timeString, "center"), color=white},
			defaultTime,
			{"bg", "rm", idx},
		}
	end,

	titleDate = function(_, _, args)
		return {
			title,
			{"macro", "date", args}
		}
	end,

	badend = function(_, _, n)
		local str = badends[n]
		local t = defaultTime
		return {
			{"bg", "add",
				fade={"fadein", t, "delay", t, "fadeout", t, true},
				args=res.fun.card.card(res.style.title.fontFamily,
					48,
					string.format("Mal final %d:\n%s", n, str),
					"center")},
			t * 3,
			{"bg", "sync"},
		}
	end,
}
