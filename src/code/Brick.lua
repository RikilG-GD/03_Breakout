Brick = class()

function Brick:init(row, col, style, tier)
    self.style = style
    self.tier = tier
    self.width = BRICK_WIDTH
    self.height = BRICK_HEIGHT
    self.x = COL_MARGIN + (col - 1)*BRICK_WIDTH + self.width/2
    self.y = ROW_MARGIN + (row - 1)*BRICK_HEIGHT + self.height/2
end

function Brick:update(dt)

end

function Brick:render()
    if self.tier >= 0 then
        love.graphics.draw(gSpriteSheet, gSprites['bricks'][self.style+self.tier+1], self.x-self.width/2, self.y-self.height/2)
    end
end
