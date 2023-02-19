local Spell = {}
Spell.quad = {} 

Spell.anim = {
    ["fire"]        = love.graphics.newImage("images/spell/fire.png") ,
    ["midnight"]    = love.graphics.newImage("images/spell/midnight.png")
}


MOUSE_X = 0
MOUSE_Y = 0


--- --- --- --- --- ---

local function loadQuad()
    
    for i = 1, 8, 1 do
        for j = 1, 8, 1 do
            if (i-1)*8 + j <= 61 then -- Dans l'idÃ©e ou tu as que 61 quad par images
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

function createSpell(x,y,dx,dy,name)
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
    MOUSE_X, MOUSE_Y = love.mouse.getPosition()
    MOUSE_X = MOUSE_X - Camera_x
    MOUSE_Y = MOUSE_Y - Camera_y
    
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
        createSpell(Hero.anim.x -25, Hero.anim.y-25, MOUSE_X -50, MOUSE_Y -50, "fire")
    end
    if key == "a" then
        createSpell(Hero.anim.x -25, Hero.anim.y -25, MOUSE_X-50, MOUSE_Y -50, "midnight")
    end
end


Spell.mousepressed = function()
end


return Spell