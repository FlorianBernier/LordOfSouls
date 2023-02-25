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
        bonusHeal = 10,

        
    }
    
    Hero.life = Hero.life + spell.bonusHeal
    
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
    local distance = math.dist(x, y, Hero.x, Hero.y)
    if distance <= 50 then
        Hero.life = Hero.life - 10
    end
    
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end



local function updateSpellAnim(dt)
    for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]

        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        s.frame = s.frame + s.frameSpeed * dt
        if s.frame > 61 then
            table.remove(listeSpells, i)
        end
    end
    
end

Spell.update = function(dt)
    updateSpellAnim(dt)
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
            if s.name == "fire" or  s.name == "midnight" then
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