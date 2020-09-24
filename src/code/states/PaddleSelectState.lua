PaddleSelectState = BaseState:extend()

function PaddleSelectState:enter()
    self.paddleTier = 2 -- the paddle variant we are showing to the user
    self.paddleVariant = 0
    self.ballVariant = 2
    self.text = Text('Select your paddle', gFonts['large'], WINDOW_WIDTH/2, WINDOW_HEIGHT/4)
    self.leftArrow = 1
    self.rightArrow = 2
    self.playText = Text('Press <ENTER> to start!\n   <ESCAPE> to go back', gFonts['small'], WINDOW_WIDTH/2, 3*WINDOW_HEIGHT/4)
end

function PaddleSelectState:update()
    if isKeyPressed('escape') then
        gStateMachine:changeState('menu')
    elseif isKeyPressed('enter') or isKeyPressed('return') then
        gStateMachine:changeState('serve', {
                paddleVariant = self.paddleVariant+1, -- give the correct one. not 0 indexed
                ballVariant = self.ballVariant,
            })
    end

    if isKeyPressed('right') or isKeyPressed('d') then
        gSounds['menuOption']:play()
        self.paddleVariant = math.min(self.paddleVariant + 1, #gSprites['paddles'] - 1)
    elseif isKeyPressed('left') or isKeyPressed('a') then
        gSounds['menuOption']:play()
        self.paddleVariant = math.max(0, self.paddleVariant - 1)
    end

    self.leftArrow = (self.paddleVariant == 0 and 3 or 1)
    self.rightArrow = (self.paddleVariant == #gSprites['paddles']-1 and 4 or 2)
end

function PaddleSelectState:render()
    love.graphics.setColor(1, 1, 0, 1)
    self.text:render()
    love.graphics.setColor(1, 1, 1, 1)
    -- draw the arrow icons
    love.graphics.draw(gSpriteSheet, gSprites['arrows'][self.leftArrow], WINDOW_WIDTH/4-ARROW_WIDTH/2, WINDOW_HEIGHT/2-ARROW_HEIGHT/4)
    love.graphics.draw(gSpriteSheet, gSprites['arrows'][self.rightArrow], 3*WINDOW_WIDTH/4-ARROW_WIDTH/2, WINDOW_HEIGHT/2-ARROW_HEIGHT/4)
    -- draw selected paddle
    love.graphics.draw(gSpriteSheet, gSprites['paddles'][self.paddleVariant+1][self.paddleTier], WINDOW_WIDTH/2 - self.paddleTier*PADDLE_WIDTH_FACTOR/2, WINDOW_HEIGHT/2)
    self.playText:render()
end
