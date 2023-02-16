local Spell = {}

Spell.anim = {
}
Spell.anim.life = love.graphics.newImage("images/spell/fire.png")
Spell.anim.fire = love.graphics.newImage("images/spell/midnight.png")


Spell.anim.currentQuad = 1
Spell.anim.currentTime = 0
Spell.anim.frameDuration = 0.05

Spell.anim.showAnim = false
Spell.anim.showAnim2 = false
Spell.anim.x = 0
Spell.anim.y = 0

--- --- --- --- --- ---

local function loadQuad()
    local quads = {} -- Tableau pour stocker tous les quads
    for i = 0, 7 do -- Boucle à travers chaque ligne de quads
        for j = 0, 7 do -- Boucle à travers chaque colonne de quads
            local quad = love.graphics.newQuad(j * 100, i * 100, 100, 100, Spell.anim.life:getDimensions())
            table.insert(quads, quad) -- Ajouter le quad actuel à la table
        end
    end
    for i = 0, 7 do -- Boucle à travers chaque ligne de quads
        for j = 0, 7 do -- Boucle à travers chaque colonne de quads
            local quad = love.graphics.newQuad(j * 100, i * 100, 100, 100, Spell.anim.fire:getDimensions())
            table.insert(quads, quad) -- Ajouter le quad actuel à la table
        end
    end
    Spell.anim.quads = quads -- Stocker tous les quads dans l'objet Spell
end

Spell.load = function()
    loadQuad()
end


local function updateSpellAnim(dt)
    if Spell.anim.showAnim or Spell.anim.showAnim2  then
        Spell.anim.currentTime = Spell.anim.currentTime + dt
        if Spell.anim.currentTime >= Spell.anim.frameDuration then
            Spell.anim.currentTime = Spell.anim.currentTime - Spell.anim.frameDuration
            Spell.anim.currentQuad = Spell.anim.currentQuad + 1
            if Spell.anim.currentQuad > 64-3 then
                Spell.anim.currentQuad = 1
                --table.remove(Spell.anim.quads, Spell.anim.currentTime)
                Spell.anim.showAnim = false
            end
        end
        -- Déplacer le sort vers la position de la souris
        local mx, my = love.mouse.getPosition()
        local dx = mx - Spell.anim.x
        local dy = my - Spell.anim.y
        local angle = math.atan2(dy, dx)
        local speed = 300
        if Spell.anim.fire then
            Spell.anim.x = Spell.anim.x + math.cos(angle) * speed * dt
            Spell.anim.y = Spell.anim.y + math.sin(angle) * speed * dt
        end
    end
end


Spell.update = function(dt)
    updateSpellAnim(dt)
end


Spell.draw = function()
    if Spell.anim.showAnim then
        local currentQuad = Spell.anim.quads[Spell.anim.currentQuad]
        love.graphics.draw(Spell.anim.life, currentQuad, Spell.anim.x+Camera_x, Spell.anim.y+Camera_y)
    end
    if Spell.anim.showAnim2 then
        local currentQuad = Spell.anim.quads[Spell.anim.currentQuad]
        love.graphics.draw(Spell.anim.fire, currentQuad, Spell.anim.x+Camera_x, Spell.anim.y+Camera_y)
    end
end


Spell.keypressed = function(key)
    if key == "e" then
        Spell.anim.showAnim = true
        Spell.anim.currentTime = 0
        Spell.anim.currentQuad = 1
        --Spell.anim.x, Spell.anim.y = love.mouse.getPosition()
    end
    if key == "a" then
        Spell.anim.showAnim2 = true
        Spell.anim.currentTime = 0
        Spell.anim.currentQuad = 1
        --Spell.anim.x, Spell.anim.y = love.mouse.getPosition()
    end
end


Spell.mousepressed = function()
end


return Spell