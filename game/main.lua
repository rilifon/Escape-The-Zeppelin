require "math"
require "base.timer"
require "base.sprite"
require "splash"
require "firstRoom"
require "closedSafe"
require "openSafe"
require "darkfirstRoom"
require "secondRoom"
require "thirdRoom"

function love.load( )

	scene_names = {"firstRoom", "darkfirstRoom", "secondRoom",
		"closedSafe", "openSafe", "thirdRoom", "splash"}

	-- Loading background images
	for _, v in ipairs(scene_names) do
		local scene = _G[v] -- _G is the global table
		scene.background = love.graphics.newImage("backgrounds/".. v ..".gif")
		scene.background:setFilter("nearest","nearest") --[[Scale every image with nearest neighbor interpolation]]
	end

	click_names = {"key", "hammer", "b0", "b1", "b2", "b3",
	 "b4", "b5", "b6", "b7", "b8", "b9", "hatch", "panel", 
	 "hammerIcon", "keyIcon", "window", "fencepost"}
	clickables = {}

	for _,v in ipairs(click_names) do
		clickables[v] = love.graphics.newImage("clickables/"..v..".gif")
		clickables[v]:setFilter("nearest", "nearest") --[[Scale every image with nearest neighbor interpolation]]
	end

	local ani_names = {"propeller", "mouth", "clouds"}
	local ani_frames = {4, 4, 4} --[[Number of frames in each corresponding animation]]
	local ani_width =  {57, 24, 48}  --[[Width of each frame in each corresponding animation]]
	local ani_height = {15, 28, 145}  --[[Height of each frame in each corresponding animation]]
	animations = {}

	for i, v in ipairs(ani_names) do
		animations[v] = base.Sprite {
			image = love.graphics.newImage("animations/" .. v .. ".png"), 
			timePerFrame = .25, 
			frameWidth = ani_width[i],
			frameHeight = ani_height[i], -- not necessary, but doesn't hurt.
			frameN = ani_frames[i]
		}
		animations[v].image:setFilter("nearest","nearest")
	end

	font = love.graphics.newFont("resources/PressStart2P.ttf", 5 * scale)
	love.graphics.setFont(font)

	splash.load()

	evento = "zero"
	coords = false

	mouseX, mouseY = 0, 0

	itemCount = 0
	itemIndex = 0


end

function love.draw( )

	love.graphics.draw(currentScene.background, 0, 0, 0, scale, scale)
	love.graphics.print(Text, 10*scale, 150*scale)
	love.graphics.print("ITEM", 197*scale, 64*scale)
	love.graphics.draw(clickables["panel"], 201*scale, 73*scale, 0, scale, scale)

	if active then 
		love.graphics.draw(clickables[active.."Icon"], 202*scale, 79*scale, 0, scale, scale)
	end

	if coords == true then 
		love.graphics.print(mouseX.." "..mouseY.." "..aniFrame.." "..itemIndex.." "..itemCount, 10*scale, 160*scale)
	end

	currentScene.draw()

end


function love.update(dt)

	base.Timer.updateTimers(dt)

	if toLoad then
		toLoad.load()
		if toLoad == firstRoom or firstRoom == darkfirstRoom then
			debugagem = (toLoad == firstRoom)
		end
	end

	toLoad = nil

	currentScene.update(dt)

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

		for _, v in pairs(eventos) do

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