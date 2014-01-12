module("base", package.seeall)

require "base.object"

-- Timers time time. Simple, isn't it?

-- Class declaration. All these need to be set when creating a new object. (Some already have default values)
Timer = base.Object:newSubClass {
	-- default time to activate
	timeToSet = 1,
	-- function that will be called when the desired time is hit (default does nothing)
	funcToCall = function() end,
	-- whether the timer is running (by default, it does not automatically runs when created)
	running = false,
	-- whether the timer repeats after hitting its time (defaults to repeating)
	repeats = true
}

-- Internal weak timer storage.
-- Weak means you should store your timers somewhere safe, or they will be garbage collected.
local timers = setmetatable({}, {__mode = 'k'})

function Timer:__init()
	self.time = 0
	timers[self] = true
end

function Timer:restart()
	self.time = 0
	self.running = true
end

function Timer:pause()
	self.running = false
end

function Timer:unpause()
	self.running = true
end

function Timer:update( dt )
	self.time = self.time + dt
	if self.time >= self.timeToSet then
		self:funcToCall()
		self.time = 0
		if not self.repeats then self.running = false end
	end
end

function Timer.updateTimers( dt )
	for t in pairs(timers) do
		if t.running then t:update(dt) end
	end
end