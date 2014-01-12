splash = {}

function splash.load( )

	currentScene = splash

	Text = "ESCAPE THE ZEPPELIN \nDemo da edicao estendida e pixelada!"

	eventos = {

	{52, 57, 80, 34, "zeppelin"}

	}

	animations.propeller.position:set(47, 66)
	animations.propeller:restart()

	wind = love.audio.newSource( "resources/Strong_wind.ogg" , "stream" )
	wind:setLooping(true)
	love.audio.play(wind)

end

function splash.update(dt)
	
	if evento == "zeppelin" then
		animations.propeller:pause()
		love.audio.stop(wind)
		firstRoom.load()
	end

end

function splash.draw()
	animations.propeller:draw()
end