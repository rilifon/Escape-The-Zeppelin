require "vector"

module("base", package.seeall)

-- Class declaration. Not necessary, but good for quick reference.
Sprite = base.object.newClass {
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
}

function Sprite:__init(x, y, image, frame_width, size)
	self.position = Vector(x, y)
	
	self.image = image
	self.frame_width, self.size = frame_width, size
	
	self.quad = love.graphics.newQuad(0, 0, 
		self.frame_width, self.image.getHeight())
	
	self.__typeid = "sprite"
end

function Sprite:__tostring()
	return "sprite:"..tostring(self.position)..self.frame_width..'/'..size
end

function Sprite:draw()
	for i=0,size-1 do
		local x, y, w, h = self.quad.getViewport()
		self.quad.setViewport(i*self.frame_width, y, w, h)
		love.graphics.draw(self.image, self.quad, self.x, self.y)
	end
end