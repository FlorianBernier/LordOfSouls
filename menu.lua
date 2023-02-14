local Menu = {}

Menu.border = {
    {x = 0, y = 0, w = 35, h = 600,},
    {x = 765, y = 0, w = 35, h = 600}
}


Menu.Btn = {
{x = 2, y = 19, w = 31, h = 38, name = "Retour jeu", img = love.graphics.newImage("images/btnBorder/1.png")}, --1
{x = 2, y = 59, w = 31, h = 38, name = "Carte", img = love.graphics.newImage("images/btnBorder/2.png")}, --2
{x = 2, y = 99, w = 31, h = 38, name = "Quete", img = love.graphics.newImage("images/btnBorder/3.png")}, --3
{x = 2, y = 139, w = 31, h = 38, name = "Inventaire", img = love.graphics.newImage("images/btnBorder/4.png")}, --4
{x = 2, y = 179, w = 31, h = 38, name = "Stat", img = love.graphics.newImage("images/btnBorder/5.png")}, --5
{x = 2, y = 219, w = 31, h = 38, name = "Sort \nprofane", img = love.graphics.newImage("images/btnBorder/6.png")}, --6
{x = 2, y = 259, w = 31, h = 38, name = "Sort divin", img = love.graphics.newImage("images/btnBorder/7.png")}, --7
{x = 2, y = 299, w = 31, h = 38, name = "option", img = love.graphics.newImage("images/btnBorder/8.png")}, --8
{x = 2, y = 399, w = 31, h = 38, name = "Aide", img = love.graphics.newImage("images/btnBorder/9.png")}, --9
{x = 2, y = 439, w = 31, h = 38, name = "Sauvegarde", img = love.graphics.newImage("images/btnBorder/10.png")}, --10
{x = 2, y =  479, w = 31, h = 38, name = "Repos", img = love.graphics.newImage("images/btnBorder/11.png")}, --11
{x = 2, y =  539, w = 31, h = 38, name = "Pause", img = love.graphics.newImage("images/btnBorder/12.png")}, --12

{x = 767, y = 19, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/13.png")}, --13
{x = 767, y = 79, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/14.png")}, --14
{x = 767, y = 139, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/15.png")}, --15
{x = 767, y = 199, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/16.png")}, --16
{x = 767, y = 259, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/17.png")}, --17
{x = 767, y = 319, w = 31, h = 57, name = "Perso", img = love.graphics.newImage("images/btnBorder/18.png")}, --18
{x = 767, y = 419, w = 31, h = 38, name = "Pass", img = love.graphics.newImage("images/btnBorder/19.png")}, --19
{x = 767, y = 459, w = 31, h = 38, name = "détail", img = love.graphics.newImage("images/btnBorder/20.png")}, --20
{x = 767, y = 499, w = 31, h = 38, name = "IA grp", img = love.graphics.newImage("images/btnBorder/21.png")}, --21
{x = 767, y = 539, w = 31, h = 38, name = "Sélect \nperso", img = love.graphics.newImage("images/btnBorder/22.png")}, --22
}


Menu.load = function()
end


Menu.update = function(dt)
end

local function drawBorder()
    love.graphics.setColor(0.2,0.2,0.2)
    for i = 1, #Menu.border do
        local b = Menu.border[i]
        love.graphics.rectangle("fill", b.x, b.y, b.w, b.h)
    end
    love.graphics.setColor(1,1,1)
end

local function drawBtnImg()
    for i = 1, #Menu.Btn do
        local b = Menu.Btn[i]
        love.graphics.rectangle("line", b.x, b.y, b.w, b.h)
        if i >= 13 and i <= 18 then
            love.graphics.draw(b.img, b.x, b.y, 0, b.w / b.img:getWidth(), b.h /b.img:getHeight())
        else
            love.graphics.draw(b.img, b.x, b.y, 0, b.w / b.img:getWidth(), b.h /b.img:getHeight())
        end
    end
end

Menu.draw = function()
    drawBorder()
    drawBtnImg()
end


return Menu