module("base", package.seeall)

-- Utility functions for a pseudo OOP structure in Lua

-- So... How can I put this... I kind of based my work off 
-- lua-users wiki [1][2].
-- Now, "to rip off" and "to plagirize" are strong terms...
-- I'd go more with "inspired by".

-- Now, on a more serious matter. In this project we (plan to)
-- use both Table-based and Closure-based classes. 

-- Whilst at first this may sound like a huge potato of nonsense,
-- I tell you, dear reader, that although I am mad, crazy, cuckoo
-- in the head, it is for a greater purpose. 

-- As the great Niccolo Machiavelli once said:
-- "[...] the ends justify the means [...]" [3]

-- You see, we shall take the Table-based class approach by
-- default, but in certain particular, exceptional, outlier
-- cases we'll be adhering to closure instances.

-- So do tell me, oh great One, when thou shalt use them goodies?
--  1. When thy class has no blood relatives of table-based classes.
--  2. When thy instance's number is little, for reproduction is expensive.
--  3. When thy class likes to give access to others often.
--  4. When thy class is called often.
--  5. When thy class must conceal something from heathen, layman's eyes.

-- And thou shalt follow this one commandment:
--  1. Thou shalt not mix table-based with closure-based blood.

-- If any of the above criteria are not met or followed, then
-- please use a table-based class.

-- Some useful information on this OOP structure:
--  function __call     - constructor, calls __init, do not override
--  function __init     - initializer, override this
--  table    __super    - super class
--  string   __typeid   - object's type, override this
--  table    instanceof - table containing all relatives

-- Sincerely, yours truly, with love, xoxo, 
-- Renato Lui Geh

-- [1] - http://lua-users.org/wiki/ObjectOrientationTutorial
-- [2] - http://lua-users.org/wiki/InheritanceTutorial
-- [3] Prince, The - N. Machiavelli | They say adding quotes 
-- from people who are smarter than you makes you sound more intelligent.

Object = {}


local function clone( obj )
	if type(obj) ~= 'table' then return obj end
	local copy = {}

	for k, v in pairs(instance) do
		copy[k] = clone(v)
	end

	return setmetatable(copy, getmetatable(obj))
end

-- Creates a class. (Please don't call this from objects, or shit WILL go down)
function Object:newSubClass( data )
	local class = data or {}

	class.__index = class
	class.__super, class.clone = getmetatable, clone

	setmetatable(class, { __call = function(_class, data)
		local instance = setmetatable(data or {}, _class)
		local init = _class.__init

		if init then init(instance) end

		return instance
	end, __index = self --[[can access stuff from superclasses]] })

	return class
end

setmetatable(Object, {__newindex = function()
		error("You (probably) shouldn't be doing this. Change this code if you should...\n", 2)
	end})