local Monster = {}
Monster.quad = {}

local STATES = {NONE = "", WALK = "walk", ATTACK = "attack", BITE = "bite", CHANGEDIR = "changedir"}

Monster.anim = {
    ["moveLeft"]     = love.graphics.newImage("images/death/moveLeft.png") ,
    ["moveRight"]    = love.graphics.newImage("images/death/moveRight.png"),
    ["Spell1Left"]   = love.graphics.newImage("images/death/Spell1Left.png"),
    ["Spell1Right"]  = love.graphics.newImage("images/death/Spell1Right.png"),
    ["Spell2Left"]   = love.graphics.newImage("images/death/Spell2Left.png"),
    ["Spell2Right"]  = love.graphics.newImage("images/death/Spell2Right.png"),
    ["Spell3Left"]   = love.graphics.newImage("images/death/Spell3Left.png"),
    ["Spell3Right"]  = love.graphics.newImage("images/death/Spell3Right.png"),
}
--- --- --- --- --- --- ---

local function loadQuad()
    
    for i = 1, 6, 1 do
        Monster.quad[i] = love.graphics.newQuad((i-1)*100, 0,100,100, Monster.anim["moveLeft"]:getDimensions())
    end
end

local listeMonster = {}

function CreateDeath(x,y)
    local Monster = {
        x = x,
        y = y,

        vx = -50,
        vy = 0,
        frame = 1,
        frameMax = 6,
        frameSpeed = 0.1,
        direction = "right",
        speed = 50
    }
    table.insert(listeMonster, Monster)
end

Monster.load = function()
    loadQuad()
    CreateDeath(800,100)
    CreateDeath(800,300)
end



Monster.update = function(dt)

    for i = #listeMonster, 1, -1 do
        local s = listeMonster[i]

        s.x = s.x + s.vx * dt
        s.y = s.y + s.vy * dt
        s.frame = s.frame + s.frameSpeed * dt
        if s.frame > 6 then
            table.remove(listeMonster, i)
        end
    end
end



Monster.draw = function()
    for i, monster in ipairs(listeMonster) do
        local quad = Monster.quad[math.floor(monster.frame)]
        love.graphics.draw(Monster.anim["moveLeft"], quad, monster.x+ Camera_x, monster.y+ Camera_y)
    end
end


return Monster