PlayState = BaseState:extend()

function PlayState:enter(gameState)
    self.paddle = gameState.paddle
    self.ball = gameState.ball
    self.level = gameState.level
    self.brickLayout = gameState.brickLayout
    self.health = gameState.health
    self.score = gameState.score
end

function PlayState:update(dt)
    if isKeyPressed('escape') then
        gStateMachine:changeState('pause', {
            paddle = self.paddle,
            ball = self.ball,
            level = self.level,
            brickLayout = self.brickLayout,
            health = self.health,
            score = self.score,
        })
    end

    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        gSounds['paddleHit']:play()
        self.ball.dy = -self.ball.dy
    end

    local liveBricks = 0
    for i = 1, #self.brickLayout do
        for j = 1, #self.brickLayout[i] do
            local brick = self.brickLayout[i][j]
            liveBricks = liveBricks + (brick.destroyed == false and 1 or 0)

            if not brick.destroyed and self.ball:collides(brick) then
                gSounds['brickHit']:play()
                brick:decrementTier()
                self.ball.dy = -self.ball.dy
            end
        end
    end

    if liveBricks == 0 then
        -- level completed, all bricks cleared
        gStateMachine:changeState('victory', {
            paddle = self.paddle,
            ball = self.ball,
            level = self.level,
            brickLayout = self.brickLayout,
            score = self.score,
            health = self.health,
            levelComplete = true,
        })
    end
end

function PlayState:render()
    for i = 1, #self.brickLayout do
        for j = 1, #self.brickLayout[i] do
            self.brickLayout[i][j]:render()
        end
    end
    self.ball:render()
    self.paddle:render()
end
