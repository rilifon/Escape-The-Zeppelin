openSafe = {}

function openSafe.load( )

	currentScene = openSafe

	Text = "da-da-da-da-dum-dah-dah-daaah"

	eventos = {

	{80, 64, 34, 9, "key"},
	{0, 0, 20, 140, "bordaEsquerda"},
	{175, 0, 20, 140, "bordaDireita"}

	}

end

function openSafe.draw( )

	if not key then

	love.graphics.draw(clickables["key"], 80*scale, 64*scale, 0,
		scale, scale)

	end

end

function openSafe.update(dt)

	if evento == "key" then 
		key = true
		itemCount, itemIndex = 1, 1
		active = "key"
		Text = "I got THE KEY"

	elseif evento == "bordaEsquerda" or evento == "bordaDireita"then
		toLoad = firstRoom

	end

end