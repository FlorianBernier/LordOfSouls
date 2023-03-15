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
    ["disintegration"] = love.graphics.newImage("images/spell/disintegration.png"),
    ["nebula"] = love.graphics.newImage("images/spell/nebula.png"),
    ["vortex"] = love.graphics.newImage("images/spell/vortex.png"),
}

--- --- --- --- --- --- test test2
phantomInvisibility = 0

 function loadQuad()
    
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
        speed = 150,

        frame = 1,
        frameMax = 61,
        frameSpeed = 12,
        degat = 2500,
        mana = 5
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
        speed = 100,

        frame = 1,
        frameMax = 61,
        frameSpeed = 12,
        degat = 100,
        mana = 17
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
        heal = 500,
        mana = 150
        
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
        mana = 25
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
        mana = 150
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
        speed = 150,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
        degat = 50,
        mana = 0
    }


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
        degat = 50,
        mana = 0
    }
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end

function CreateSpellDisintegration(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 300,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
        degat = 10000,
        mana = 0
    }
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end

function CreateSpellNebula(x,y,dx,dy,name)
    local spell = {
        x = x,
        y = y,
        dx = dx,
        dy = dy,
        name = name,

        
        angle = math.atan2(dy-y, dx- x),
        speed = 400,

        frame = 1,
        frameMax = 61,
        frameSpeed = 8,
        degat = 7000,
        mana = 0
    }
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end

function CreateSpellVortex(x,y,dx,dy,name)
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
        frameSpeed = 4,
        degat = 50000,
        mana = 0
    }
    spell.vx = math.cos(spell.angle) * spell.speed
    spell.vy = math.sin(spell.angle) * spell.speed

    table.insert(listeSpells, spell)
end

local function updateSpell(dt)

    for i = #listeSpells, 1, -1 do
        local s = listeSpells[i]
        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        s.frame = s.frame + s.frameSpeed * dt
        for j = #ListMonstre, 1, -1 do
        local monstre = ListMonstre[j]

        local distMonstre = Dist_P_P(monstre.x-50, monstre.y-50, s.x, s.y)
            if s.name == "fire" then
                Hero.mana = Hero.mana - s.mana
                if distMonstre <= monstre.size then
                    monstre.life = monstre.life - s.degat
                    table.remove(listeSpells, i)
                end
            end
            if s.name == "midnight" then
                Hero.mana = Hero.mana - s.mana
                if distMonstre <= monstre.size then
                    monstre.life = monstre.life - s.degat
                end
            end
            if s.name == "phantom" then
                Hero.mana = Hero.mana - s.mana
                if distMonstre <= monstre.size then
                    monstre.blind = true
                    monstre.blindTimer = 3
                    table.remove(listeSpells, i)
                end
            end
        end
        if s.name == "life" then
            Hero.mana = Hero.mana - s.mana
            local distHero = Dist_P_P(Hero.x-25, Hero.y-25, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life + s.heal
                if Hero.life > Hero.lifeMax then
                    Hero.life = Hero.lifeMax
                end
            end
        end
        --- --- --- --- --- ---
        if s.name == "bluefire" then
            local distHero = Dist_P_P(Hero.x-50, Hero.y-50, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life - s.degat
            end
        end
        if s.name == "brightfire" then
            local distHero = Dist_P_P(Hero.x-50, Hero.y-50, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life - s.degat
            end
        end
        if s.name == "disintegration" then
            local distHero = Dist_P_P(Hero.x-50, Hero.y-50, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life - s.degat
                table.remove(listeSpells, i)
            end
        end
        if s.name == "nebula" then
            local distHero = Dist_P_P(Hero.x-50, Hero.y-50, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life - s.degat
                table.remove(listeSpells, i)
            end
        end
        if s.name == "vortex" then
            local distHero = Dist_P_P(Hero.x-50, Hero.y-50, s.x, s.y)
            if distHero <= Hero.size then
                Hero.life = Hero.life - s.degat
                table.remove(listeSpells, i)
            end
        end
    


        if s.frame > 61 then
            table.remove(listeSpells, i)
        end
    end
end



Spell.update = function(dt)
    updateSpell(dt)
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
function changeDirSpell(x, y, button)
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