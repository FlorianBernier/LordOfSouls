local Setting = {}
--colisionPointRect : detecte la colision entre un point x,y et un rectangle 
function Collide_P_R(x1,y1,x2,y2,w,h)
    return x1 > x2 and x1 < x2 + w and y1 > y2 and y1 < y2 + h
end
--DistanceDeuxPoints : detecte la distance entre 2 points 
function Dist_P_P(x1,y1,x2,y2)
    return math.sqrt( math.abs(x1 - x2) * math.abs(x1 - x2)  + math.abs(y1 - y2) * math.abs(y1 - y2) )
end
--- --- --- --- --- --- --- --- --- --- --- --- ---
--sets up pixel art
love.graphics.setDefaultFilter("nearest")
--sets up fullScreen variables
love.window.setFullscreen(false)
SetFullScreen = false
--sets up scale variables
Scale_x = 1 Scale_y = 1
--sets up mouse variables
Mouse_x = 0 Mouse_y = 0
--sets up camera variables Camera_y = -1500
Camera_x = 0 Camera_y = -1600 Camera_speed = 0
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
    Screen_Width = love.graphics.getWidth()
    Screen_Height = love.graphics.getHeight()
end


--déplacement de la camera
local function MoveCamera(dt)
    local x, y = love.mouse.getPosition()
    if (SetFullScreen) then
        x = x / Scale_x
        y = y / Scale_y
    end
    if love.mouse.isDown(3) then
        if x < Screen_Width/3 then Camera_x = Camera_x + Camera_speed * dt end
        if x > Screen_Width/3 + Screen_Width/3 then Camera_x = Camera_x - Camera_speed * dt end
        if y < Screen_Height/3 then Camera_y = Camera_y + Camera_speed * dt end
        if y > Screen_Height/3 + Screen_Height/3 then Camera_y = Camera_y - Camera_speed * dt end
    else
        if x < 5 then Camera_x = Camera_x + Camera_speed * dt end
        if x > 795 then Camera_x = Camera_x - Camera_speed * dt end
        if y < 5 then Camera_y = Camera_y + Camera_speed * dt end
        if y > 595 then Camera_y = Camera_y - Camera_speed * dt end
    end
end

Setting.update = function(dt)
    Mouse_x = (love.mouse.getX() / Scale_x - Window.translate.x) / Window.zoom - Camera_x
    Mouse_y = (love.mouse.getY() / Scale_y - Window.translate.y) / Window.zoom - Camera_y
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
        load_full_screen()
    end
    if (key == "f2") then
        love.window.setFullscreen(true)
        SetFullScreen = true
        load_full_screen()
    end
    if (key == "f3") then
        love.event.quit()
    end
end

Setting.keypressed = function(key)
    keypressed_key(key)
    print(key)
end


--affiche position souris dans la console
local function mousepressed_get_pos()
    print(love.mouse.getPosition())
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