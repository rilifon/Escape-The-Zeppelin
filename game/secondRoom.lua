require "math"

secondRoom = {}

function secondRoom.load( )

	currentScene = secondRoom

	Text = "Curioser and curioser"

	eventos = {

	{13, 0, 4, 110, "pole"},
	{73, 7, 58, 67, "stoneface"}

	}

	animations.mouth:setFrame(0)
	animations.mouth.position:set(89, 64)

	hy = 66

 end

function secondRoom.update(dt)

	if timer then 
		timer = timer + dt
		if timer >= 2.5 then
			animations.mouth:pause()
			if not hammer then getHammer = true end
			hy = hy + math.floor((timer-2.5)*10)
			if hy >= 96 then hy = 96 end
		end
		if timer >= 5.5 then timer = nil 
			eventos[3] = {98, 96, 11, 6, "hammer"}
			Text = "WTF"
			love.mouse.setVisible(true)
		end
	end
 	
 	if evento == "pole" then
 		
 		if debugagem == true then toLoad = firstRoom
 		elseif debugagem == false then toLoad = darkfirstRoom
 		end

 	elseif evento == "stoneface" then
 		animations.mouth:unpause()
 		timer = 0
 		love.mouse.setVisible(false)
 		Text = "\"Strike the base of\neighteen's one!\""

 	elseif evento == "hammer" then
 		if getHammer then
 			getHammer = nil
 			hammer = true
 			itemCount = 2
 			Text = "I got THE HAMMER"
 		end

 	end

end

function secondRoom.draw()

	animations.mouth:draw()
	if getHammer then love.graphics.draw(clickables["hammer"], 97*scale, hy*scale, 0, scale, scale) end

end