local Hero = {}

Hero.animation = {
    up = {},
    down = {},
    left = {},
    right = {}
  }
  Hero.animation.x = 0
  Hero.animation.y = 0









Hero.load = function()
    Hero.animation.img = love.graphics.newImage("images/hero.png")

    -- Chargement des quads pour les différentes directions
    local directions = {"up", "left", "down", "right"}

    for i, direction in ipairs(directions) do
        for j = 0, 9 do
            Hero.animation[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+7), 64, 64, Hero.animation.img)
        end
    end
    Hero.animation.nbImg = 9
    Hero.animation.imgActuelle = 0
    Hero.animation.direction = "down"
end



Hero.update = function(dt)
    if love.keyboard.isDown("up") then
        Hero.animation.direction = "up"
        Hero.animation.y = Hero.animation.y - 100 * dt

    elseif love.keyboard.isDown("down") then
        Hero.animation.direction = "down"
        Hero.animation.y = Hero.animation.y + 100 * dt

    elseif love.keyboard.isDown("left") then
        Hero.animation.direction = "left"
        Hero.animation.x = Hero.animation.x - 100 * dt
        
    elseif love.keyboard.isDown("right") then
        Hero.animation.direction = "right"
        Hero.animation.x = Hero.animation.x + 100 * dt
    end

    Hero.animation.imgActuelle = Hero.animation.imgActuelle + Hero.animation.nbImg * dt
    if Hero.animation.imgActuelle >= Hero.animation.nbImg then
        Hero.animation.imgActuelle = 0
    end
end



Hero.draw = function()
    local directions = {
        up = Hero.animation.up,
        down = Hero.animation.down,
        left = Hero.animation.left,
        right = Hero.animation.right
      }
      
    love.graphics.draw(Hero.animation.img, directions[Hero.animation.direction][math.floor(Hero.animation.imgActuelle)+1], Hero.animation.x+Camera_x, Hero.animation.y+Camera_y)
end








return Hero