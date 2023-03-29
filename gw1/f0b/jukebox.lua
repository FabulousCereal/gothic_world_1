-- SPDX-FileCopyrightText: 2023 Grupo Warominutes
-- SPDX-License-Identifier: Unlicense

local seq = require("f0b._seqCommon")

local function srcSetup(src, setup)
	for k, v in pairs(setup) do
		if k == "play" then
			if v then
				src:play()
			else
				src:stop()
			end
		else
			src[k](src, v)
		end
	end
end

-- Format: {"_fade", deltaVol, timeRemaining}
local function jukeboxFade(track, fadeArgs, dt)
	local src = track.source
	src:setVolume(seq.fadeCommon(src:getVolume(), fadeArgs, dt))
	if fadeArgs[3] <= 0 then
		return 3, fadeArgs[3]
	end
end

local function fadeSetup(track, fadeArgs, dt)
	return seq.fadeSetup(track, fadeArgs, dt, track.source:getVolume(),
		jukeboxFade)
end

local fadeOps = {
	-- Volume fading --
	-- {type, targetVol, rate}
	fadeto = fadeSetup,

	-- {type, time}
	fadein = fadeSetup,
	fadeout = fadeSetup,

	_fade = jukeboxFade,

	delay = function(track, fadeArgs, dt)
		local secs = fadeArgs[2]
		if secs == "remaining" then
			local src = track.source
			secs = 1/src:getPitch()
				* (src:getDuration() - src:tell())
		else
			secs = secs - dt
		end
		if secs <= 0 then
			return 2, secs
		end
		fadeArgs[2] = secs
	end,

	loop = function(track, fadeArgs, dt, finish)
		local src = track.source
		local info = fadeArgs[2]
		if type(info) ~= "table" then
			info = {info, src:tell()}
			fadeArgs[2] = info
		end

		local prevPos = info[2]
		local pos = src:tell()
		if pos < prevPos then
			info[1] = info[1] - 1
		end
		if info[1] <= 0 or finish then
			return 2
		end
		info[2] = pos
	end,

	cmd = function(track, fadeArgs, dt)
		local src = track.source
		srcSetup(src, fadeArgs[2])
		return 2
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

		local setup = {play=true, setLooping=true, setVolume=op[2] or 1}
		if op.setup then
			setup = f0b.table.union(setup, op.setup)
		end
		srcSetup(op.source, setup)
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
