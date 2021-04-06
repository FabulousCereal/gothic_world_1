local seq = require("f0b._seqCommon")

-- Format: {"_fade", deltaVol, timeRemaining}
local function fadeCommon(track, fadeArgs, dt, finish)
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

local function fadeSetup(track, fadeArgs, dt, finish)
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
	return fadeCommon(track, fadeArgs, dt, finish)
end

local fadeOps = {
	-- Volume fading --
	-- {type, scaleFactor, rate}
	fadescale = fadeSetup,
		
	-- {type, targetVol, rate}
	fadeto = fadeSetup,

	-- {type, time}
	fadein = fadeSetup,
	fadeout = fadeSetup,

	_fade = fadeCommon,

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

local function trackUpdate(tracklist, dt, finish)
	for name, track in pairs(tracklist) do
		local fade = track.fade
		if fade and #fade ~= 0 then
			local remove = seq.update(fadeOps, track, fade, dt,
				finish)
			if remove == true then
				track.source:stop()
				tracklist[name] = nil
			end
		end
	end
end

local function modCopy(track, op)
	local copy = f0b.std.copy
	for key, val in pairs(op) do
		if type(val) ~= "number" then
			track[key] = copy(val)
		end
	end
end

local defaultAlias = true

local trackOps = {
	set = function(tracklist, op)
		if op[1] == nil then
			op[1] = defaultAlias
		end

		op.source = seq.normalizeSrc(res.bgm, op.source)
		if op[2] then
			op.source:setVolume(op[2])
		elseif op.fade and op.fade[1] == "fadein" then
			op.source:setVolume(0)
		end
		op.source:setLooping(op[3] ~= false)

		if op[4] ~= false and not op.source:play() then
			print("Failed to play track:", op[1])
		end

		tracklist[op[1]] = op
	end,

	rm = function(tracklist, op)
		local idx = op[1] or defaultAlias
		tracklist[idx].source:stop()
		tracklist[idx] = nil
	end,

	cmd = function(tracklist, op)
		local idx = op[1] or defaultAlias
		local source = tracklist[idx].source
		return source[op[2]](source, unpack(op, 3))
	end,

	cmdall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			local source = track.source
			source[op[1]](source, unpack(op, 2))
		end
	end,

	mod = function(tracklist, op)
		return modCopy(tracklist[op[1] or defaultAlias], op)
	end,

	modall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			modCopy(track, op)
		end
	end,

	finish = function(tracklist)
		return trackUpdate(tracklist, 0, true)
	end,

	clear = function(tracklist)
		for idx, track in pairs(tracklist) do
			track.source:stop()
			tracklist[idx] = nil
		end
	end,
}

return {
	ops = function(tracklist, op, directive)
		trackOps[op](tracklist, directive)
	end,

	update = trackUpdate,

	newTracklist = function(directive)
		local tracks = {}
		trackOps.set(tracks, directive)
		return tracks
	end,
}
