MenuState = BaseState:extend()

function MenuState:enter()
    self.title = Text('Breakout!', gFonts['huge'], WINDOW_WIDTH/2, WINDOW_HEIGHT/4)
    self.selection = 0
    self.menuOptions = {
        [1] = Text('Start', gFonts['medium']),
        [2] = Text('High Scores', gFonts['medium']),
        [3] = Text('Exit', gFonts['medium']),
    }
end

function MenuState:update(dt)
    if isKeyPressed('escape') or isKeyPressed('q') then
        love.event.quit()
    end

    if isKeyPressed('up') then
        self.selection = math.max(self.selection - 1, 0)
    elseif isKeyPressed('down') then
        self.selection = math.min(#self.menuOptions - 1, self.selection + 1)
    end

    if isKeyPressed('enter') or isKeyPressed('return') or isKeyPressed('space') then
        if self.selection == 0 then -- play selected
            
        elseif self.selection == 1 then -- HighScores selected

        else
            love.event.quit()
        end
    end
end

function MenuState:render()
    love.graphics.clear(20/255, 20/255, 20/255, 1)
    love.graphics.setColor(1, 1, 0, 1)
    self.title:render()

    local gap = gFonts['medium']:getHeight('High Scores')+5 -- any sample text to get height
    for i = 1, #self.menuOptions do
        self.menuOptions[i]:rePosition(WINDOW_WIDTH/2, 3*WINDOW_HEIGHT/5 + (i-1)*gap)
        if i == self.selection + 1 then
            love.graphics.setColor(1, 1, 1, 0.2)
            love.graphics.rectangle('fill', self.menuOptions[i].x-gap/2, self.menuOptions[i].y, self.menuOptions[i].width+gap, self.menuOptions[i].height)
            love.graphics.setColor(0.1, 1, 0.1, 1)
        else
            love.graphics.setColor(1, 1, 1, 1)
        end
        self.menuOptions[i]:render()
    end
end
