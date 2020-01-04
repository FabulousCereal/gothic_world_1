-- Format: {"_fade", deltaVol, (time)remaining, remove}
local function internalFade(track, dt, finish)
	local fadeArgs, source = track.fade, track.source
	local deltaVol = fadeArgs[2]
	local remaining = fadeArgs[3]
	if finish or dt > remaining then
		dt = remaining
	end

	local newVol = source:getVolume() + deltaVol * dt
	if newVol < 0 then
		newVol = 0
	end
	source:setVolume(newVol)

	if remaining <= 0 then
		if fadeArgs[4] then
			track.remove = true
		else
			fadeArgs[1] = false
		end
	else
		fadeArgs[3] = remaining - dt
	end
end

local function fadeCommon(track, dt)
	local fadeArgs = track.fade
	local startVol = track.source:getVolume()
	local targetVol
	if fadeArgs[2] == "fadescale" then
		targetVol = startVol * fadeArgs[2]
	else
		targetVol = fadeArgs[2]
	end
	local rate = fadeArgs[3]

	fadeArgs[1] = "_fade"
	fadeArgs[2] = (targetVol - startVol) / rate
end

local fadeOps = {
	-- Volume fading --
	-- Format: {type, scaleFactor, rate, remove}
	fadescale = fadeCommon,
		
	-- Format: {type, targetVol, rate, remove}
	fadeabs = fadeCommon,

	_fade = internalFade,
}

local trackOps = {
	set = function(tracklist, op)
		tracklist[op[1]] = op
		if op[2] then
			if not op.source:play() then
				print("Failed to play track:", op[1])
			end
			if op[3] then
				op.source:setVolume(op[3])
			end
		end
	end,

	rm = function(tracklist, op)
		local source = tracklist[op[1]].source
		source:stop()
		tracklist[op[1]] = nil
	end,

	cmd = function(tracklist, op)
		local source = tracklist[op[1]].source
		if op[3] then
			source[op[2]](source, unpack(op[3]))
		else
			source[op[2]](source)
		end
	end,

	cmdall = function(tracklist, op)
		for _, track in pairs(tracklist) do
			local source = track.source
			source[op[2]](source, unpack(op[3]))
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

	finish = function(tracklist, op)
		for idx, track in pairs(tracklist) do
			if track.fade and track.fade[1] then
				fadeOps[track.fade[1]](track, 0, true)
				if fade.remove then
					track.source:stop()
					tracklist[idx] = nil
				end
			end
		end
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

	update = function(tracklist, dt)
		for idx, track in pairs(tracklist) do
			if track.remove then
				track.source:stop()
				tracklist[idx] = nil
			elseif track.fade and track.fade[1] then
				fadeOps[track.fade[1]](track, dt)
			end
		end
	end,
}
