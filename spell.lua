local Spell = {}
Spell.quad = {}


Spell.anim = {
    ["fire"]     = love.graphics.newImage("images/spell/fire.png") ,
    ["midnight"] = love.graphics.newImage("images/spell/midnight.png"),
    ["life"]     = love.graphics.newImage("images/spell/life.png"),
    ["phantom"]  = love.graphics.newImage("images/spell/phantom.png"),
    ["protect"]  = love.graphics.newImage("images/spell/protect.png"),

    ["bluefire"] = love.graphics.newImage("images/spell/bluefire.png"),
    ["brightfire"] = love.graphics.newImage("images/spell/brightfire.png"),
}

--- --- --- --- --- ---


local function loadQuad()
    
    for i = 1, 8, 1 do
        for j = 1, 8, 1 do
            if (i-1)*8 + j <= 61 then
                Spell.quad[(i-1)*8 + j] = love.graphics.newQuad(
                    (i-1)*100, 
                    (j-1)*100,
                    100,
                    100, 
                    Spell.anim["fire"]
                )
            end
        end
    end
end

Spell.load = function()
    loadQuad()
end

local listeSpells = {}

function CreateSpellFire(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        angle = math.atan2(dy-y, dx- x),
        speed = 100,

        frame = 1,
        frameMax = 61,
        frameSpeed = 12,
        degat = 100
    }

    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    lastSpell = spell
    table.insert(listeSpells, spell)
end

function CreateSpellMidnight(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        angle = math.atan2(dy-y, dx- x),
        speed = 150,

        frame = 1,
        frameMax = 61,
        frameSpeed = 12,
        degat = 10
    }
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    lastSpell = spell
    table.insert(listeSpells, spell)
end

function CreateSpellLife(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        angle = math.atan2(dy-y, dx- x),
        speed = 0,

        frame = 1,
        frameMax = 61,
        frameSpeed = 30,
        heal = 10,
        

        
    }
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed


    table.insert(listeSpells, spell)
end

function CreateSpellPhantom(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 200,

        frame = 1,
        frameMax = 61,
        frameSpeed = 30,
        
        
        
    }
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed
    table.insert(listeSpells, spell)
end

function CreateSpellProtect(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 50,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
    }
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end
--- --- --- --- ---
function CreateSpellBluefire(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 100,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
    }
    
    
    Hero.life = Hero.life - 10
    
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end

function CreateSpellBrightfire(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 0,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
    }
    
    
    Hero.life = Hero.life - 10
    
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end



local function updateSpellHero(dt)
    for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        s.frame = s.frame + s.frameSpeed * dt

        
        
        if s.name == "fire" or  s.name == "midnight" then
            local distDeath = Dist_P_P(Death.x-50, Death.y-50, s.x, s.y)
            local distBloodMage = Dist_P_P(BloodMage.x-50, BloodMage.y-50, s.x, s.y)
            if distDeath <= Death.size then
                Death.life = Death.life - s.degat
            end
            if distBloodMage <= BloodMage.size then
                BloodMage.life = BloodMage.life - s.degat
            end
        end
        if s.name == "life" then
            local distHero = Dist_P_P(Hero.x-25, Hero.y-25, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life + s.heal
            end
        end

        if s.name == "phantom" then
            local distDeath = Dist_P_P(Death.x-50, Death.y-50, s.x, s.y)
            local distBloodMage = Dist_P_P(BloodMage.x-50, BloodMage.y-50, s.x, s.y)
            if distDeath <= Death.size then
                Hero.spellStart = nil
                table.remove(listeSpells, i)
                Hero.spellStart = love.timer.getTime() -- stocker le moment où le héros devient invisible
                Hero.visible = false -- rendre le héros invisible
            end
        end
        if Hero.spellStart then
            print("start", Hero.spellStart)
            local invisibilityDuration = 5
            if love.timer.getTime() < math.floor(Hero.spellStart) + invisibilityDuration then
                Hero.visible = false 
            else
                Hero.visible = true 
                Hero.spellStart = nil -- Réinitialiser la variable de début d'invisibilité
            end
        end
        
    
    
    
        

        if s.frame > 61 then
            table.remove(listeSpells, i)
        end
        
    end
    
    
end

Spell.update = function(dt)
    updateSpellHero(dt)
end


Spell.draw = function()
    for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]
        love.graphics.draw(Spell.anim[s.name], Spell.quad[ math.floor(s.frame) ],s.x + Camera_x, s.y + Camera_y)

    end
end


Spell.keypressed = function(key)
end


local lastSpell
local function changeDirSpell(x, y, button)
    if button == 1 then
        for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]
            if s.name == "fire" or  s.name == "midnight" or s.name == "phantom" then
            s.dx = x
            s.dy = y
            s.angle = math.atan2(s.dy-s.y, s.dx-s.x)
            s.vx = math.cos(s.angle) *1.5* s.speed
            s.vy = math.sin(s.angle) *1.5* s.speed
            break
            end
        end
    end
end

Spell.mousepressed = function(x, y, button)
    changeDirSpell(Mouse_x-50, Mouse_y-50, button)
end


return Spell