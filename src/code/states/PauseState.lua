PauseState = BaseState:extend()

function PauseState:enter(gameState)
    self.gameState = gameState
    self.selection = 0
    self.menuOptions = {
        [1] = Text('Resume', gFonts['medium']),
        [2] = Text('Main Menu', gFonts['medium']),
    }
end

function PauseState:update(dt)
    if isKeyPressed('escape') then
        gStateMachine:changeState('play', self.gameState)
    end

    if isKeyPressed('up') then
        gSounds['menuOption']:play()
        self.selection = math.max(self.selection - 1, 0)
    elseif isKeyPressed('down') then
        gSounds['menuOption']:play()
        self.selection = math.min(#self.menuOptions - 1, self.selection + 1)
    end

    if isKeyPressed('enter') or isKeyPressed('return') then
        gSounds['menuOptionSelect']:play()
        if self.selection == 0 then -- resume selected
            gStateMachine:changeState('play', self.gameState)
        else -- main menu selected
            gStateMachine:changeState('menu')
        end
    end
end

function PauseState:render()
    love.graphics.setColor(1, 1, 1, 1)
    self.gameState.paddle:render()
    self.gameState.ball:render()

    love.graphics.setColor(1, 1, 0, 1)
    local gap = gFonts['medium']:getHeight('High Scores')+5 -- any sample text to get height
    for i = 1, #self.menuOptions do
        self.menuOptions[i]:rePosition(WINDOW_WIDTH/2, 3*WINDOW_HEIGHT/5 + (i-1)*gap)
        if i == self.selection + 1 then
            love.graphics.setColor(1, 1, 1, 0.2)
            -- love.graphics.rectangle('fill', self.menuOptions[i].x-gap/2, self.menuOptions[i].y, self.menuOptions[i].width+gap, self.menuOptions[i].height)
            love.graphics.rectangle('fill', 0, self.menuOptions[i].y, WINDOW_WIDTH, self.menuOptions[i].height)
            love.graphics.setColor(0.1, 1, 0.1, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        self.menuOptions[i]:render()
    end
end
