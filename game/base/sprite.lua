module("base", package.seeall)

require "base.object"
require "base.entity"
require "base.timer"
require "base.vector"

-- Class declaration. Not necessary, but good for quick reference.
-- Note that Sprite extends (inherits) class Entity
Sprite = base.object.newClass (base.Entity, {
	-- Tells the base.object that this is a declaration
	__isdecl = true,
	-- Our position (x, y) - origin (0, 0) by default
	position = nil,
	-- The actual Image
	image = nil,
	-- Width of each frame
	frameWidth = nil,
	-- Total number of frames
	size = nil,
	-- Internal Quad
	quad = nil
})

function Sprite:__init(image, timePerFrame, frameWidth, size)	
	self.image = image
	self.frameWidth, self.frameHeight, self.size = frameWidth, self.image:getHeight(), size
	self.currentFrame = 0
	
	self.quad = love.graphics.newQuad(0, 0, 
		self.frameWidth, self.frameHeight, self.image:getWidth(), self.frameHeight)

	self.frameTimer = Timer(timePerFrame, function() self:nextFrame() end)
	
	self.__typeid = "sprite"
end

function Sprite:nextFrame()
	self.currentFrame = (self.currentFrame + 1) % self.size
	self.quad:setViewport(self.currentFrame * self.frameWidth, 0, self.frameWidth, self.frameHeight)
end

function Sprite:start()
	self.frameTimer:start()
end

function Sprite:pause()
	self.frameTimer:pause()
end

function Sprite:__tostring()
	return self.__typeid..self.frameWidth..'/'..size
end

-- Overrides base.Entity:draw
function Sprite:draw(x, y)
	love.graphics.drawq(self.image, self.quad, x, y, 0, scale, scale)
end