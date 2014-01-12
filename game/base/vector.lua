require "base.object"

-- Vector class.

-- Very numbers!
--                        Much tidy!
--         So utility.

-- As you can see, it's a utility class for (x, y)
-- points/vectors. 
-- With a huge assortment of goodies, one can find
-- many functions that should shorten your coding
-- in many-a-ways.

-- Much sexy.

-- Class declaration. 
-- Note that this is a pseudo-declaration.
-- In reality x and y do not exist. We merely
-- redirect calls for x and y to self[1] and self[2].

Vector = base.Object:newSubClass {
	0,
	0
}

function Vector:__index( key )
	if key == 'x' then return self[1]
	elseif key == 'y' then return self[2]
	else return getmetatable(self)[key] end
end

function Vector:__newindex( key, value )
	if key == 'x' then self[1] = value
	elseif key == 'y' then self[2] = value
	else rawset(self, key, value) --[[Let's believe in the user]] end
end

function Vector:normalize()
	self:div(self:length())
end

function Vector:normalized()
	return self/self:length()
end

function Vector:length()
	return math.sqrt(self[1]*self[1] + self[2]*self[2])
end

function Vector:lengthSq()
	return self[1]*self[1] + self[2]*self[2]
end

function Vector:set( x, y )
	if not y then
		self[1], self[2] = x[1], x[2]
	else
		self[1], self[2] = x, y
	end
end

function Vector:add( x, y )
	if not y then
		self[1], self[2] = self[1] + x[1], self[2] + x[2]
	else 
 		self[1], self[2] = self[1] + x, self[2] + y
	end
end

function Vector:sub( x, y )
	if not y then
		self[1], self[2] = self[1] - x[1], self[2] - x[2]
	else
		self[1], self[2] = self[1] - x, self[2] - y
	end
end

function Vector:mult( x, y )
	self[1], self[2] = self[1] * x, self[2] * (y or x)
end

function Vector:div( x, y )
	self[1], self[2] = self[1] / x, self[2] / (y or x)
end

function Vector:__add( v )
	return Vector{ self[1] + v[1], self[2] + v[2] }
end

function Vector:__sub( v )
	return Vector{ self[1] - v[1], self[2] - v[2] }
end

function Vector:__mul( v )
	if type(v) == "number" then
		return Vector{ self[1] * v, self[2] * v }
	else
		return self[1] * v[1] + self[2] * v[2]
	end
end

function Vector:__div( v )
	return Vector{ self[1] / v, self[2] / v }
end

function Vector:__unm()
	return Vector{ -self[1], -self[2] }
end

function Vector:__eq( v )
	return self[1] == v[1] and self[2] == v[2]
end

function Vector:__tostring()
	return '['..self[1]..", "..self[2]..']'
end