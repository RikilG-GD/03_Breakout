VictoryState = BaseState:extend()

function VictoryState:enter(gameState)
    -- play victory music
    self.gameState = gameState
    self.winText = Text('Level ' .. tostring(gameState.level) .. ' Cleared!', gFonts['medium'], WINDOW_WIDTH/2, WINDOW_HEIGHT/4)
    self.infoText = Text('Press <SPACE> to go to next level!', gFonts['medium'], WINDOW_WIDTH/2, 3*WINDOW_HEIGHT/4)
end

function VictoryState:update(dt)
    if isKeyPressed('space') then
        gStateMachine:changeState('serve', self.gameState)
    end
end

function VictoryState:render()
    self.gameState.paddle:render()
    self.gameState.ball:render()
    love.graphics.setColor(0, 1, 0, 1)
    self.winText:render()
    love.graphics.setColor(1, 1, 1, 0.6)
    self.infoText:render()
    love.graphics.setColor(1, 1, 1, 1)
end
