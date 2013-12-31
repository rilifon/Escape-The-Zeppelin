module("base", package.seeall)

require "base.object"
require "base.entity"
require "vector"

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
	frame_width = nil,
	-- Total number of frames
	size = nil,
	-- Internal Quad
	quad = nil
})

function Sprite:__init(x, y, image, frame_width, size)
	self.position = Vector(x, y)
	
	self.image = image
	self.frame_width, self.size = frame_width, size
	
	self.quad = love.graphics.newQuad(0, 0, 
		self.frame_width, self.image.getHeight())
	
	self.__typeid = "sprite"
end

function Sprite:__tostring()
	return self.__typeid..tostring(self.position)..self.frame_width..'/'..size
end

-- Overrides base.Entity:draw
function Sprite:draw()
	for i=0,size-1 do
		local x, y, w, h = self.quad.getViewport()
		self.quad.setViewport(i*self.frame_width, y, w, h)
		love.graphics.draw(self.image, self.quad, self.x, self.y)
	end
end