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
ListMonstre = {}

function CreateDeath(x,y)
    Death = {}
    Death.type = "death"
    Death.visible = true
    Death.currentFrame = 1
    Death.img = {}
    for i = 1, #imgDeath do
        table.insert(Death.img, imgDeath[i])
    end
    Death.vx = 0
    Death.vy = 0
    Death.w = Death.img[1]:getWidth()
    Death.h = Death.img[1]:getHeight()    
    Death.x = x
    Death.y = y
    Death.speed = math.random(400) / 200
    Death.range = math.random(200,300)
    Death.target = nil
    Death.size = 50
    Death.life = 30000
    Death.timeSpellBlueFire = 0
    Death.timeSpellBrightFire = 0
    Death.timeSpellDisintegration = 0
    Death.timeSpellNebula = 0
    Death.timeSpellVortex = 0
    Death.blind = false
    Death.blindTimer = 0
    Death.state = STATES.NONE
    table.insert(ListMonstre, Death)
end

function CreateBloodMage(x,y)
    BloodMage = {}
    BloodMage.type = "bloodmage"
    BloodMage.visible = true
    BloodMage.currentFrame = 1
    BloodMage.img = {}
    for i = 1, #imgBloodMage do
        table.insert(BloodMage.img, imgBloodMage[i])
    end
    BloodMage.vx = 0
    BloodMage.vy = 0
    BloodMage.w = BloodMage.img[1]:getWidth()
    BloodMage.h = BloodMage.img[1]:getHeight()    
    BloodMage.x = x
    BloodMage.y = y
    BloodMage.speed = math.random(100,200) / 200
    BloodMage.range = math.random(300,400)
    BloodMage.target = nil
    BloodMage.size = 50
    BloodMage.life = 50000
    BloodMage.timeSpellBlueFire = 0
    BloodMage.timeSpellBrightFire = 0
    BloodMage.timeSpellDisintegration = 0
    BloodMage.timeSpellNebula = 0
    BloodMage.timeSpellVortex = 0
    BloodMage.blind = false
    BloodMage.blindTimer = 0
    BloodMage.state = STATES.NONE
    table.insert(ListMonstre, BloodMage)
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

local function statesLookHero(monster, cd1, cd2, cd3, cd4, cd5)
    --look for hero 
    local distance = math.dist(monster.x, monster.y, Hero.x, Hero.y)
    if distance < monster.range then
        monster.state = STATES.ATTACK
        monster.target = Hero
        monster.timeSpellBlueFire = monster.timeSpellBlueFire - 1
        monster.timeSpellBrightFire = monster.timeSpellBrightFire - 1
        monster.timeSpellDisintegration = monster.timeSpellDisintegration - 1
        monster.timeSpellNebula = monster.timeSpellNebula - 1
        monster.timeSpellVortex = monster.timeSpellVortex - 1
        if monster.timeSpellBlueFire <= 0 then
            monster.timeSpellBlueFire = cd1
            CreateSpellBluefire(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "bluefire")
        end
        if monster.timeSpellBrightFire <= 0 then
            monster.timeSpellBrightFire = cd2
            CreateSpellBrightfire(OldXHero-25, OldYHero-25, Hero.x -25, Hero.y-25, "brightfire")
        end
        if monster.timeSpellDisintegration <= 0 then
            monster.timeSpellDisintegration = cd3
            CreateSpellDisintegration(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "disintegration")
        end
        if monster.timeSpellNebula <= 0 then
            monster.timeSpellNebula = cd4
            CreateSpellNebula(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "nebula")
        end
        if monster.timeSpellVortex <= 0 then
            monster.timeSpellVortex = cd5
            CreateSpellVortex(monster.x-50, monster.y-50, Hero.x -25, Hero.y-25, "vortex")
        end
    end
end

local function statesAttack(monster)
    if monster.state == STATES.ATTACK then
        if monster.target == nil then
            monster.state = STATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > monster.range and monster.target.type == "hero" then
            monster.state = STATES.CHANGEDIR
        elseif math.dist(monster.x, monster.y, monster.target.x, monster.target.y) < monster.range-100 and monster.target.type == "hero" then
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
        if math.dist(monster.x, monster.y, monster.target.x, monster.target.y) > monster.range-100 and monster.target.type == "hero" then
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
    statesCollideBorder(death,0,100,800, 1500)
    statesLookHero(death, 200, 300, 400, 500, 800)
    statesAttack(death)
    statesAttacCaC(death)
end

local function updateBloodMage(bloodMage)
    statesCollideBorder(bloodMage,0,100, 800, 1500)
    statesLookHero(bloodMage, 10, 200, 300, 400, 800)
    statesAttack(bloodMage)
    statesAttacCaC(bloodMage)
end


local function animeSprite(dt)
    for i = #ListMonstre, 1, -1 do
        local monstre = ListMonstre[i]
        monstre.blindTimer = monstre.blindTimer - dt
        if monstre.blind and monstre.blindTimer >= 0 then
            monstre.range = 0
        elseif monstre.blind and monstre.blindTimer < 0 then
            monstre.blind = false
            if monstre.type == "death" then
                monstre.range = math.random(200,300)
            end
            if monstre.type == "bloodmage" then
                monstre.range = math.random(300,400)
            end
        end

        monstre.currentFrame = monstre.currentFrame + VAR.speedSprite*dt
        if monstre.currentFrame >= #monstre.img+1 then-- +1: du fait d'avoir utiliser math.floor(frame)
            monstre.currentFrame = 1
        end
        monstre.x = monstre.x + monstre.vx * dt
        monstre.y = monstre.y + monstre.vy * dt
        if monstre.type == "death" then
            updateDeath(monstre)
            if monstre.life <= 0 then
                table.remove(ListMonstre, i)
            end
        end
        if monstre.type == "bloodmage" then
            updateBloodMage(monstre)
            if monstre.life <= 0 then
                table.remove(ListMonstre, i)
            end
        end
    end
end

Monster.update = function(dt)
    animeSprite(dt)
end

local function drawMonster()
    for i = #ListMonstre, 1, -1 do
        local monstre = ListMonstre[i]
        if monstre.life > 0 then
            love.graphics.print(math.floor(monstre.life), monstre.x+Camera_x,monstre.y-50+Camera_y)
        end
    end
    for i, sprite in ipairs(ListMonstre) do
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