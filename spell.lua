local Spell = {}
local listeSpell = {}

local CONST = {
    type = {fire = "fire", midnight = "midnight"},
    fire = {},
    midnight = {}
}

Spell.fire = love.graphics.newImage("images/spell/fire.png")
Spell.midnight = love.graphics.newImage("images/spell/midnight.png")

function CreateSpell(pX1, pY1, pX2, pY2, pSpell)
    local newSpell = {x1 = pX1, y1 = pY1, x2 = pX2, y2 = pY2, spell = pSpell}
    table.insert(listeSpell, newSpell)
end

--- --- --- --- --- ---

local function loadQuad()
    CONST.fire.quad = {}
    for i = 0, 7 do -- Boucle à travers chaque ligne de quads
        for j = 0, 7 do -- Boucle à travers chaque colonne de quads
            CONST.fire.quad = love.graphics.newQuad(j * 100, i * 100, 100, 100, Spell.fire:getDimensions())
        end
    end
end



Spell.load = function()
    loadQuad()
end

Spell.update = function(dt)
end


Spell.draw = function()
end


Spell.keypressed = function(key)
    if key == "e" then
        CreateSpell(0, 0, 100, 100, CONST.fire.quad)
    end
end


Spell.mousepressed = function()
end


return Spell