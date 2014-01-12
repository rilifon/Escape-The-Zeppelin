module("base", package.seeall)

require "base.object"

-- Entity.

-- Q: So what the hell is Entity?
-- A: Entity is an abstract class that's used as a base for 
--    most renderable and updatable classes.

-- Q: What is it supposed to do?
-- A: Provide a sort of guidance when creating new classes.

-- Q: What am I supposed to do with it?
-- A: If your new class is renderable, override the draw function.
--    If your new class is updatable, override the update function.
--    And please override __tostring as well. Optional. But not really.

-- Q: How do I guarantee it's rendering and updating?
-- A: Call Entities.register(your_entity).

-- Class declaration.
Entity = base.Object:newSubClass {

}

-- Entity constructor.
function Entity:__init() 
	-- Entity is supposed to be an abstract class,
	-- meaning that a pure Entity instance is not
	-- to be created.
	-- Therefore...
	error("You shouldn't be doing this.\n", 2)
end

-- Override this with much gusto.
function Entity:__tostring()
	return "instance of entity"
end

-- Please override this. Like. Right now!
function Entity:draw()
	-- Overriding this may or may not be optional.
	-- Trust your instincts and you will find the answer.
end

-- Override this! Please?
function Entity:update(dt)
	-- Overriding this may or may not be optional.
	-- Just listen to your heart and you shall find the answer.
end

------------------------------------------------------------
-- Here starts the pseudo-static functions and variables. --
------------------------------------------------------------

-- Entire collection of Entities.
local entities = {}

-- The static table with functions for Entity management.
Entities = {}

-- Registers Entity.
function Entities.register( e )
	entities[e] = true
end

-- Removes Entity.
function Entities.remove( e )
	entities[e] = nil
end

-- Clears all Entities.
function Entities.clear()
	for k in pairs(entities) do
		entities[k] = nil
	end
end

-- Checks whether the collection contains the given Entity.
function Entities.contains( e )
	return entities[e]
end

-- Renders all Entities in the collection.
function Entities.onRender()
	for k,_ in pairs(entities) do
		k:draw()
	end
end

-- Updates all Entities in the collection.
function Entities.onUpdate( dt )
	for k in pairs(entities) do
		k:update(dt)
	end
end