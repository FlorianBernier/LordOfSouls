Setting = require("setting")

--- --- --- --- --- --- --- --- --- --- --- --- ---
local sndIntro = love.audio.newSource("sons/introLordOfSouls.wav", "static")

local MyGame = require("game")

love.load = function()
    love.audio.play(sndIntro)
    Setting.load()
    --- --- ---
    MyGame.load()
end

love.update = function(dt)
    Setting.update(dt)
    --- --- ---
    MyGame.update(dt)
end

love.draw = function()
    Setting.draw()
    --- --- ---
    MyGame.draw()
end

love.keypressed = function(key)
    Setting.keypressed(key)
    --- --- ---
    MyGame.keypressed(key)
end

love.mousepressed = function(x, y, button)
    Setting.mousepressed()
    --- --- ---
    MyGame.mousepressed(x, y, button)
    
end


function love.wheelmoved(x, y)
    Setting.wheelmoved(x,y)
    --- --- ---

end