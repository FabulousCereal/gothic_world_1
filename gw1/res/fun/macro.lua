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

return {
	bgFade = function(_, _, img, subidx, secs)
		if type(img) ~= "table" then
			img = {args={img}}
		end
		subidx = subidx or 1
		img[1], img[2], img[3], img[4]
			= "bg", subidx, "add", 1
		return {
			{"bg", subidx, "mod", 1,
				fade={"fadeout", secs or 1, true}},
			img,
		}
	end,

	rFade = function(_, _, img, color, idx, secs)
		local s = secs or 2/3
		local next = idx and idx+1 or nil
		if type(img) == "string" then
			img = {args={img}}
		end
		img[1], img[2], img[3] = "bg", "add", next
		img.color=color or nil
		img.fade={"fadein", s}
		return {
			{"bg", "mod", idx, fade={"delay", s, true}},
			img,
		}
	end,

	mesa = function(_, _, secs, ...)
		local bw = 6
		local w, h = love.graphics.getDimensions()
		local y = 3/4
		secs = secs and {"fadein", secs}
		return {{
			args={
				{
					borderColor={0,0,0,1}, borderWidth=bw,
					backgroundColor={3/5,1/3,0,1},
				}, -bw, h * y, w + bw*2 + w/3, h * (1 - y) + bw,
				0, 0, -.2,
			},
			draw = f0b.draw.rect,
			fade = secs,
			"bg", ...
		}}
	end,

	mv = function(x, t)
		return {"bg", "modr", 2, 3, fade={"mvabs", x, false, t}}
	end,

	title = title,

	date = function(_, _, args)
		local months = {"Enero", "Febrero", "Marzo", "Abril",
			"Mayo", "Junio", "Julio", "Agosto",
			"Septiembre", "Octubre", "Noviembre", "Diciembre"}
		local year, month, day, hour, min = unpack(args)
		local idx = args.idx
		local wait = args.wait
			and {"wait", unpack(args.wait)}
			or defaultTime

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
