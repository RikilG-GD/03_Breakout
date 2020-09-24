Ball = class()

function Ball:init(ballVariant)
    self.ballVariant = ballVariant
    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT
    self.dx = 250
    self.dy = 250
    self.inServe = false
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - PADDLE_HEIGHT_FACTOR - self.height/2
end

function Ball:reset()
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - PADDLE_HEIGHT_FACTOR - self.height/2
end

function Ball:update(dt, posX)
    if self.inServe then
        self.x = posX
    end
end

function Ball:render()
    love.graphics.draw(gSpriteSheet, gSprites['balls'][self.ballVariant], self.x-self.width/2, self.y-self.height/2)
end
