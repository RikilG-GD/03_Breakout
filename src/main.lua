require 'code/dependencies'

gFonts = {
    ['small'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 18),
    ['medium'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 28),
    ['large'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 46),
    ['huge'] = love.graphics.newFont('assets/fonts/Retro_Gaming.ttf', 62),
}

gSounds = {
    ['background'] = love.audio.newSource('assets/sounds/Szymon Matuszewski - Art.mp3', 'static'),
    ['menuOption'] = love.audio.newSource('assets/sounds/MenuOption.wav', 'static'),
    ['menuOptionSelect'] = love.audio.newSource('assets/sounds/MenuOptionSelect.wav', 'static'),
    ['menuOptionInvalid'] = love.audio.newSource('assets/sounds/MenuOptionUnavilable.wav', 'static'),
    ['paddleHit'] = love.audio.newSource('assets/sounds/PaddleHit.wav', 'static'),
    ['wallHit'] = love.audio.newSource('assets/sounds/WallHit.wav', 'static'),
    ['brickHit'] = love.audio.newSource('assets/sounds/BrickHit.wav', 'static'),
    ['death'] = love.audio.newSource('assets/sounds/Death.wav', 'static'),
    ['gameOver'] = love.audio.newSource('assets/sounds/GameOver.wav', 'static'),
}

gSpriteSheet = love.graphics.newImage('assets/sprites/spriteSheet.png')
gSprites = generateSprites(gSpriteSheet)
backgroundImage = love.graphics.newImage('assets/sprites/background.jpg')

gStateMachine = StateMachine{
    ['menu'] = MenuState(),
    ['paddleSelect'] = PaddleSelectState(),
    ['serve'] = ServeState(),
    ['play'] = PlayState(),
    ['victory'] = VictoryState(),
    ['pause'] = PauseState(),
    ['gameOver'] = GameOverState(),
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
    gStateMachine:changeState('menu')
end

function love.update(dt)
    -- update background
    
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}
end

function love.draw()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(backgroundImage, 0, 0)
    -- love.graphics.clear(20/255, 20/255, 20/255, 1)

    gStateMachine:render()
end
