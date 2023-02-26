Monster = {}

-- Returns the distance between two points.
function math.dist(x1,y1, x2,y2) return ((x2-x1)^2+(y2-y1)^2)^0.5 end

-- Returns the angle between two vectors assuming the same origin.
function math.angle(x1,y1, x2,y2) return math.atan2(y2-y1, x2-x1) end

local VAR = {speedSprite = 7}

STATES = {NONE = "", WALK = "walk", ATTACK = "attack", BITE = "bite", CHANGEDIR = "change", CHANGEDIR2 = false}

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
    Death = createSprite(listSprite, "death", "death_", 2, imgDeath)
    Death.x = math.random(10, Screen_Width - 10)
    Death.y = math.random(10, (Screen_Height/2) - 10)
    Death.speed = math.random(400) / 200
    Death.range = math.random(200,300)
    Death.target = nil
    Death.size = 50
    Death.life = 30000
    Death.timeSpellFire = 0
    Death.timeSpellBrightFire = 0

    Death.state = STATES.NONE
end

function CreateBloodMage()
    BloodMage = createSprite(listSprite, "bloodmage", "bloodmage_", 2, imgBloodMage)
    BloodMage.x = math.random(10, Screen_Width - 10)
    BloodMage.y = math.random(10, (Screen_Height/2) - 10)
    BloodMage.speed = math.random(100,200) / 200
    BloodMage.range = math.random(300,400)
    BloodMage.target = nil
    BloodMage.size = 50
    BloodMage.life = 50000
    BloodMage.timeSpellFire = 0
    BloodMage.timeSpellBrightFire = 0


    BloodMage.state = STATES.NONE
end

Monster.load = function()
end

local function statesCollideBorder(monster, x, y ,w ,h)
    if monster.state == STATES.NONE then
        monster.state = STATES.CHANGEDIR
    elseif monster.state == STATES.WALK then
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
            monster.state = STATES.CHANGEDIR
        end
    end
end 

local function statesLookHero(monster)
    --look for hero 
    if Hero.type == "hero" and Hero.visible then
        local distance = math.dist(monster.x, monster.y, Hero.x, Hero.y)
        if distance < monster.range then
            monster.state = STATES.ATTACK
            monster.target = Hero
            monster.timeSpellFire = monster.timeSpellFire - 1
            monster.timeSpellBrightFire = monster.timeSpellBrightFire - 1
            if monster.timeSpellFire <= 0 then
                monster.timeSpellFire = 100
                CreateSpellFire(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "bluefire")
            end
                if monster.timeSpellBrightFire <= 0 then
                monster.timeSpellBrightFire = 500
                CreateSpellBrightfire(Hero.x -25, Hero.x -25, Hero.x -25, Hero.y-25, "brightfire")
            end
        end
    end
end

local function statesAttack(monster)
    if monster.state == STATES.ATTACK then
        if monster.target == nil then
            monster.state = STATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > monster.range and monster.target.type == "hero" then
            monster.state = STATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) < 5 and monster.target.type == "hero" then
            monster.state = STATES.BITE
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
    if monster.state == STATES.BITE then
        if math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > 5 and monster.target.type == "hero" then
            monster.state = STATES.ATTACK
        else
            if monster.target.hurt ~= nil then
            monster.target.hurt()
            end
            if monster.target.visible == false then
                monster.state = STATES.CHANGEDIR
            end
        end
    elseif monster.state == STATES.CHANGEDIR then
        local angle = math.angle(monster.x, monster.y, math.random(0, Screen_Width), math.random(0, Screen_Height))
        monster.vx = monster.speed * 60 * math.cos(angle)
        monster.vy = monster.speed * 60 * math.sin(angle)
        monster.state = STATES.WALK
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
            if Death.life <= 0 then
                table.remove(listSprite, i)
            end
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
    if Death.life > 0 then
    love.graphics.print(math.floor(Death.life), Death.x+Camera_x,Death.y-50+Camera_y)
    end
    if BloodMage.life > 0 then
    love.graphics.print(math.floor(BloodMage.life), BloodMage.x+Camera_x,BloodMage.y-50+Camera_y)
    end
    for i, sprite in ipairs(listSprite) do
        if sprite.visible == true then
            local frame = sprite.img[math.floor(sprite.currentFrame)]
            love.graphics.draw(frame, sprite.x - (sprite.w/2)+Camera_x, sprite.y - (sprite.h/2)+Camera_y)
            if sprite.type == "death" then
                if love.keyboard.isDown("f5") then
                    love.graphics.print(sprite.state, sprite.x - 10+Camera_x, sprite.y - sprite.h - 10+Camera_y)
                end
                if sprite.state == STATES.ATTACK then
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