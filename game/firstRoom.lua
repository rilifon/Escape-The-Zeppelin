firstRoom = {}

function firstRoom.load( )

	currentScene = firstRoom

	Text = "I seem to be in a weird storage room"

	eventos = {

	{152, 41, 35, 100, "urso"},
	{136, 10, 14, 48, "abstrato"},
	{78, 13, 40, 15, "gravura"},
	{59, 59, 4, 10, "interruptor"},
	{22, 92, 7, 21, "cofre"},
	{78, 32, 37, 65, "porta"},
	{10, 20, 46, 29, "quadezoito"}

	}

	if hatch then
		eventos[6] = {100, 112, 18, 11, "escotilha"} end

	animation = nil

	last = "light"

	if window == true then eventos[7] = {10, 24, 29, 26, "window"} end

 end

function firstRoom.update(dt)
 	
 	if evento == "urso" then
 		Text = 
 		"For some reason, I feel\nthis bear wants to punch me"

 	elseif evento == "abstrato" then
 		Text = 
 		"Abstract art like this always\nlooks like an obnoxious puzzle to me"

 	elseif evento == "gravura" then
 		Text =
 		"There is an engraving\nof a zeppelin above the door"

 	elseif evento == "interruptor" then
 		if window == true then Text = "No use turning off the lights\nwith that hole to the open sky"
 		else toLoad = darkfirstRoom end	

 	elseif evento == "cofre" then
 		if not key then toLoad = closedSafe
 		else Text = "I already got THE KEY" end

 	elseif evento == "escotilha" then
 		toLoad = secondRoom

 	elseif evento == "porta" then
 		if active == "key" then 
 			Text = "Yeah, like it would be\nthat easy..."
 		else Text = "A wooden door. Somehow, I can see\nthe sky through the keyhole"
 		end

 	elseif evento == "quadezoito" then
 		if active == "hammer" and love.region(mouseX, mouseY, 19, 41, 9, 4) == 1 then
 			window = true
 			eventos[7] = {10, 24, 29, 26, "window"}
 			Text = "The hammer punched through the painting\nAND the wall"
 		else Text = "A painting of a windblown tree\nnext to some rocks" end

 	elseif evento == "window" then
 		toLoad = thirdRoom
 		
 	end

end

function firstRoom.draw( ... )

	if hatch == true then love.graphics.draw(clickables["hatch"], 100*scale, 112*scale,
	 0, scale/2, scale/2) end

	if window == true then love.graphics.draw(clickables["window"], 10*scale, 23*scale,
	 0, scale, scale) end

end