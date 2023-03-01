Setting = require("setting")
local text = {
    "Les yeux soudain ouverts,",
    "vous découvrez un monde étrange et sombre.",
    "Tout est flou et obscur,",
    "mais une présence sinistre vous observe.",
    "Elle se cache dans l'obscurité, tapie dans l'ombre",
    "mais vous pouvez la sentir. Vous ressentez",
    "une pression dans l'air, comme une menace qui plane.",
    "Vous ne savez pas comment vous êtes arrivé ici,",
    "ni pourquoi cette ombre vous suit.",
    "Vous commencez à explorer votre environnement,",
    "en essayant de trouver des réponses.",
    "Mais plus vous avancez,",
    " plus l'ombre semble vous suivre.",
    " Vous pouvez la voir parfois,",
    "un reflet rapide dans le coin de l'œil,",
    " ou un mouvement furtif dans l'obscurité.",
    "Elle ne vous attaque pas, mais elle semble attendre",
    " quelque chose.",
    "Au fur et à mesure que vous avancez,",
    " vous remarquez des signes étranges dans",
    "l'environnement qui vous entoure.",
    " Des traces de lutte, des objets abandonnés,",
    " et même des cadavres.",
    "Vous ne savez pas qui sont ces personnes,",
    " ni comment elles sont arrivées ici. Mais vous sentez",
    "que leur présence a quelque chose à voir",
    "avec votre propre situation.",
    "L'ombre vous suit toujours, et vous commencez à avoir",
    "l'impression qu'elle vous observe de plus",
    "en plus étroitement. Vous pouvez sentir son souffle",
    "sur votre nuque, ou entendre ses murmures dans",
    "l'obscurité. Vous ne savez pas si elle est là pour",
    "vous protéger ou pour vous nuire, mais vous ne",
    "pouvez pas vous en débarrasser.",
    "Vous sentez la pression s'intensifier dans l'air",
    "autour de vous. L'ombre, qui vous a suivie tout ce temps,",
    "se rapproche encore un peu plus.",
    " Chaque battement de votre cœur résonne dans vos oreilles.",
    " La peur vous envahit,",
    "et vous essayez de vous convaincre que tout",
    "cela n'est qu'un cauchemar. Mais l'ombre est là,",
    " vous pouvez la sentir,",
    "la distinguer plus clairement, elle vous observe fixement.",
    " Vous cherchez désespérément une issue,",
    " mais vous êtes piégé dans",
    "cet environnement sombre et inconnu.",
    " Soudain, l'atmosphère devient insurmontable,",
    " vous avez l'impression que quelque",
    "chose va vous arriver. Votre corps tout entier est",
    "parcouru de frissons. Vous vous réveillez en sursaut!",
    "Vous êtes désorienté, allongé sur une plage sombre et",
    "lugubre, entouré de brume.",
    "",
    "Immédiatement vous comprenez que ce n'était pas un rêve..."
  }
  local font = love.graphics.newFont(25)
  local fontGame = love.graphics.newFont(15)
  local line_height = font:getHeight()

  -- position initiale
  local yTexte = 2200







--- --- --- --- --- --- --- --- --- --- --- --- ---
local sndIntro = love.audio.newSource("sons/introLordOfSouls.wav", "static")
local img = love.graphics.newImage("images/lord.png")

local MyGame = require("game")

love.load = function()
    love.audio.play(sndIntro)
    Setting.load()
    --- --- ---
    MyGame.load()
end

love.update = function(dt)
    Setting.update(dt)
    --- --- ---
    MyGame.update(dt)

    yTexte = yTexte - 12.5 * dt
    if yTexte + line_height < 1900 then
        table.remove(text, 1)
        yTexte = yTexte + line_height
    end

end

love.draw = function()
    Setting.draw()
    --- --- ---
    MyGame.draw()
    love.graphics.draw(img, 0+Camera_x, 1600+Camera_y, 0, 0.6, 0.6)

    love.graphics.setFont(font)
    for i, line in ipairs(text) do
        love.graphics.print(line, 100+Camera_x, yTexte + (i-1) * line_height+Camera_y)
    end
    love.graphics.setFont(fontGame) 
end

love.keypressed = function(key)
    Setting.keypressed(key)
    --- --- ---
    MyGame.keypressed(key)
    if key == "escape" then
        love.audio.stop(sndIntro)
        Camera_x = 0
        Camera_y = -1000
        Camera_speed = 300
    end
end

love.mousepressed = function(x, y, button)
    Setting.mousepressed()
    --- --- ---
    MyGame.mousepressed(x, y, button)
    
end


function love.wheelmoved(x, y)
    Setting.wheelmoved(x,y)
    --- --- ---

end