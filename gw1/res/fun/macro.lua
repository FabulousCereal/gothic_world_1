local defaultTime = 3

local badends = {
	"Cave canem",
}

return {
	title = function(vars, _, showTitle, time)
		local idx, name
		if showTitle then
			idx = vars._idx1
			name = vars._title1
		else
			idx = vars._idx2
			name = vars._title2
		end
		local str = string.format("%d.%d\n%s", vars._idx1, idx, name)
		return {
			{"bg", "add",
				args=res.fun.card.card(res.style.title.fontFamily,
					48, str, "center")},
			time or defaultTime,
			{"bg", "rm"},
		}
	end,

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
		return {
			{"bg", "add", idx, args=genSub(dateString, "center")},
			wait,
			{"bg", "mod", idx, args=genSub(timeString, "center")},
			defaultTime,
			{"bg", "rm", idx},
		}
	end,

	badend = function(_, _, num)
		local str = badends[num]
		local t = defaultTime
		return {
			{"bg", "add",
				tween={"fadein", t, "delay", t, "fadeout", t, true},
				args=res.fun.card.title(res.style.title.fontFamily,
					48,
					string.format("Mal final %d:\n%s", num, str),
					"center")},
			t * 3,
		}
	end,
}
