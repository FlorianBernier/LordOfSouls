local Entities = {}

local MyHero = require("hero")
local MyMonster = require("Monster")

local MySpell = require("spell")

--- --- --- --- --- --- ---


Entities.load = function()
    MySpell.load()
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
    MySpell.update(dt)
    MyMonster.update(dt)
    MyHero.update(dt)
    
    
end


Entities.draw = function()
    MySpell.draw()
    MyMonster.draw()
    MyHero.draw()
   
end

local function keypressedSpell(key)
    if key == "e" and Hero.mana >= 3000 then
        CreateSpellFire(Hero.x -25, Hero.y-25, Mouse_x -50, Mouse_y -50, "fire")
    end
    if key == "a" and Hero.mana >= 10000 then
        CreateSpellMidnight(Hero.x -25, Hero.y -25, Mouse_x -50, Mouse_y -50, "midnight")
    end
    if key == "c" and Hero.mana >= 10000 then
        CreateSpellLife(Hero.x -18, Hero.y -18, Hero.x -25, Hero.y -25, "life")
    end
    if key == "f" and Hero.mana >= 10000 then
        CreateSpellProtect(Hero.x -18, Hero.y -18, Mouse_x-50, Mouse_y -50, "protect")
    end
end

Entities.keypressed = function(key)
    --MyHero.keypressed(key)
    keypressedSpell(key)
end


Entities.mousepressed = function(x, y, button)
    MySpell.mousepressed(x, y, button)
    MyHero.mousepressed(x, y, button)
    
end


return Entities