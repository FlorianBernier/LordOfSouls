local Hero = {}

Hero.speed = 100

Hero.anim = {
    moveUp = {}, moveDown = {}, moveLeft = {}, moveRight = {},
    attack1Up = {},  attack1Down = {}, attack1Left = {}, attack1Right = {}
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
    local directions = {"attack1Up", "attack1Left", "attack1Down", "attack1Right"}
    for i, direction in ipairs(directions) do
        for j = 0, 8 do
            Hero.anim[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+3), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImg = 9
    Hero.anim.imgActuelle = 0
    Hero.anim.direction = "moveDown"
end

local function loadAttackQuad()
    local directions = {"attack1Up", "attack1Left", "attack1Down", "attack1Right"}
    for i, direction in ipairs(directions) do
        for j = 0, 8 do
            Hero.anim[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+3), 64, 64, Hero.anim.img)
        end
    end
    Hero.anim.nbImg = 9
    Hero.anim.imgActuelle = 0
    Hero.anim.direction = "attack1Down"
end

Hero.load = function()
    loadQuad()
    --loadAttackQuad()
end

local function updateHeroAnim(dt)
    local isMoving = false
    
    if love.keyboard.isDown("z") then
        Hero.anim.direction = "moveUp"
        Hero.anim.y = Hero.anim.y - Hero.speed * dt
        isMoving = true

    elseif love.keyboard.isDown("s") then
        Hero.anim.direction = "moveDown"
        Hero.anim.y = Hero.anim.y + Hero.speed * dt
        isMoving = true

    elseif love.keyboard.isDown("q") then
        Hero.anim.direction = "moveLeft"
        Hero.anim.x = Hero.anim.x - Hero.speed * dt
        isMoving = true
        
    elseif love.keyboard.isDown("d") then
        Hero.anim.direction = "moveRight"
        Hero.anim.x = Hero.anim.x + Hero.speed * dt
        isMoving = true
    end

    if isMoving then
        Hero.anim.imgActuelle = Hero.anim.imgActuelle + Hero.anim.nbImg * dt
        if Hero.anim.imgActuelle >= Hero.anim.nbImg then
            Hero.anim.imgActuelle = 0
        end
    else
        Hero.anim.imgActuelle = 0
    end
    
    if love.keyboard.isDown("e") then
        if Hero.anim.direction == "moveUp" then
            Hero.anim.direction = "moveDown"
        elseif Hero.anim.direction == "moveDown" then
            Hero.anim.direction = "attack1Down"
        elseif Hero.anim.direction == "moveLeft" then
            Hero.anim.direction = "attack1Left"
        elseif Hero.anim.direction == "moveRight" then
            Hero.anim.direction = "attack1Right"
        end
        
        Hero.anim.imgActuelle = Hero.anim.imgActuelle + Hero.anim.nbImg * dt
        if Hero.anim.imgActuelle >= Hero.anim.nbImg then
            Hero.anim.imgActuelle = 0
        end
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
        attack1Up = Hero.anim.attack1Up,
        attack1Down = Hero.anim.attack1Down,
        attack1Left = Hero.anim.attack1Left,
        attack1Right = Hero.anim.attack1Right
    }

    local x = Hero.anim.x + Camera_x
    local y = Hero.anim.y + Camera_y

    if love.keyboard.isDown("e") then
        -- Afficher l'animation d'attaque en fonction de la direction du personnage
        if Hero.anim.direction == "moveUp" then
            love.graphics.draw(Hero.anim.img, directions.attack1Up[math.floor(Hero.anim.imgActuelle)+1], x, y)
        elseif Hero.anim.direction == "moveDown" then
            love.graphics.draw(Hero.anim.img, directions.attack1Down[math.floor(Hero.anim.imgActuelle)+1], x, y)
        elseif Hero.anim.direction == "moveLeft" then
            love.graphics.draw(Hero.anim.img, directions.attack1Left[math.floor(Hero.anim.imgActuelle)+1], x, y)
        elseif Hero.anim.direction == "moveRight" then
            love.graphics.draw(Hero.anim.img, directions.attack1Right[math.floor(Hero.anim.imgActuelle)+1], x, y)
        end
    else
        -- Afficher l'animation de déplacement en fonction de la direction du personnage
        love.graphics.draw(Hero.anim.img, directions[Hero.anim.direction][math.floor(Hero.anim.imgActuelle)+1], x, y)
    end
end

Hero.draw = function()
    drawHeroAnim()
end

return Hero