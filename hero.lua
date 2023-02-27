Hero = {}

local MySpell = require("spell")


Hero.anim = {
    moveUp = {}, moveDown = {}, moveLeft = {}, moveRight = {},
    attack1Up = {}, attack1Down = {}, attack1Left = {}, attack1Right = {},
    attack2Up = {}, attack2Down = {}, attack2Left = {}, attack2Right = {},
    spell1Up = {}, spell1Down = {}, spell1Left = {}, spell1Right = {},
    spell2Up = {}, spell2Down = {}, spell2Left = {}, spell2Right = {},
    deathUp = {}, deathDown = {}, deathLeft = {}, deathRight = {},
}

Hero.anim.img = love.graphics.newImage("images/personnage/fireMage.png")


Hero.speed = 150
Hero.x = 370
Hero.y = 600--1500
Hero.size = 50

Hero.type = "hero"

Hero.visible = true

Hero.life = 100000000000
Hero.lifeMax = 100000
Hero.hurt = function()
    Hero.life = Hero.life - 0.1
    if Hero.life <= 0 then
        Hero.life = 0
        Hero.visible = false
    end
end
--- --- --- --- --- ---


--Move / Attack1 / Attack2 / Spell1 / Spell2 / Death / Slash
local function loadQuad()
    --Move
    local directions = {"moveUp", "moveLeft", "moveDown", "moveRight"}
    for i, direction in ipairs(directions) do
        for j = 0, 9 do
            Hero.anim[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+7), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImg = 9
    Hero.anim.imgActuelle = 0
    Hero.anim.direction = "moveDown"
    --Attack1
    local attacks1 = {"attack1Up", "attack1Left", "attack1Down", "attack1Right"}
    for i, attack1 in ipairs(attacks1) do
        for j = 0, 8 do
            Hero.anim[attack1][j+1] = love.graphics.newQuad(j * 64, 64 * (i+3), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImgattack1 = 8
    Hero.anim.attack1 = ""
    --Attack2
    local attacks2 = {"attack2Up", "attack2Left", "attack2Down", "attack2Right"}
    for i, attack2 in ipairs(attacks2) do
        for j = 0, 13 do
            Hero.anim[attack2][j+1] = love.graphics.newQuad(j * 64, 64 * (i+15), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImgattack2 = 13
    Hero.anim.attack2 = ""
    --Spell1
    local spalls1 = {"spell1Up", "spell1Left", "spell1Down", "spell1Right"}
    for i, spell1 in ipairs(spalls1) do
        for j = 0, 7 do
            Hero.anim[spell1][j+1] = love.graphics.newQuad(j * 64, 64 * (i-1), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImgspell1 = 7
    Hero.anim.spell1 = ""
    --Spell2
    local spalls2 = {"spell2Up", "spell2Left", "spell2Down", "spell2Right"}
    for i, spell2 in ipairs(spalls2) do
        for j = 0, 6 do
            Hero.anim[spell2][j+1] = love.graphics.newQuad(j * 64, 64 * (i+11), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImgspell2 = 6
    Hero.anim.spell2 = ""
    --death
    local deaths = {"deathUp", "deathLeft", "deathDown", "deathRight"}
    for i, death in ipairs(deaths) do
        for j = 0, 6 do
            Hero.anim[death][j+1] = love.graphics.newQuad(j * 64, 64 * (i+19), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImgdeath = 6
    Hero.anim.death = ""
    --slash

end

Hero.load = function()
    loadQuad()
    MySpell.load()
end


local lastPos = ""
local function updateHeroAnim(dt)
    local isMove = false
    --Move
    if love.keyboard.isDown("z") then
        Hero.anim.direction = "moveUp"
        Hero.y = Hero.y - Hero.speed * dt
        isMove = true
        lastPos = "moveUp"

    elseif love.keyboard.isDown("s") then
        Hero.anim.direction = "moveDown"
        Hero.y = Hero.y + Hero.speed * dt
        isMove = true
        lastPos = "moveDown"

    elseif love.keyboard.isDown("q") then
        Hero.anim.direction = "moveLeft"
        Hero.x = Hero.x - Hero.speed * dt
        isMove = true
        lastPos = "moveLeft"
    elseif love.keyboard.isDown("d") then
        Hero.anim.direction = "moveRight"
        Hero.x = Hero.x + Hero.speed * dt
        isMove = true
        lastPos = "moveRight"
    
    --Attack1
    elseif love.mouse.isDown(1) then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.attack1 = "attack1Up"
        elseif lastPos == "moveDown" then
            Hero.anim.attack1 = "attack1Down"
        elseif lastPos == "moveLeft" then
            Hero.anim.attack1 = "attack1Left"
        elseif lastPos == "moveRight" then
            Hero.anim.attack1 = "attack1Right"
        end
    --Attack2    
    elseif love.mouse.isDown(2) then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.attack2 = "attack2Up"
        elseif lastPos == "moveDown" then
            Hero.anim.attack2 = "attack2Down"
        elseif lastPos == "moveLeft" then
            Hero.anim.attack2 = "attack2Left"
        elseif lastPos == "moveRight" then
            Hero.anim.attack2 = "attack2Right"
        end
    --Spell1    
    elseif love.keyboard.isDown("a") then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.spell1 = "spell1Up"
        elseif lastPos == "moveDown" then
            Hero.anim.spell1 = "spell1Down"
        elseif lastPos == "moveLeft" then
            Hero.anim.spell1 = "spell1Left"
        elseif lastPos == "moveRight" then
            Hero.anim.spell1 = "spell1Right"
        end
    --Spell2    
    elseif love.keyboard.isDown("e") then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.spell2 = "spell2Up"
        elseif lastPos == "moveDown" then
            Hero.anim.spell2 = "spell2Down"
        elseif lastPos == "moveLeft" then
            Hero.anim.spell2 = "spell2Left"
        elseif lastPos == "moveRight" then
            Hero.anim.spell2 = "spell2Right"
        end
    --Death    
    elseif love.keyboard.isDown("r") then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.death = "deathUp"
        elseif lastPos == "moveDown" then
            Hero.anim.death = "deathDown"
        elseif lastPos == "moveLeft" then
            Hero.anim.death = "deathLeft"
        elseif lastPos == "moveRight" then
            Hero.anim.death = "deathRight"
        end
    end

    if isMove == true then
        Hero.anim.imgActuelle = Hero.anim.imgActuelle + Hero.anim.nbImg * dt
        --Move
        if Hero.anim.imgActuelle >= Hero.anim.nbImg then
            Hero.anim.imgActuelle = 0
        end
        --Attack1
        if Hero.anim.imgActuelle >= Hero.anim.nbImgattack1 then
            Hero.anim.imgActuelle = 0
        end
        --Attack2
        if Hero.anim.imgActuelle >= Hero.anim.nbImgattack2 then
            Hero.anim.imgActuelle = 0
        end
        --Spell1
        if Hero.anim.imgActuelle >= Hero.anim.nbImgspell1 then
            Hero.anim.imgActuelle = 0
        end
        --Spell2
        if Hero.anim.imgActuelle >= Hero.anim.nbImgspell2 then
            Hero.anim.imgActuelle = 0
        end
        --Death
        if Hero.anim.imgActuelle >= Hero.anim.nbImgdeath then
            Hero.anim.imgActuelle = 0
        end
    else
        Hero.anim.imgActuelle = 0
    end
end

Hero.update = function(dt)
    updateHeroAnim(dt)
    MySpell.update(dt)
end


local function drawHeroAnim()
    local x = Hero.x + Camera_x 
    local y = Hero.y + Camera_y 

    local directions = {
        moveUp = Hero.anim.moveUp,
        moveDown = Hero.anim.moveDown,
        moveLeft = Hero.anim.moveLeft,
        moveRight = Hero.anim.moveRight,
        
    }
    local attacks1 = {
        attack1Up = Hero.anim.attack1Up,
        attack1Down = Hero.anim.attack1Down,
        attack1Left = Hero.anim.attack1Left,
        attack1Right = Hero.anim.attack1Right,
    }

    local attacks2 = {
        attack2Up = Hero.anim.attack2Up,
        attack2Down = Hero.anim.attack2Down,
        attack2Left = Hero.anim.attack2Left,
        attack2Right = Hero.anim.attack2Right,
    }
    local spells1 = {
        spell1Up = Hero.anim.spell1Up,
        spell1Down = Hero.anim.spell1Down,
        spell1Left = Hero.anim.spell1Left,
        spell1Right = Hero.anim.spell1Right,
    }
    local spells2 = {
        spell2Up = Hero.anim.spell2Up,
        spell2Down = Hero.anim.spell2Down,
        spell2Left = Hero.anim.spell2Left,
        spell2Right = Hero.anim.spell2Right,
    }
    local deaths = {
        deathUp = Hero.anim.deathUp,
        deathDown = Hero.anim.deathDown,
        deathLeft = Hero.anim.deathLeft,
        deathRight = Hero.anim.deathRight,
}
    --Attack1
    if love.mouse.isDown(1) then
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then
            love.graphics.draw(Hero.anim.img, attacks1[Hero.anim.attack1][math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    --Attack2
    elseif love.mouse.isDown(2) then
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then
            love.graphics.draw(Hero.anim.img, attacks2[Hero.anim.attack2][math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    --Spell1
    elseif love.keyboard.isDown("a") then
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then
            love.graphics.draw(Hero.anim.img, spells1[Hero.anim.spell1][math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    --Spell2
    elseif love.keyboard.isDown("e") then
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then
            love.graphics.draw(Hero.anim.img, spells2[Hero.anim.spell2][math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    --Death
    elseif love.keyboard.isDown("r") then
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then
            love.graphics.draw(Hero.anim.img, deaths[Hero.anim.death][math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    --Move
    else
        love.graphics.draw(Hero.anim.img, directions[Hero.anim.direction][math.floor(Hero.anim.imgActuelle)+1], x, y)
    end
end

Hero.draw = function()
    love.graphics.print(math.floor(Hero.life), Hero.x+20+Camera_x,Hero.y+Camera_y)
    drawHeroAnim()
    MySpell.draw()
end


local function keypressedSpell(key)
    if key == "e" then
        CreateSpellFire(Hero.x -25, Hero.y-25, Mouse_x -50, Mouse_y -50, "fire")
    end
    if key == "a" then
        CreateSpellMidnight(Hero.x -25, Hero.y -25, Mouse_x -50, Mouse_y -50, "midnight")
    end
    if key == "c" then
        CreateSpellLife(Hero.x -18, Hero.y -18, Hero.x -25, Hero.y -25, "life")
    end
    if key == "f" then
        CreateSpellProtect(Hero.x -18, Hero.y -18, Mouse_x-50, Mouse_y -50, "protect")
    end
end

Hero.keypressed = function(key)
    keypressedSpell(key)
end


local function mousepressedSpell(x, y, button)
    if button == 2 then
        CreateSpellPhantom(Hero.x -25, Hero.y -25, Mouse_x-50, Mouse_y -50, "phantom")
    end
end

Hero.mousepressed = function(x, y, button)
    mousepressedSpell(x, y, button)
    MySpell.mousepressed(x, y, button)
end


return Hero