local Entities = {}

local MyHero = require("hero")
local Monster = require("Monster")

Entities.load = function()
    MyHero.load()
    Monster.load()
end



Entities.update = function(dt)
    MyHero.update(dt)
    Monster.update(dt)
end



Entities.draw = function()
    MyHero.draw()
    Monster.draw()
end


return Entities