thirdRoom = {}

function thirdRoom.load()

	current = "thirdRoom"

	Text = "I seem to be on the zeppelin's deck"

	animation = {146, -5, "clouds"}

	eventos = {

	{119, 85, 16, 56, "escada"},
	{67, 23, 12, 50, "porta"},
	{6, 48, 19, 30, "buraco"}

	}

	love.audio.play(wind)

end

function thirdRoom.update(dt)

	if evento == "escada" then

		Text = "A maintenance ladder. It leads straight\nto the infinite cloudy void below"

	elseif evento == "buraco" then 

		toLoad = "firstRoom"
		love.audio.stop(wind)

	elseif evento == "porta" then

		Text = "Só fiz até aqui LOL!"
		love.audio.stop(wind)

	end

end

function thirdRoom.draw( )

	love.graphics.draw(clickables["fencepost"], 65*scale, 106*scale, 0, scale, scale)

end