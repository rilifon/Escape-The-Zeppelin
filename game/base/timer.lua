module("base", package.seeall)

require "base.object"

Timer = base.object.newClass()
local timers = setmetatable({}, {__mode = 'k'})

function Timer:__init(timeToSet, funcToCall)
	self.time = 0
	self.timeToSet = timeToSet
	self.funcToCall = funcToCall
	self.running = false
	self.repeats = true
	timers[self] = true
end

function Timer:start()
	self.time = 0
	self.running = true
end

function Timer:pause()
	self.running = false
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