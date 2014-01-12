module("base", package.seeall)

require "base.object"
require "base.timer"
require "base.vector"

-- Sprites display spritesheets. Using timers. Real smart stuff.

-- Class declaration. All these need to be set when creating a new object. (Some already have default values)
Sprite = base.Object:newSubClass {
	-- The actual Image
	image = nil,
	-- default time to change frames
	timePerFrame = 1,
	-- Width of each frame
	frameWidth = nil,
	-- Total number of frames
	frameN = nil,
	-- position where the sprite will be drawn (defaults to (0,0))
	position = nil
}

function Sprite:__init()
	self.currentFrame = 0
	self.frameHeight = self.frameHeight or self.image:getHeight()
	self.position = self.position or Vector{0, 0}
	
	self.quad = love.graphics.newQuad(0, 0, 
		self.frameWidth, self.frameHeight, self.image:getWidth(), self.frameHeight)

	self.frameTimer = Timer {
		timeToSet = self.timePerFrame, 
		funcToCall = function() self:nextFrame() end
	}
end

function Sprite:nextFrame()
	self.currentFrame = (self.currentFrame + 1) % self.frameN
	self.quad:setViewport(self.currentFrame * self.frameWidth, 0, self.frameWidth, self.frameHeight)
end

function Sprite:setFrame( i )
	self.currentFrame = i
	self.quad:setViewport(self.currentFrame * self.frameWidth, 0, self.frameWidth, self.frameHeight)
end

function Sprite:restart()
	self.currentFrame = 0
	self.frameTimer:restart()
end

function Sprite:pause()
	self.frameTimer:pause()
end

function Sprite:unpause()
	self.frameTimer:unpause()
end

function Sprite:__tostring()
	return 'some sprite ('.. (self.currentFrame + 1) ..'/'.. self.frameN .. ')'
end

function Sprite:draw()
	love.graphics.drawq(self.image, self.quad, self.position.x * scale, self.position.y * scale, 0, scale, scale)
end