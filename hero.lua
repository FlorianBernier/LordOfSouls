local Hero = {}

Hero.speed = 100

Hero.anim = {
    moveUp = {}, moveDown = {}, moveLeft = {}, moveRight = {},
    attackUp = {}, attackDown = {}, attackLeft = {}, attackRight = {}
}

Hero.anim.x = 0
Hero.anim.y = 0
Hero.anim.img = love.graphics.newImage("images/hero.png")

--- --- --- --- --- --- 

local function loadQuad()
    local directions = {"moveUp", "moveLeft", "moveDown", "moveRight"}
    for i, direction in ipairs(directions) do
        for j = 0, 9 do
            Hero.anim[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+7), 64, 64, Hero.anim.img)
        end
    end
    local attacks = {"attackUp", "attackLeft", "attackDown", "attackRight"}
    for i, attack in ipairs(attacks) do
        for j = 0, 8 do
            Hero.anim[attack][j+1] = love.graphics.newQuad(j * 64, 64 * (i+3), 64, 64, Hero.anim.img)
        end
    end
    
    Hero.anim.nbImg = 9
    Hero.anim.imgActuelle = 0
    Hero.anim.direction = "moveDown"
    Hero.anim.nbImgAttack = 8
    Hero.anim.attack = ""

    
end


Hero.load = function()
    loadQuad()
end

local lastPos = ""

local function updateHeroAnim(dt)
    local isMove = false
    
    
    if love.keyboard.isDown("z") then
        Hero.anim.direction = "moveUp"
        Hero.anim.y = Hero.anim.y - Hero.speed * dt
        isMove = true
        lastPos = "moveUp"

    elseif love.keyboard.isDown("s") then
        Hero.anim.direction = "moveDown"
        Hero.anim.y = Hero.anim.y + Hero.speed * dt
        isMove = true
        lastPos = "moveDown"

    elseif love.keyboard.isDown("q") then
        Hero.anim.direction = "moveLeft"
        Hero.anim.x = Hero.anim.x - Hero.speed * dt
        isMove = true
        lastPos = "moveLeft"
    elseif love.keyboard.isDown("d") then
        Hero.anim.direction = "moveRight"
        Hero.anim.x = Hero.anim.x + Hero.speed * dt
        isMove = true
        lastPos = "moveRight"
    

    elseif love.keyboard.isDown("e") then
        isMove = true
        if lastPos == "moveUp" then
            Hero.anim.attack = "attackUp"
        elseif lastPos == "moveDown" then
            Hero.anim.attack = "attackDown"
        elseif lastPos == "moveLeft" then
            Hero.anim.attack = "attackLeft"
        elseif lastPos == "moveRight" then
            Hero.anim.attack = "attackRight"
            
        end
    end

    if isMove == true then
        Hero.anim.imgActuelle = Hero.anim.imgActuelle + Hero.anim.nbImg * dt
        if Hero.anim.imgActuelle >= Hero.anim.nbImg then
            Hero.anim.imgActuelle = 0
        end
        if Hero.anim.imgActuelle >= Hero.anim.nbImgAttack then
            Hero.anim.imgActuelle = 0
        end
    else
        Hero.anim.imgActuelle = 0
    end
   

end

Hero.update = function(dt)
    updateHeroAnim(dt)
end

local function drawHeroAnim()
    local directions = {
        moveUp = Hero.anim.moveUp,
        moveDown = Hero.anim.moveDown,
        moveLeft = Hero.anim.moveLeft,
        moveRight = Hero.anim.moveRight,
        
    }
    local attacks = {
        attackUp = Hero.anim.attackUp,
        attackDown = Hero.anim.attackDown,
        attackLeft = Hero.anim.attackLeft,
        attackRight = Hero.anim.attackRight,
    }

    local x = Hero.anim.x + Camera_x
    local y = Hero.anim.y + Camera_y


    if love.keyboard.isDown("e") then
        -- code with love by Vladislav razyvika
        -- cé mwa ki lé fé
        if lastPos == "moveUp" or lastPos == "moveDown" or lastPos == "moveLeft" or lastPos == "moveRight"  then 
            love.graphics.draw(Hero.anim.img, attacks[Hero.anim.attack][math.floor(Hero.anim.imgActuelle)+1], x, y)

        end
    else
    
        love.graphics.draw(Hero.anim.img, directions[Hero.anim.direction][math.floor(Hero.anim.imgActuelle)+1], x, y)
    end
end


Hero.draw = function()
    drawHeroAnim()
end

return Hero