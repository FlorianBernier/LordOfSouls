local Monster = {}

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

local VAR = {speedSprite = 7}

local ZSTATES = {NONE = "", WALK = "walk", ATTACK = "attack", BITE = "bite", CHANGEDIR = "change"}

local imgAlert = love.graphics.newImage("images copy/alert.png")



local imgMonster= {
    love.graphics.newImage("images copy/deathTest.png"),
    love.graphics.newImage("images copy/deathTest2.png")}

--- --- --- --- --- --- ---
local listSprite = {}
local function createSprite(pList, pType)
    local mySprite = {}
    mySprite.type = pType
    mySprite.visible = true
    mySprite.img = {}
    mySprite.currentFrame = 1
    mySprite.img = imgMonster

    mySprite.x = 0
    mySprite.y = 0
    mySprite.vx = 0
    mySprite.vy = 0
    mySprite.w = mySprite.img[1]:getWidth()
    mySprite.h = mySprite.img[1]:getHeight()

    table.insert(pList, mySprite)
    return mySprite
end

local function createDeath()
    local myDeath = 
    createSprite(listSprite, "zombie", "monster_", 2)
    myDeath.x = math.random(10, Screen_Width - 10)
    myDeath.y = math.random(10, (Screen_Height/2) - 10)
    myDeath.speed = math.random(20, 100) / 200
    myDeath.range = math.random(50, 200)
    myDeath.target = nil

    myDeath.state = ZSTATES.NONE
    
end

local function createDragon()
    local myDeath = 
    createSprite(listSprite, "toto", "monster_", 2)
    myDeath.x = math.random(10, Screen_Width - 10)
    myDeath.y = math.random(10, (Screen_Height/2) - 10)
    myDeath.speed = math.random(500, 2000) / 200
    myDeath.range = math.random(200, 500)
    myDeath.target = nil

    myDeath.state = ZSTATES.NONE
end

Monster.load = function()
    createDragon()
    for i = 1, 5 do
        createDeath()
    end
end

local function updateDeath(death)
    if death.state == ZSTATES.NONE then
        death.state = ZSTATES.CHANGEDIR
    elseif death.state == ZSTATES.WALK then
        --collide with border 
        local bordCollide = false
        if death.x < 0 then
            death.x = 0
            bordCollide = true
        end
        if death.x > Screen_Width then
            death.x = Screen_Width
            bordCollide = true
        end
        if death.y < 0 then
            death.y = 0
            bordCollide = true
        end
        if death.y > Screen_Height then
            death.y = Screen_Height
            bordCollide = true
        end
        if bordCollide then
            death.state = ZSTATES.CHANGEDIR
        end

        --look for hero 
        
        if Hero.type == "hero" and Hero.visible == true then
            local distance = math.dist(death.x, death.y, Hero.x, Hero.y)
            if distance < death.range then
                death.state = ZSTATES.ATTACK
                death.target = Hero
                CreateSpellFire(death.x-50, death.y-50, Hero.x -25, Hero.y-25, "bluefire")
                --CreateSpellLife(death.x-50, death.y-50, Hero.x -25, Hero.y-25,"life")
                CreateSpellBrightfire(Hero.x -25, Hero.x -25, Hero.x -25, Hero.y-25, "brightfire")
            end
        end
        

    elseif death.state == ZSTATES.ATTACK then
        if death.target == nil then
            death.state = ZSTATES.CHANGEDIR
        elseif math.dist(death.x, death.y, death.target.x, death.target.y) > death.range and death.target.type == "hero" then
            death.state = ZSTATES.CHANGEDIR
        elseif math.dist(death.x, death.y, death.target.x, death.target.y) < 5 and death.target.type == "hero" then
            death.state = ZSTATES.BITE
            death.vx = 0
            death.vy = 0
        else
            --attack
            local destX, destY
            destX = math.random(death.target.x-20, death.target.x+20)
            destY = math.random(death.target.y-20, death.target.y+20)
            local angle = math.angle(death.x, death.y, destX, destY)
            death.vx = death.speed* 2 * 60 * math.cos(angle)
            death.vy = death.speed* 2 * 60 * math.sin(angle)
        end
    elseif death.state == ZSTATES.BITE then
        if math.dist(death.x, death.y, death.target.x, death.target.y) > 5 and death.target.type == "hero" then
            death.state = ZSTATES.ATTACK
        else
            if death.target.hurt ~= nil then
            death.target.hurt()
            end
            if death.target.visible == false then
                death.state = ZSTATES.CHANGEDIR
            end
        end
    elseif death.state == ZSTATES.CHANGEDIR then
        local angle = math.angle(death.x, death.y, math.random(0, Screen_Width), math.random(0, Screen_Height))
        death.vx = death.speed * 60 * math.cos(angle)
        death.vy = death.speed * 60 * math.sin(angle)
        death.state = ZSTATES.WALK
    end
end

local function animeSprite(dt)
    for i, sprite in ipairs(listSprite) do
        sprite.currentFrame = sprite.currentFrame + VAR.speedSprite*dt
        if sprite.currentFrame >= #sprite.img+1 then-- +1: du fait d'avoir utiliser math.floor(frame)
            sprite.currentFrame = 1
        end
        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt

        -- if sprite.type == "zombie" then
        --     updateDeath(sprite, listSprite)
        -- end
        
        if sprite.type == "toto" then
            updateDeath(sprite, listSprite)
        end
    end
end

Monster.update = function(dt)
    animeSprite(dt)
end


Monster.draw = function()
    for i, sprite in ipairs(listSprite) do
        if sprite.visible == true then
            local frame = sprite.img[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - (sprite.w/2)+Camera_x, sprite.y - (sprite.h/2)+Camera_y)
            if sprite.type == "zombie" then
                if love.keyboard.isDown("f5") then
                    love.graphics.print(sprite.state, sprite.x - 10+Camera_x, sprite.y - sprite.h - 10+Camera_y)
                end
                if sprite.state == ZSTATES.ATTACK then
                    love.graphics.draw(imgAlert, sprite.x - imgAlert:getWidth()/2+Camera_x, sprite.y+50 - sprite.h - 2+Camera_y)
                end
            end
        end
    end
end


return Monster