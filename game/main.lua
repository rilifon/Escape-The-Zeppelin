require "math"
require "splash"
require "firstRoom"
require "closedSafe"
require "openSafe"
require "darkfirstRoom"
require "secondRoom"
require "thirdRoom"

function love.load( )

	back_names = {"firstRoom", "darkfirstRoom", "secondRoom",
		"closedSafe", "openSafe", "thirdRoom", "splash"}
	backgrounds = {}

	for _,v in ipairs(back_names) do
    backgrounds[v]=love.graphics.newImage("backgrounds/"..v..".gif")
  	end

  	for _,v in pairs(backgrounds) do
    v:setFilter("nearest","nearest")
  	end


  	click_names = {"key", "hammer", "b0", "b1", "b2", "b3",
  	 "b4", "b5", "b6", "b7", "b8", "b9", "hatch", "panel", 
  	 "hammerIcon", "keyIcon", "window", "fencepost"}
	clickables = {}

	for _,v in ipairs(click_names) do
	clickables[v]=love.graphics.newImage("clickables/"..v..".gif")
	end

	for _,v in pairs(clickables) do
	v:setFilter("nearest","nearest")
	end

  	ani_names = {"propeller1", "propeller2", "propeller3", "propeller4", 
  	"mouth1", "mouth2", "mouth3", "mouth4", "clouds1", "clouds2", "clouds3",
  	"clouds4"}
	animations = {}

	for _,v in ipairs(ani_names) do
    animations[v]=love.graphics.newImage("animations/"..v..".gif")
  	end

  	for _,v in pairs(animations) do
    v:setFilter("nearest","nearest")
  	end


  	font = love.graphics.newFont("resources/PressStart2P.ttf",5*scale)
  	love.graphics.setFont(font)

  	splash.load()

  	evento = "zero"
  	coords = false

  	mouseX, mouseY = 0, 0
  	aniTimer = 0
  	aniFrame = 1

  	itemCount = 0
  	itemIndex = 0


end

function love.draw( )


	love.graphics.draw(backgrounds[current], 0, 0, 0, scale, scale)
	love.graphics.print(Text, 10*scale, 150*scale)
	love.graphics.print("ITEM", 197*scale, 64*scale)
	love.graphics.draw(clickables["panel"], 201*scale, 73*scale, 0, scale, scale)

	if active then 

		love.graphics.draw(clickables[active.."Icon"], 202*scale, 79*scale, 0, scale, scale)

	end

	if coords == true then 
		love.graphics.print(mouseX.." "..mouseY.." "..aniFrame.." "..itemIndex.." "..itemCount, 10*scale, 160*scale)
	end

	if animation then
		local x = animation[3]..aniFrame
		love.graphics.draw(animations[x], animation[1]*scale, animation[2]*scale, 0, scale, scale)end

	if current == "firstRoom" then firstRoom.draw()
	elseif current == "closedSafe" then closedSafe.draw()
	elseif current == "openSafe" then openSafe.draw()
	elseif current == "darkfirstRoom" then darkfirstRoom.draw()
	elseif current == "secondRoom" then secondRoom.draw()
	elseif current == "thirdRoom" then thirdRoom.draw()
	
	end

end


function love.update(dt)


	if toLoad == "firstRoom" then 
		firstRoom.load()
		debugagem = true
	elseif toLoad == "closedSafe" then closedSafe.load()
	elseif toLoad == "openSafe" then openSafe.load()
	elseif toLoad == "darkfirstRoom" then 
		darkfirstRoom.load()
		debugagem = false
	elseif toLoad == "secondRoom" then secondRoom.load()
	elseif toLoad == "thirdRoom" then thirdRoom.load()

	end

	toLoad = "none"

	aniTimer = aniTimer + dt

	if aniTimer >= .25 then

		aniFrame = aniFrame + 1
		aniTimer = 0
		if aniFrame == 5 then aniFrame = 1 end

	end

	if current == "splash" then splash.update(dt)
	elseif current == "firstRoom" then firstRoom.update(dt)
	elseif current == "closedSafe" then closedSafe.update(dt)
	elseif current == "openSafe" then openSafe.update(dt)
	elseif current == "darkfirstRoom" then darkfirstRoom.update(dt)
	elseif current == "secondRoom" then secondRoom.update(dt)
	elseif current == "thirdRoom" then thirdRoom.update(dt)
	
	end

	if evento == "upArrow" then active = love.newActive(1)end

	if evento == "downArrow" then active = love.newActive(-1)end

	evento = ""

end

function love.newActive(delta)

	local itemList = {nil, "key", "hammer"}

	itemIndex = (itemIndex+1)%(itemCount+1)
	return itemList[itemIndex+1]

end


function love.region(mx, my, ox, oy, lenght, height)

	if mx >= ox and mx <= ox + lenght then
		if my >= oy and my <= oy + height then

			return 1

		end
	end

	return 0

end


function love.mousepressed (x, y, button)

	local something = false

	if button == "l" then

		mouseX, mouseY = math.floor(x/scale), math.floor(y/scale)

		for k,v in pairs(eventos) do

			if love.region(mouseX, mouseY, v[1], v[2], v[3], v[4]) == 1 then

				evento = v[5]
				something = true

			end

		end

		if love.region(mouseX, mouseY, 203, 73, 9, 3) == 1 then
			evento = "upArrow"
			something = true 
		end

		if love.region(mouseX, mouseY, 204, 93, 9, 3) == 1 then
			evento = "downArrow" 
			something = true
		end

		if something == false then evento, Text = "", "" end

	end

end