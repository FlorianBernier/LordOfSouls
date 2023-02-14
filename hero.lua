local Hero = {}

Hero.list = {}

Hero.create = function (pPvMax, pImg, pNom, pX, pY)
    newHero = {
        pvMax = pPvMax, -- Pv max
        pv = pPvMax, -- Pv actuel
        img = pImg, -- Image 
        nom = pNom, -- Nom 
        x = pX, -- Position X
        y = pY, -- Position Y
        isSelected = false, -- Es selectionner (faux)
        radius = 10,  -- Taille du perso
        -- Destination (variable concernant le deplacement d'un personnage jusqu'a son point d'arriver)
        ox = 0, -- Destination x
        oy = 0, -- Destination y
        oa = true -- Arriver a destination (vrais)
    }

    -- sert a ne pas créé plus de 6 Hero max
    if #Hero.list < 6 then
        table.insert(Hero.list, newHero)
    end
end

mouseSelect = {
    x = 0,
    y = 0,
    long = 0,
    larg = 0,
    isDown = false
}



animation = {
    img = love.graphics.newImage("images/luffy.png"),
    img2 = love.graphics.newImage("images/sangoku.png"),
    img3 = love.graphics.newImage("images/sandy.png"),
    img4 = love.graphics.newImage("images/usopp.png"),
    img5 = love.graphics.newImage("images/robine.png"),
    img6 = love.graphics.newImage("images/nami.png")

}

-- updateGreenSquare : permet de selectionner 1 ou plusieur personnage avec le clic gauche de la souris en restant appuyer puis en relachant
function updateGreenSquare()

    local x, y = love.mouse.getPosition()
    if (SetFullScreen) then
        x = x / Scale_x
        y = y / Scale_y
    end


    if love.mouse.isDown(1) then
        mouseSelect.long = x - mouseSelect.x
        mouseSelect.larg = y - mouseSelect.y
    else
        -- On relache
        if mouseSelect.isDown == true then
            for i = 1, #Hero.list do
                local h = Hero.list[i]
                local m = mouseSelect
                h.isSelected = Collide_P_R( 
                    h.x + Camera_x, 
                    h.y + Camera_y, 
                    (m.long < 0 and m.x + m.long or m.x)-h.radius,
                    (m.larg < 0 and m.y + m.larg or m.y)-h.radius,
                    math.abs(m.long)+h.radius*2,
                    math.abs(m.larg)+h.radius*2
                ) 
            end
            
        end
        mouseSelect.isDown = false
    end

end

-- updatMoveHero : permet de deplacer 1 ou plusieur personnage avec le clic droit de la souris
function updatMoveHero(dt)

    -- deplacement des personnage
    local x, y = love.mouse.getPosition()
    if (SetFullScreen) then
        x = x / Scale_x
        y = y / Scale_y
    end
    x = x - Camera_x
    y = y - Camera_y


    local vitesse = 300

    local noSelection = 0
    for i = 1, #Hero.list do
        local h = Hero.list[i]
        if h.isSelected then noSelection = noSelection + 1 end 

        
            if h.oa == false then
                local dist = Dist_P_P(h.ox, h.oy, h.x, h.y)
                if dist > 3 then
                    local old_x = h.x
                    local old_y = h.y

                    h.x = h.x + (h.ox - h.x) / dist * vitesse * dt
                    h.y = h.y + (h.oy - h.y) / dist * vitesse * dt

                else
                    h.oa = true
                end
            end
        
    end
end

------FONCTION DRAW------

--dessine les Hero et entour d'un cercle vert le Hero sélectionner
local function drawHeroHeroSelect()
    for i = 1, #Hero.list do
        local h = Hero.list[i]

        love.graphics.circle("fill",h.x + Camera_x, h.y  + Camera_y, h.radius)
        love.graphics.setColor(0,1,0)

        if h.isSelected then
            love.graphics.circle("line",h.x + Camera_x,h.y + Camera_y,11)
        end

        love.graphics.setColor(1,1,1)
    end
end

-- dessine le rectangle de selection de peronnage
function drawGreenSquare()
    if mouseSelect.isDown == true then
        love.graphics.setColor(0,1,0)
        love.graphics.rectangle("line", mouseSelect.x, mouseSelect.y, mouseSelect.long, mouseSelect.larg)
        love.graphics.setColor(1,1,1)            
    end
end

-- dessine un cercle vert qui represente la destination des Hero
function drawGreenCircle()
    for i = 1, #Hero.list do
        local h = Hero.list[i]
        if not h.oa then
            love.graphics.setColor(0,1,0)
            love.graphics.circle("line",h.ox + Camera_x, h.oy + Camera_y, h.radius)            
            love.graphics.setColor(1,1,1)
        end
    end
end

Hero.load = function()
    animation.quad = {}
    for i = 0, 6 do
        animation.quad[i+1] = love.graphics.newQuad(i * 64,448 - 64,64,64, animation.img)

    end
    animation.nbImg = 6
    animation.imgActuelle = 0
end



Hero.update = function(dt)
    animation.imgActuelle = animation.imgActuelle + animation.nbImg * dt
    if animation.imgActuelle >= animation.nbImg then
        animation.imgActuelle = 0
    end

    updateGreenSquare()
    updatMoveHero(dt)
end



Hero.draw = function()
    drawHeroHeroSelect()
    drawGreenSquare()
    drawGreenCircle()

    love.graphics.draw(animation.img, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[1].x + Camera_x - 32,Hero.list[1].y + Camera_y - 64)
    love.graphics.draw(animation.img2, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[2].x + Camera_x - 32,Hero.list[2].y + Camera_y - 64)
    love.graphics.draw(animation.img3, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[3].x + Camera_x - 32,Hero.list[3].y + Camera_y - 64)
    love.graphics.draw(animation.img4, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[4].x + Camera_x - 32,Hero.list[4].y + Camera_y - 64)
    love.graphics.draw(animation.img5, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[5].x + Camera_x - 32,Hero.list[5].y + Camera_y - 64)
    love.graphics.draw(animation.img6, animation.quad[math.floor(animation.imgActuelle)+1  ],Hero.list[6].x + Camera_x - 32,Hero.list[6].y + Camera_y - 64)
end

-----AUTRE FONCTION--------- : ?
--selectionne un Hero a partir de la liste de Hero iconeHero
Hero.selectHero = function (HeroId)
    for i = 1, #Hero.list do
        local h = Hero.list[i]
        h.isSelected = false
    end
    if HeroId > 0 and HeroId <= #Hero.list then
        Hero.list[HeroId].isSelected = true
    end
end


Hero.selectAllHero = function()
    for i = 1, #Hero.list do
        local h = Hero.list[i]
        h.isSelected = true
    end
end

return Hero