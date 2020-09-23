require 'code/dependencies'

gFonts = {
    ['small'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 18),
    ['medium'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 28),
    ['large'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 36),
    ['huge'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 48),
}

gSounds = {
    ['background'] = love.audio.newSource('assets/sounds/Szymon Matuszewski - Art.mp3', 'static'),
}

gStateMachine = StateMachine{
    
}

function love.keypressed(key)
    love.keyboard.keysPressed[key] = true
end

function isKeyPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.window.setTitle('Breakout!')
    math.randomseed(os.time())
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
    gSounds['background']:setLooping(true)
    gSounds['background']:play()
    -- gStateMachine:changeState('title')
end

function love.update(dt)
    -- update background
    
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    -- render background

    gStateMachine:render()
end
