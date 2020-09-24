Paddle = class()

function Paddle:init(paddleVariant)
    self.paddleVariant = paddleVariant
    self.paddleTier = 2
    self.width = self.paddleTier*PADDLE_WIDTH_FACTOR
    self.height = PADDLE_HEIGHT_FACTOR
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - self.height/2
    self.dx = 350
end

function Paddle:reset()
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - self.height/2
end

function Paddle:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('a') then
        self.x = math.max(self.width/2, self.x - self.dx * dt)
    elseif love.keyboard.isDown('right') or love.keyboard.isDown('d') then
        self.x = math.min(WINDOW_WIDTH-self.width/2, self.x + self.dx * dt)
    end
end

function Paddle:render()
    love.graphics.draw(gSpriteSheet, gSprites['paddles'][self.paddleVariant][self.paddleTier], self.x-self.width/2, self.y-self.height/2)
end
