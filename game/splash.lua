splash = {}

function splash.load( )

	current = "splash"

  	Text = "ESCAPE THE ZEPPELIN \nDemo da edicao estendida e pixelada!"

  	eventos = {

  	{52, 57, 80, 34, "zeppelin"}

  	}

  	animation = {47, 66, "propeller",1} --[[Fourth number is the index on the animations table of this animation]]

  	wind = love.audio.newSource( "resources/Strong_wind.ogg" , "stream" )
  	wind:setLooping(true)
  	love.audio.play(wind)

end

function splash.update(dt)
	
	if evento == "zeppelin" then

		love.audio.stop(wind)
		firstRoom.load( )
	end

end