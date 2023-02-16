--colisionPointRect : detecte la colision entre un point x,y et un rectangle 
function Collide_P_R(x1,y1,x2,y2,w,h)
    return x1 > x2 and x1 < x2 + w and y1 > y2 and y1 < y2 + h
end

--DistanceDeuxPoints : detecte la distance entre 2 points 
function Dist_P_P(x1,y1,x2,y2)
    return math.sqrt( math.abs(x1 - x2) * math.abs(x1 - x2)  + math.abs(y1 - y2) * math.abs(y1 - y2) )
end


local Entities = {}

local MyHero = require("hero")
local MyMonster = require("Monster")

Entities.load = function()
    MyHero.load()
    MyMonster.load()
end



Entities.update = function(dt)
    MyHero.update(dt)
    MyMonster.update(dt)
end



Entities.draw = function()
    MyHero.draw()
    MyMonster.draw()
end

Entities.keypressed = function(key)
    MyHero.keypressed(key)
end

Entities.mousepressed = function()
end


return Entities