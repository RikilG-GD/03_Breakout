Ball = class()

function Ball:init(ballVariant)
    self.ballVariant = ballVariant
    self.width = BALL_WIDTH
    self.height = BALL_HEIGHT
    self.dx = 250
    self.dy = -250
    self.inServe = false
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - PADDLE_HEIGHT_FACTOR - self.height/2
end

function Ball:reset()
    self.x = WINDOW_WIDTH/2
    self.y = WINDOW_HEIGHT - GROUND_CLEARANCE - PADDLE_HEIGHT_FACTOR - self.height/2
end

function Ball:collides(obj)
    -- some variable bounds for better understanding
    ballLeft = self.x - self.width/2
    ballRight = self.x + self.width/2
    ballTop = self.y - self.height/2
    ballBottom = self.y + self.height/2
    objLeft = obj.x - obj.width/2
    objRight = obj.x + obj.width/2
    objTop = obj.y - obj.height/2
    objBottom = obj.y + obj.height/2

    if ballLeft <= objRight and ballRight >= objLeft and ballTop <= objBottom and ballBottom >= objTop then
        -- increase speed and return true
        return true
    else
        return false
    end
end

function Ball:update(dt, posX)
    if self.inServe then
        self.x = posX
        return
    end

    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt

    -- if out of bounds, adjust the coordinates
    self.y = math.min(math.max(self.y, self.height/2), WINDOW_HEIGHT - self.height/2)
    self.x = math.min(math.max(self.x, self.width/2), WINDOW_WIDTH - self.width/2)

    if self.y+self.height/2 >= WINDOW_HEIGHT or self.y-self.height/2 <= 0 then
        self.dy = -self.dy
    end

    if self.x+self.width/2 >= WINDOW_WIDTH or self.x-self.width/2 <= 0 then
        self.dx = -self.dx
    end
end

function Ball:render()
    love.graphics.draw(gSpriteSheet, gSprites['balls'][self.ballVariant], self.x-self.width/2, self.y-self.height/2)
end
