ServeState = BaseState:extend()

--[[
    draw paddles here
    put ball on paddle
    generate level here
    allow to move paddle
    when user presses space/enter, move to play state
--]]

function ServeState:enter(gameState)
    self.paddle = gameState.paddle or Paddle(gameState.paddleVariant)
    self.ball = gameState.ball or Ball(gameState.ballVariant)
    self.paddle:reset()
    self.ball:reset()
    self.ball.inServe = true
end

function ServeState:update(dt)
    self.paddle:update(dt)
    self.ball:update(dt, self.paddle.x)

    if isKeyPressed('space') or isKeyPressed('enter') or isKeyPressed('return') then
        self.ball.inServe = false
        -- load PlayState
    end
end

function ServeState:render()
    self.paddle:render()
    self.ball:render()
end
