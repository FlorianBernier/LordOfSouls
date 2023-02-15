Setting = require("setting")
--- --- --- --- --- --- --- --- --- --- --- --- ---


local myGame = require("game")

love.load = function()
    Setting.load()
    --- --- ---
    myGame.load()
end

love.update = function(dt)
    Setting.update(dt)
    --- --- ---
    myGame.update(dt)
end

love.draw = function()
    Setting.draw()
    --- --- ---
    myGame.draw()
end

love.keypressed = function(key)
    Setting.keypressed(key)
    --- --- ---

end

love.mousepressed = function()
    Setting.mousepressed()
    --- --- ---

end


function love.wheelmoved(x, y)
    Setting.wheelmoved(x,y)
    --- --- ---

end