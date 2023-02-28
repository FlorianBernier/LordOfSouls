local Entities = {}

local MyHero = require("hero")
local MyMonster = require("Monster")

--- --- --- --- --- --- ---


Entities.load = function()
    MyHero.load()
    MyMonster.load()
    CreateDeath()
    CreateDeath()
    CreateDeath()
    CreateDeath()
    CreateDeath()

    CreateBloodMage()
    CreateBloodMage()
    CreateBloodMage()
    CreateBloodMage()
    CreateBloodMage()

end


Entities.update = function(dt)
    MyHero.update(dt)
    MyMonster.update(dt)
end


Entities.draw = function()
    MyMonster.draw()
    MyHero.draw()
end


Entities.keypressed = function(key)
    MyHero.keypressed(key)
end


Entities.mousepressed = function(x, y, button)
    MyHero.mousepressed(x, y, button)
end


return Entities