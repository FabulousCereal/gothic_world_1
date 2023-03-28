-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

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
		if secs == "remaining" then
			local src = track.source
			secs = (src:getDuration("seconds") - src:tell("seconds"))
				* (1/src:getPitch())
		end
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

local function jukeMod(track, op)
	for k, v in pairs(op) do
		if type(v) == "table" then
			track[k] = f0b.table.deepCopy(v)
		else
			track[k] = v
		end
	end
end

local function getAlias(op)
	local defaultAlias = true
	return op[1] ~= nil and op[1] or defaultAlias
end

local trackOps = {
	set = function(tracklist, op)
		op[1] = getAlias(op)
		op.source = seq.normalizeSrc(res.bgm, op.source)
		op.source:setVolume(op[2] or 1)

		local setup = {play = true, setLooping = true}
		if op.setup then
			setup = f0b.table.union(setup, op.setup)
		end
		for k, v in pairs(setup) do
			if k == "play" then
				if v then
					op.source:play()
				else
					op.source:stop()
				end
			else
				op.source[k](op.source, v)
			end
		end
		tracklist[op[1]] = op
	end,

	rm = function(tracklist, op)
		local idx = getAlias(op)
		tracklist[idx].source:stop()
		tracklist[idx] = nil
	end,

	rmall = function(tracklist)
		for idx, track in pairs(tracklist) do
			track.source:stop()
			tracklist[idx] = nil
		end
	end,

	cmd = function(tracklist, op)
		local idx = getAlias(op)
		local source = tracklist[idx].source
		source[op[2]](source, unpack(op, 3))
	end,

	cmdall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			local source = track.source
			source[op[1]](source, unpack(op, 2))
		end
	end,

	mod = function(tracklist, op)
		local idx = getAlias(op)
		jukeMod(tracklist[idx], op)
	end,

	modall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			jukeMod(track, op)
		end
	end,

	sync = function(tracklist)
		return trackUpdate(tracklist, 0, true)
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
