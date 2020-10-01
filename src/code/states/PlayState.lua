PlayState = BaseState:extend()

function PlayState:enter(gameState)
    self.paddle = gameState.paddle
    self.ball = gameState.ball
    self.level = gameState.level
    self.brickLayout = gameState.brickLayout
    self.health = gameState.health
    self.score = gameState.score

    self.scoreText = Text("Score: " .. tostring(self.score), gFonts['small'], 5, 5, 'left', 'top')
    self.levelText = Text("Level: " .. tostring(self.level), gFonts['small'], WINDOW_WIDTH-5, 5, 'right', 'top')
    self.healthText = Text("Lives: " .. tostring(self.health), gFonts['small'], WINDOW_WIDTH/2, 5, 'center', 'top')
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

    if self.ball.alive == false then
        self.health = self.health - 1
        gSounds['death']:play()
        love.timer.sleep(1.5)
        if self.health > 0 then
            gStateMachine:changeState('serve', {
                paddle = self.paddle,
                ball = self.ball,
                level = self.level,
                brickLayout = self.brickLayout,
                score = self.score,
                health = self.health,
                levelComplete = false,
            })
        else
            gStateMachine:changeState('gameOver', {
                level = self.level,
                score = self.score,
            })
        end
    end

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
                self.score = self.score + brick.value
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

    self.scoreText = Text("Score: " .. tostring(self.score), gFonts['small'], 5, 5, 'left', 'top')
end

function PlayState:render()
    for i = 1, #self.brickLayout do
        for j = 1, #self.brickLayout[i] do
            self.brickLayout[i][j]:render()
        end
    end
    self.ball:render()
    self.paddle:render()

    self.scoreText:render()
    self.levelText:render()

    if self.health > 2 then
        love.graphics.setColor(0, 1, 0, 1)
    elseif self.health == 2 then
        love.graphics.setColor(1, 1, 0, 1)
    else
        love.graphics.setColor(1, 0, 0, 1)
    end

    self.healthText:render()
end
