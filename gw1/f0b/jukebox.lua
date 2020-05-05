local f0b_internal = require("f0b._internal")

local seqUpdate = f0b_internal.seqUpdate

-- Format: {"_fade", deltaVol, (time)remaining}
local function internalFade(track, fadeArgs, dt, finish)
	local source = track.source
	local deltaVol = fadeArgs[2]
	local remaining = fadeArgs[3]
	if dt > remaining or finish then
		dt = remaining
	end

	local newVol = source:getVolume() + deltaVol * dt
	if newVol < 0 then
		newVol = 0
	end
	source:setVolume(newVol)

	if remaining > 0 then
		fadeArgs[3] = remaining - dt
	else
		return 3
	end
end

local function fadeSetCommon(track, fadeArgs, dt, finish)
	local startVol = track.source:getVolume()
	local targetVol
	local rate
	local name = fadeArgs[1]
	if name == "fadeout" then
		targetVol = 0
		rate = fadeArgs[2]
		table.insert(fadeArgs, 3, rate)
	elseif name == "fadein" then
		targetVol = 1
		rate = fadeArgs[2]
		table.insert(fadeArgs, 3, rate)
	else
		if name == "fadeto" then
			targetVol = fadeArgs[2]
		elseif name == "fadescale" then
			targetVol = startVol * fadeArgs[2]
		end
		rate = fadeArgs[3]
	end

	fadeArgs[1] = "_fade"
	fadeArgs[2] = (targetVol - startVol) / rate
	return internalFade(track, fadeArgs, dt, finish)
end

local fadeOps = {
	-- Volume fading --
	-- {type, scaleFactor, rate}
	fadescale = fadeSetCommon,
		
	-- {type, targetVol, rate}
	fadeto = fadeSetCommon,

	-- {type, time}
	fadein = fadeSetCommon,
	fadeout = fadeSetCommon,

	_fade = internalFade,

	delay = function(track, fadeArgs, dt, finish)
		local secs = fadeArgs[2]
		if secs > 0 and not finish then
			fadeArgs[2] = secs - dt
		else
			return 2
		end
	end,

	cmd = function(track, fadeArgs, dt, finish)
		local source = track.source
		local cmd = fadeArgs[2]
		source[cmd](source, unpack(fadeArgs[3]))
		return 3
	end,
}

local trackUpdate = function(tracklist, dt, finish)
	for name, track in pairs(tracklist) do
		local fade = track.fade
		if fade and #fade > 0 then
			local remove = seqUpdate(fadeOps, track, fade, dt,
				finish)
			if remove == true then
				track.source:stop()
				-- The lua manual says this is fine
				tracklist[name] = nil
			end
		end
	end
end

local trackOps = {
	set = function(tracklist, op)
		tracklist[op[1]] = op
		if op[2] then
			if not op.source:play() then
				print("Failed to play track:", op[1])
			end
			if type(op[2]) == "number" then
				op.source:setVolume(op[2])
			end
		end
		local loop = op[3] ~= false
		op.source:setLooping(loop)
	end,

	rm = function(tracklist, op)
		local source = tracklist[op[1]].source
		source:stop()
		tracklist[op[1]] = nil
	end,

	cmd = function(tracklist, op)
		local source = tracklist[op[1]].source
		source[op[2]](source, unpack(op, 3))
	end,

	cmdall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			local source = track.source
			source[op[1]](source, unpack(op, 2))
		end
	end,

	mod = function(tracklist, op)
		local idx = op[1]
		for key, value in pairs(op) do
			tracklist[idx][key] = value
		end
	end,

	modall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			for key, value in pairs(op) do
				track[key] = value
			end
		end
	end,

	finish = function(tracklist, _)
		return trackUpdate(tracklist, 0, true)
	end,

	clear = function(tracklist, op)
		for idx, track in pairs(tracklist) do
			track.source:stop()
			tracklist[idx] = nil
		end
	end,
}

return {
	ops = function(tracklist, directive)
		local op = table.remove(directive, 1)
		return trackOps[op](tracklist, directive)
	end,

	update = trackUpdate,
}
