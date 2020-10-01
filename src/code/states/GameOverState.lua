GameOverState = BaseState:extend()

function GameOverState:enter(gameState)
    self.level = Text("Your Level: " .. tostring(gameState.level), gFonts['medium'], WINDOW_WIDTH/2, WINDOW_HEIGHT/3)
    self.score = Text("Your Score: " .. tostring(gameState.score), gFonts['medium'], WINDOW_WIDTH/2, 2*WINDOW_HEIGHT/3)
    self.info = Text("Press <SPACE> to go to Main Screen", gFonts['small'], WINDOW_WIDTH/2, WINDOW_HEIGHT-gFonts['small']:getHeight('hello')-5)
    gSounds['gameOver']:play()
end

function GameOverState:update(dt)
    if isKeyPressed('space') or isKeyPressed('return') or isKeyPressed('enter') then
        gStateMachine:changeState('menu')
    end
end

function GameOverState:render()
    self.level:render()
    self.score:render()
    self.info:render()
end
