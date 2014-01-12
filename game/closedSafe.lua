closedSafe = {}

function closedSafe.load( )

	currentScene = closedSafe

	Text = "Time to hack this safe"

	eventos = {

	{42, 114, 21, 16, "buttonOne"},
	{73, 114, 21, 16, "buttonTwo"},
	{104, 114, 21, 16, "buttonThree"},
	{135, 114, 21, 16, "buttonFour"},
	{130, 30, 18, 72, "lever"},
	{0, 0, 20, 140, "bordaEsquerda"},
	{175, 0, 20, 140, "bordaDireita"}

	}

	if not buttonOne then 

		buttonOne = 6
		buttonTwo = 6
		buttonThree = 6
		buttonFour = 6

	end

end

function closedSafe.draw( )

	love.graphics.draw(clickables["b"..buttonOne], 42*scale, 114*scale, 0, scale, scale)
	love.graphics.draw(clickables["b"..buttonTwo], 73*scale, 114*scale, 0, scale, scale)
	love.graphics.draw(clickables["b"..buttonThree], 104*scale, 114*scale, 0, scale, scale)
	love.graphics.draw(clickables["b"..buttonFour], 135*scale, 114*scale, 0, scale, scale)

end

function closedSafe.update(dt)

	guess = 1000*buttonOne + 100*buttonTwo + 10*buttonThree + buttonFour

	if evento == "buttonOne" then
		buttonOne = (buttonOne + 1)%10

	elseif evento == "buttonTwo" then
		buttonTwo = (buttonTwo + 1)%10

	elseif evento == "buttonThree" then
		buttonThree = (buttonThree + 1)%10

	elseif evento == "buttonFour" then
		buttonFour = (buttonFour + 1)%10

	elseif evento == "lever" then

		if guess == 2308 then 
			toLoad = openSafe

		else Text = "It won't budge!" end

	elseif evento == "bordaEsquerda" or evento == "bordaDireita"then
		toLoad = firstRoom

	end

end