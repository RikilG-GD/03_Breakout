ServeState = BaseState:extend()

--[[
    -- specification of game-state
    gameState = {
        paddle,
        ball,
        level,
        brickLayout,
        score,
        health,
        levelComplete,
    }
--]]

function ServeState:init()
    self.levelGenerator = LevelGenerator()
end

function ServeState:enter(gameState)
    self.paddle = gameState.paddle or Paddle(gameState.paddleVariant)
    self.ball = gameState.ball or Ball(gameState.ballVariant)
    self.level = (gameState.level or 0) + 1 -- increment for next level
    self.brickLayout = gameState.brickLayout
    self.score = gameState.score or 0
    self.health = gameState.health or 3
    self.levelComplete = gameState.levelComplete or true

    self.paddle:reset()
    self.ball:reset()
    self.ball.inServe = true
    self.infoText = Text('Press <SPACE> to launch!', gFonts['small'], WINDOW_WIDTH/2, 2*WINDOW_HEIGHT/3)
    
    if self.levelComplete then
        self.brickLayout = self.levelGenerator:generateLevel(self.level) -- generate new brickset
    end

    self.ball.dy = -math.abs(self.ball.dy)
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt, self.paddle.x)

    if isKeyPressed('space') or isKeyPressed('enter') or isKeyPressed('return') then
        self.ball.inServe = false
        gStateMachine:changeState('play', {
                paddle = self.paddle,
                ball = self.ball,
                level = self.level,
                brickLayout = self.brickLayout,
                score = self.score,
                health = self.health,
            })
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()

    for i = 1, #self.brickLayout do
        for j = 1, #self.brickLayout[i] do
            self.brickLayout[i][j]:render()
        end
    end

    self.infoText:render()
end
