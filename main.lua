Setting = require("setting")

--- --- --- --- --- --- --- --- --- --- --- --- ---
local sndIntro = love.audio.newSource("sons/introLordOfSouls.wav", "static")
local img = love.graphics.newImage("images/lord.png")

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
    love.graphics.draw(img, 0+Camera_x, 1600+Camera_y, 0, 0.6, 0.6)
end

love.keypressed = function(key)
    Setting.keypressed(key)
    --- --- ---
    MyGame.keypressed(key)
    if key == "escape" then
        love.audio.stop(sndIntro)
        Camera_x = 0
        Camera_y = -1000
        Camera_speed = 300
    end
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