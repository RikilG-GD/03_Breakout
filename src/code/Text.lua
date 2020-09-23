Text = class()

function Text:init(text, font, centerX, centerY)
    self.text = text
    self.font = font
    centerX = centerX or WINDOW_WIDTH/2
    centerY = centerY or WINDOW_HEIGHT/2
    self.width = self.font:getWidth(self.text)
    self.height = self.font:getHeight(self.text)
    self.x = centerX - self.width/2
    self.y = centerY - self.height/2
end

function Text:rePosition(centerX, centerY)
    self.x = centerX - self.width/2
    self.y = centerY - self.height/2
end

function Text:render()
    love.graphics.setFont(self.font)
    love.graphics.print(self.text, self.x, self.y)
end
