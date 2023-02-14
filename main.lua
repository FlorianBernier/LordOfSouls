Setting = require("setting")
--- --- --- --- --- --- --- --- --- --- --- --- ---


local myGame = require("game")
--local myMenu = require("menu")

love.load = function()
    Setting.load()
    --- --- ---
    myGame.load()
    --myMenu.load()
end

love.update = function(dt)
    Setting.update(dt)
    --- --- ---
    myGame.update(dt)
    --myMenu.update(dt)
end

love.draw = function()
    Setting.draw()
    --- --- ---
    myGame.draw()
    --myMenu.draw()
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