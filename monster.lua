local Monster = {}

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

local VAR = {speedSprite = 7}

local ZSTATES = {NONE = "", WALK = "walk", ATTACK = "attack", BITE = "bite", CHANGEDIR = "change"}

local imgAlert = love.graphics.newImage("images/monster/type/action/alert.png")



local imgDeath = {
    love.graphics.newImage("images/monster/type/death/deathTest.png"),
    love.graphics.newImage("images/monster/type/death/deathTest2.png")}

local imgBloodMage = {
    love.graphics.newImage("images/monster/type/bloodMage/bloodMage1.png"),
    love.graphics.newImage("images/monster/type/bloodMage/bloodMage2.png")}
--- --- --- --- --- --- ---
local listSprite = {}
local function createSprite(pList, pType, pImgFileName, pFrame, pimgMonstre)
    local mySprite = {}
    mySprite.type = pType
    mySprite.visible = true
    mySprite.img = {}
    mySprite.currentFrame = 1
    for i = 1, #pimgMonstre do
        table.insert(mySprite.img, pimgMonstre[i])
    end

    mySprite.x = 0
    mySprite.y = 0
    mySprite.vx = 0
    mySprite.vy = 0
    mySprite.w = mySprite.img[1]:getWidth()
    mySprite.h = mySprite.img[1]:getHeight()

    table.insert(pList, mySprite)
    return mySprite
end

function CreateDeath()
    local myDeath = 
    createSprite(listSprite, "death", "death_", 2, imgDeath)
    myDeath.x = math.random(10, Screen_Width - 10)
    myDeath.y = math.random(10, (Screen_Height/2) - 10)
    myDeath.speed = math.random(400) / 200
    myDeath.range = math.random(200,300)
    myDeath.target = nil
    myDeath.timeSpell = 0

    myDeath.state = ZSTATES.NONE
end

function CreateBloodMage()
    local myBloodMage = 
    createSprite(listSprite, "bloodmage", "bloodmage_", 2, imgBloodMage)
    myBloodMage.x = math.random(10, Screen_Width - 10)
    myBloodMage.y = math.random(10, (Screen_Height/2) - 10)
    myBloodMage.speed = math.random(100,200) / 200
    myBloodMage.range = math.random(300,400)
    myBloodMage.target = nil
    myBloodMage.timeSpell = 0

    myBloodMage.state = ZSTATES.NONE
end

Monster.load = function()
end

local function statesCollideBorder(monster, x, y ,w ,h)
    if monster.state == ZSTATES.NONE then
        monster.state = ZSTATES.CHANGEDIR
    elseif monster.state == ZSTATES.WALK then
        --collide with border 
        local bordCollide = false
        if monster.x < x then
            monster.x = x
            bordCollide = true
        end
        if monster.x > w then
            monster.x = w
            bordCollide = true
        end
        if monster.y < y then
            monster.y = y
            bordCollide = true
        end
        if monster.y > h then
            monster.y = h
            bordCollide = true
        end
        if bordCollide then
            monster.state = ZSTATES.CHANGEDIR
        end
    end
end

local function statesLookHero(monster)
    --look for hero 
    if Hero.type == "hero" and Hero.visible == true then
        local distance = math.dist(monster.x, monster.y, Hero.x, Hero.y)
        if distance < monster.range then
            monster.state = ZSTATES.ATTACK
            monster.target = Hero
            monster.timeSpell = monster.timeSpell - 1
            if monster.timeSpell <= 0 then
                monster.timeSpell = 30
                CreateSpellFire(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "bluefire")
                CreateSpellBrightfire(Hero.x -25, Hero.x -25, Hero.x -25, Hero.y-25, "brightfire")
            end
        end
    end
end

local function statesAttack(monster)
    if monster.state == ZSTATES.ATTACK then
        if monster.target == nil then
            monster.state = ZSTATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > monster.range and monster.target.type == "hero" then
            monster.state = ZSTATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) < 5 and monster.target.type == "hero" then
            monster.state = ZSTATES.BITE
            monster.vx = 0
            monster.vy = 0
        else
            --attack
            local destX, destY
            destX = math.random(monster.target.x-20, monster.target.x+20)
            destY = math.random(monster.target.y-20, monster.target.y+20)
            local angle = math.angle(monster.x, monster.y, destX, destY)
            monster.vx = monster.speed* 2 * 60 * math.cos(angle)
            monster.vy = monster.speed* 2 * 60 * math.sin(angle)
        end
    end
end

local function statesAttacCaC(monster)
    if monster.state == ZSTATES.BITE then
        if math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > 5 and monster.target.type == "hero" then
            monster.state = ZSTATES.ATTACK
        else
            if monster.target.hurt ~= nil then
            monster.target.hurt()
            end
            if monster.target.visible == false then
                monster.state = ZSTATES.CHANGEDIR
            end
        end
    elseif monster.state == ZSTATES.CHANGEDIR then
        local angle = math.angle(monster.x, monster.y, math.random(0, Screen_Width), math.random(0, Screen_Height))
        monster.vx = monster.speed * 60 * math.cos(angle)
        monster.vy = monster.speed * 60 * math.sin(angle)
        monster.state = ZSTATES.WALK
    end
end

local function updateDeath(death)
    statesCollideBorder(death,0,100,400, 200)
    statesLookHero(death)
    statesAttack(death)
    statesAttacCaC(death)
end

local function updateBloodMage(bloodMage)
    statesCollideBorder(bloodMage,400,100, 800, 200)
    statesLookHero(bloodMage)
    statesAttack(bloodMage)
    statesAttacCaC(bloodMage)
end


local function animeSprite(dt)
    for i, sprite in ipairs(listSprite) do
        sprite.currentFrame = sprite.currentFrame + VAR.speedSprite*dt
        if sprite.currentFrame >= #sprite.img+1 then-- +1: du fait d'avoir utiliser math.floor(frame)
            sprite.currentFrame = 1
        end
        sprite.x = sprite.x + sprite.vx * dt
        sprite.y = sprite.y + sprite.vy * dt
        
        if sprite.type == "death" then
            updateDeath(sprite)
        end
        if sprite.type == "bloodmage" then
            updateBloodMage(sprite)
        end
    end
end

Monster.update = function(dt)
    animeSprite(dt)
end

local function drawMonster()
    for i, sprite in ipairs(listSprite) do
        if sprite.visible == true then
            local frame = sprite.img[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - (sprite.w/2)+Camera_x, sprite.y - (sprite.h/2)+Camera_y)
            if sprite.type == "death" then
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

Monster.draw = function()
    drawMonster()
end


return Monster