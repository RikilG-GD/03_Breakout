LevelGenerator = class()

function LevelGenerator:init()
    self.fancyBricks = table.slice(gSprites['bricks'], 1, 20)
    self.solidBricks = table.slice(gSprites['bricks'], 21, 40)
    self.lockBricks = table.slice(gSprites['bricks'], 41, 42)
end

function LevelGenerator:generateLevel(level)
    local brickLayout = {}
    local rows = math.min((WINDOW_HEIGHT - ROW_MARGIN)/(2*BRICK_HEIGHT), 2+math.floor(level/3)) -- min 2 rows, max 15 rows for 600px height
    local cols = (WINDOW_WIDTH - 2*COL_MARGIN)/BRICK_WIDTH

    for i = 1, rows do
        -- initialize ith row
        brickLayout[i] = {}
        for j = 1, cols do
            local tier = 3
            local style = 0
            local brick = Brick(i, j, style, tier)
            brickLayout[i][j] = brick
        end
    end

    return brickLayout
end
