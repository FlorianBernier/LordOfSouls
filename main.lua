
Setting = require("setting")
--- --- --- --- --- --- --- --- --- --- --- --- ---


love.load = function()
    Setting.load()
    --- --- ---

end

love.update = function(dt)
    Setting.update(dt)
    --- --- ---

end

love.draw = function()
    Setting.draw()
    --- --- ---
    --example
    love.graphics.rectangle("fill",((ScreenWidth/2)-10 + Camera_x), ((ScreenHeight/2)-10 + Camera_y), 20, 20)
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