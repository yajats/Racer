wwidth = 1600
wheight = 900


vwidth = 432
vheight = 243


carspeed1 = 0.5
carspeed2 = 0.5

Class = require 'class'
push = require 'push'


p1x = 50
p1y = vheight / 4 - 20
p2x = 50
p2y = vheight - (vheight*0.25)



 
function love.load()

  
    love.graphics.setDefaultFilter('nearest', 'nearest')

    
    love.window.setTitle('Racer')

   
    smallfont = love.graphics.newFont('font.ttf', 8)
    titlefont = love.graphics.newFont('Inlanders Demo.ttf', 24)
    scorefont = love.graphics.newFont('font.ttf', 32)
    

  
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    
    
    
   
    
    
    gamestate = 'start'
    
    push:setupScreen(vwidth, vheight, wwidth, wheight, {
        fullscreen = false,
        vsync = true, 
        resizable = true
    })
end

function love.keyboard.wasPressed(key)
    if (love.keyboard.keysPressed[key]) then
        return true
    else
        return false
    end
end


function love.keyboard.wasReleased(key)
    if (love.keyboard.keysReleased[key]) then
        return true
    else
        return false
    end
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'enter' or key == 'return' then
        if gamestate == 'start' then
            gamestate = 'play'
        elseif gamestate == 'play' then
            gamestate = 'start'
        elseif gamestate == 'victory1' then
            gamestate = 'start'
        elseif gamestate == 'victory2' then
            gamestate = 'start'
        end
    end
    love.keyboard.keysPressed[key] = true
    
end

function love.keyreleased(key)
    love.keyboard.keysReleased[key] = true
end

function love.update(dt)
    if gamestate == 'play' then
        if love.keyboard.wasPressed('w') then
            carspeed1 = carspeed1 + 0.08
        elseif love.keyboard.isDown('e') then
            p1x = p1x + carspeed1
        end

        if love.keyboard.wasPressed('down') then
            carspeed2 = carspeed2 + 0.08
        elseif love.keyboard.isDown('right') then
            p2x = p2x + carspeed2
        end
    end
    love.keyboard.keysPressed = {}
    love.keyboard.keysReleased = {}
    
    if p1x >= vwidth then
        p1x = 50
        carspeed1 = 0.5

        p2x = 50
        carspeed2 = 0.5
        gamestate = 'victory1'
    elseif p2x >= vwidth then
        p1x = 50
        carspeed1 = 0.5
    
        p2x = 50
        carspeed2 = 0.5
        gamestate = 'victory2'
    end
end




function love.draw()

   
    push:apply('start')


    love.graphics.clear(105 / 255, 105 / 255, 105 / 255, 105 / 255)
    
    

    displayFPS()

    love.graphics.rectangle('fill', p1x, p1y, 20, 20)
    love.graphics.rectangle('fill', p2x, p2y, 20, 20)


    love.graphics.setColor(0/255, 0/255, 0/255, 1)
    love.graphics.rectangle('fill', 0, vheight / 2 - 20, vwidth, 20)
    love.graphics.setColor(1, 1, 1, 1)
    
    
    if gamestate == 'start' then
        love.graphics.setFont(titlefont)
        love.graphics.printf("Welcome to Racer!", 0, 20, vwidth, 'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf('Press enter or return to start!', 0, 50, vwidth, 'center')
    end 

    if gamestate == 'victory1' then

        love.graphics.setFont(titlefont)
        love.graphics.printf("Player One wins!", 0, 20, vwidth, 'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf('Press enter or return to start!', 0, 50, vwidth, 'center')

    elseif gamestate == 'victory2' then

        love.graphics.setFont(titlefont)
        love.graphics.printf("Player Two wins!", 0, 20, vwidth, 'center')
        love.graphics.setFont(smallfont)
        love.graphics.printf('Press enter or return to start!', 0, 50, vwidth, 'center')

    end

    push:apply('end') 
end


function displayFPS()
  
    love.graphics.setColor(0, 1, 0, 1)
   
    love.graphics.setFont(smallfont)
    
    love.graphics.print('FPS:' .. tostring(love.timer.getFPS()), 40, 20)
   
    love.graphics.setColor(1, 1, 1, 1)
end