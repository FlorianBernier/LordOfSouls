Setting = require("setting")
--- --- --- --- --- --- --- --- --- --- --- --- ---


local MyGame = require("game")

love.load = function()
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

love.mousepressed = function()
    Setting.mousepressed()
    --- --- ---
    
end


function love.wheelmoved(x, y)
    Setting.wheelmoved(x,y)
    --- --- ---

end