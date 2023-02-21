local Spell = {}
Spell.quad = {}

Spell.anim = {
    ["fire"]        = love.graphics.newImage("images/spell/fire.png") ,
    ["midnight"]    = love.graphics.newImage("images/spell/midnight.png"),
    ["life"]     = love.graphics.newImage("images/spell/life.png"),
    ["phantom"]  = love.graphics.newImage("images/spell/phantom.png"),
    ["protect"]  = love.graphics.newImage("images/spell/protect.png"),
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
    if key == "e" then
        CreateSpellFire(Hero.anim.x -25, Hero.anim.y-25, MOUSE_X -50, MOUSE_Y -50, "fire")
    end
    if key == "a" then
        CreateSpellMidnight(Hero.anim.x -25, Hero.anim.y -25, MOUSE_X -50, MOUSE_Y -50, "midnight")
    end
    if key == "c" then
        CreateSpellLife(Hero.anim.x -18, Hero.anim.y -18, Hero.anim.x -25, Hero.anim.y -25, "life")
    end
    if key == "f" then
        CreateSpellProtect(Hero.anim.x -18, Hero.anim.y -18, MOUSE_X-50, MOUSE_Y -50, "protect")
    end
end


local lastSpell
local function changeDirSpell(x, y, button)
    if button == 1 then
        for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]
            if s.name == "fire" or "midnight" then
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
    if button == 2 then
        CreateSpellPhantom(Hero.anim.x -25, Hero.anim.y -25, MOUSE_X-50, MOUSE_Y -50, "phantom")
    end
    changeDirSpell(MOUSE_X - 50, MOUSE_Y -50, button)
end

return Spell