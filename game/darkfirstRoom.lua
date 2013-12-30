darkfirstRoom = {}

function darkfirstRoom.load( )

	current = "darkfirstRoom"

	Text = "Creppy"

	eventos = {

	{152, 41, 35, 100, "urso"},
	{136, 10, 14, 48, "abstrato"},
	{78, 13, 40, 15, "gravura"},
	{59, 59, 4, 10, "interruptor"},
	{22, 92, 7, 21, "cofre"},
	{78, 32, 37, 65, "porta"},
	{112, 114, 10, 10, "fechadura"}

	}

	animation = nil

	last = "dark"

 end

function darkfirstRoom.update(dt)
 	
 	if evento == "urso" then
 		Text = 
 		"For some reason, I feel\nthis bear wants to punch me"

 	elseif evento == "abstrato" then
 		Text = 
 		"Abstract art like this always\nlooks like an obnoxious puzzle to me"

 	elseif evento == "cofre" then
 		Text = "It's too dark"

 	elseif evento == "interruptor" then
 		toLoad = "firstRoom"

 	elseif evento == "fechadura" then
 		if active == "key" then 
 			hatch = true
 			eventos[6] = {100, 112, 20, 20, "escotilha"}
 			Text = "There was a small keyhole on the floor!"
 		end

 	elseif evento == "escotilha" then
 		toLoad = "secondRoom"

 	elseif evento == "porta" then
 		Text = "There is a beam of sunlight coming\nfrom the keyhole"

 	end

end

function darkfirstRoom.draw( ... )
	
	if hatch == true then love.graphics.draw(clickables["hatch"], 100*scale, 112*scale,
	 0, scale/2, scale/2) end

end