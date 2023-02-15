local Hero = {}

Hero.speed = 100

Hero.animation = {
    moveup = {}, movedown = {}, moveleft = {}, moveright = {}
}
Hero.animation.x = 0
Hero.animation.y = 0
Hero.animation.img = love.graphics.newImage("images/hero.png")


--- --- --- --- --- --- 

local function loadQuad()
    local directions = {"moveup", "moveleft", "movedown", "moveright"}
    for i, direction in ipairs(directions) do
        for j = 0, 9 do
            Hero.animation[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+7), 64, 64, Hero.animation.img)
        end
    end
    Hero.animation.nbImg = 9
    Hero.animation.imgActuelle = 0
    Hero.animation.direction = "movedown"
end

Hero.load = function()
    loadQuad()
end

local function updateHeroAnim(dt)
    if love.keyboard.isDown("up") then
        Hero.animation.direction = "moveup"
        Hero.animation.y = Hero.animation.y - 100 * dt

    elseif love.keyboard.isDown("down") then
        Hero.animation.direction = "movedown"
        Hero.animation.y = Hero.animation.y + 100 * dt

    elseif love.keyboard.isDown("left") then
        Hero.animation.direction = "moveleft"
        Hero.animation.x = Hero.animation.x - 100 * dt
        
    elseif love.keyboard.isDown("right") then
        Hero.animation.direction = "moveright"
        Hero.animation.x = Hero.animation.x + 100 * dt
    end

    
    if not love.keyboard.isDown("up") and not love.keyboard.isDown("down") and not love.keyboard.isDown("left") and not love.keyboard.isDown("right") then
        Hero.animation.imgActuelle = 0
        
    else
    Hero.animation.imgActuelle = Hero.animation.imgActuelle + Hero.animation.nbImg * dt
        if Hero.animation.imgActuelle >= Hero.animation.nbImg then
            Hero.animation.imgActuelle = 0
        end
    end
end


Hero.update = function(dt)
    updateHeroAnim(dt)
end

local function drawHeroAnim()
    local directions = {
        moveup = Hero.animation.moveup,
        movedown = Hero.animation.movedown,
        moveleft = Hero.animation.moveleft,
        moveright = Hero.animation.moveright
      }
      
    love.graphics.draw(Hero.animation.img, directions[Hero.animation.direction][math.floor(Hero.animation.imgActuelle)+1], Hero.animation.x+Camera_x, Hero.animation.y+Camera_y)
end

Hero.draw = function()
    drawHeroAnim()
end


return Hero