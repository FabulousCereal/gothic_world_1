-- SPDX-FileCopyrightText: 2024 Grupo Warominutes
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

local function fadeSetup2(track, fade, dt, new, secsIdx)
	local source = track.source
	local cur = source:getVolume()
	fade[1] = "_interpolate"
	fade[2] = seq.interpolationLinear({source,
		function(source, idx, val)
			source:setVolume(val)
		end,
		0, fade[secsIdx], secsIdx,
		"setVolume", new - cur},
		function(source, idx)
			return cur
		end
	)
	return seq.interpolate(track, fade, dt)
end

local fadeOps = {
	_interpolate = seq.interpolate,

	-- Volume fading --
	-- {type, targetVol, time}
	fadeto = function(t, f, dt)
		return fadeSetup2(t, f, dt, f[2], 3)
	end,

	-- {type, time}
	fadein = function(t, f, dt)
		return fadeSetup2(t, f, dt, 1, 2)
	end,
	fadeout = function(t, f, dt)
		return fadeSetup2(t, f, dt, 0, 2)
	end,

	-- Pitch bend --
	-- Format: {"bend", newPitch, secs}
	bend = function(track, fade, dt)
		local source = track.source
		-- Pitch is logarithmic!
		local cur = math.sqrt(source:getPitch())
		local new = math.sqrt(fade[2])
		fade[1] = "_interpolate"
		fade[2] = seq.interpolationLinear({source,
			function(source, idx, val)
				source:setPitch(val*val)
			end,
			0, fade[3], 3,
			"setPitch", new - cur},
			function(source, idx)
				return cur
			end
		)
		return seq.interpolate(track, fade, dt)
	end,

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

local defaultAlias = true

local function getAlias(op)
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
		if #op > 0 then
			for i = 1, #op do
				jukeMod(tracklist[op[i]], op)
			end
		else
			jukeMod(tracklist[defaultAlias], op)
		end
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
