module("base.object", package.seeall)

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

-- Retrieves the given class' super class.
local function super(class)
	return getmetatable(class)
end

-- Creates a class inheriting others optionally.
function newClass(...)
	local class, bases = {}, {...}

	for _, b in ipairs(bases) do
		if not b.__isdecl then
			for k, v in pairs(b) do
				class[k] = v
			end
		end
	end

	class.__index, class.instanceof = class, {[class] = true}

	for _, b in ipairs(bases) do
		if not b.__isdecl then
			for deps in pairs(b.instanceof) do
				class.instanceof[deps] = true
			end
			class.instanceof[b] = true
		end
	end

	setmetatable(class, {__call = function(_class, ...)
		local instance = setmetatable({}, _class)
		local init = instance.__init

		if init then init(instance, ...) end

		return instance
	end})

	class.__super, class.__typeid = super, "undefined"

	return class
end

-- Clones an already existing class instance.
function clone(instance)
	local copy = {}

	for k, v in pairs(instance) do
		copy[k] = v
	end

	return setmetatable(copy, instance:super())
end
