PlayState = BaseState:extend()

function PlayState:enter(gameState)
    self.paddle = gameState.paddle
    self.ball = gameState.ball
    self.level = gameState.level
    self.brickLayout = gameState.brickLayout
end

function PlayState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt)

    if self.ball:collides(self.paddle) then
        self.ball.dy = -self.ball.dy
    end

    for i = 1, #self.brickLayout do
        for j = 1, #self.brickLayout[i] do
            if self.brickLayout[i][j].tier >= 0 and self.ball:collides(self.brickLayout[i][j]) then
                self.brickLayout[i][j].tier = self.brickLayout[i][j].tier - 1
                self.ball.dy = -self.ball.dy
            end
        end
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
