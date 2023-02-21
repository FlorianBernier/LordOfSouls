local Setting = {}


--sets up pixel art
love.graphics.setDefaultFilter("nearest")
--sets up fullScreen variables
love.window.setFullscreen(false)
SetFullScreen = false
Scale_x = 1
Scale_y = 1
MOUSE_X = 0
MOUSE_Y = 0
--sets up camera variables
Camera_x = 0 Camera_y = 0 Camera_speed = 300
--sets up window variables
Window = {translate={x=0, y=0}, zoom=1}
Dscale = 2^(1/6) -- six times wheel movement changes the zoom twice; exponential zoom only

--- --- --- --- --- --- --- --- --- --- --- --- ---

--chargement fullScreen
local function load_full_screen()
    if (SetFullScreen) then
        Screen_w, Screen_h = love.window.getMode()
        Scale_x = Screen_w / 800
        Scale_y = Screen_h / 600
    else
        Scale_x = 1
        Scale_y = 1
    end
end

Setting.load = function()
    load_full_screen()
    ScreenWidth = love.graphics.getWidth()  --larg
    ScreenHeight = love.graphics.getHeight()  --haut
end


--déplacement de la camera
local function MoveCamera(dt)
    local x, y = love.mouse.getPosition()
    if (SetFullScreen) then
        x = x / Scale_x
        y = y / Scale_y
        --print("fullscreen return")
    end
    if love.mouse.isDown(3) then
        if x < ScreenWidth/3 then Camera_x = Camera_x + Camera_speed * dt end
        if x > ScreenWidth/3 + ScreenWidth/3 then Camera_x = Camera_x - Camera_speed * dt end
        if y < ScreenHeight/3 then Camera_y = Camera_y + Camera_speed * dt end
        if y > ScreenHeight/3 + ScreenHeight/3 then Camera_y = Camera_y - Camera_speed * dt end
    else
        if x < 5 then Camera_x = Camera_x + Camera_speed * dt end
        if x > 795 then Camera_x = Camera_x - Camera_speed * dt end
        if y < 5 then Camera_y = Camera_y + Camera_speed * dt end
        if y > 595 then Camera_y = Camera_y - Camera_speed * dt end
    end
end



Setting.update = function(dt)
    MOUSE_X = (love.mouse.getX() / Scale_x - Window.translate.x) / Window.zoom - Camera_x
    MOUSE_Y = (love.mouse.getY() / Scale_y - Window.translate.y) / Window.zoom - Camera_y
    MoveCamera(dt)
end


--scale fullScreen
local function draw_full_screen()
    if (SetFullScreen) then love.graphics.scale(Scale_x,Scale_y) end
end

--affichage du zoom
local function draw_Zoom_Camera()
	love.graphics.translate(Window.translate.x, Window.translate.y)
	love.graphics.scale(Window.zoom)
end

Setting.draw = function()
    draw_full_screen()
    draw_Zoom_Camera()
end


--key dimension screen et quit
local function keypressed_key(key)
    if (key == "f1") then
        love.window.setFullscreen(false)
        SetFullScreen = false
        --print(SetFullScreen)
        load_full_screen()
    end
    if (key == "f2") then
        love.window.setFullscreen(true)
        SetFullScreen = true
        --print(SetFullScreen)
        load_full_screen()
    end
    if (key == "f3") then
        love.event.quit()
    end
end

Setting.keypressed = function(key)
    keypressed_key(key)
    --print(key)
end


--affiche position souris dans la console
local function mousepressed_get_pos()
    if love.mouse.isDown(1,2,3) then
        --print(love.mouse.getPosition())
    end
end

Setting.mousepressed = function()
    mousepressed_get_pos()
end


-- zoom de la camera avec molette de la souris
local function ZoomCamera(x, y)
    if not (y == 0) then
		local mouse_x = love.mouse.getX() / Scale_x - Window.translate.x
		local mouse_y = love.mouse.getY() / Scale_y - Window.translate.y
        local k = Dscale^y
		Window.zoom = Window.zoom*k
		Window.translate.x = math.floor(Window.translate.x + mouse_x*(1-k))
		Window.translate.y = math.floor(Window.translate.y + mouse_y*(1-k))
    end
end

function Setting.wheelmoved(x, y)
    ZoomCamera(x, y)
end


return Setting