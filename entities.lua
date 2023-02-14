local Entities = {}

Entities.animation = {
    up = {},
    down = {},
    left = {},
    right = {}
  }
  Entities.animation.x = 0
  Entities.animation.y = 0









Entities.load = function()
    Entities.animation.img = love.graphics.newImage("images/hero.png")

    -- Chargement des quads pour les différentes directions
    local directions = {"up", "left", "down", "right"}

    for i, direction in ipairs(directions) do
        for j = 0, 9 do
            Entities.animation[direction][j+1] = love.graphics.newQuad(j * 64, 64 * (i+7), 64, 64, Entities.animation.img)
        end
    end
    Entities.animation.nbImg = 9
    Entities.animation.imgActuelle = 0
    Entities.animation.direction = "down"
end



Entities.update = function(dt)
    if love.keyboard.isDown("up") then
        Entities.animation.direction = "up"
        Entities.animation.y = Entities.animation.y - 100 * dt

    elseif love.keyboard.isDown("down") then
        Entities.animation.direction = "down"
        Entities.animation.y = Entities.animation.y + 100 * dt

    elseif love.keyboard.isDown("left") then
        Entities.animation.direction = "left"
        Entities.animation.x = Entities.animation.x - 100 * dt
        
    elseif love.keyboard.isDown("right") then
        Entities.animation.direction = "right"
        Entities.animation.x = Entities.animation.x + 100 * dt
    end

    Entities.animation.imgActuelle = Entities.animation.imgActuelle + Entities.animation.nbImg * dt
    if Entities.animation.imgActuelle >= Entities.animation.nbImg then
        Entities.animation.imgActuelle = 0
    end
end



Entities.draw = function()
    local directions = {
        up = Entities.animation.up,
        down = Entities.animation.down,
        left = Entities.animation.left,
        right = Entities.animation.right
      }
      
    love.graphics.draw(Entities.animation.img, directions[Entities.animation.direction][math.floor(Entities.animation.imgActuelle)+1], Entities.animation.x+Camera_x, Entities.animation.y+Camera_y)
end








return Entities