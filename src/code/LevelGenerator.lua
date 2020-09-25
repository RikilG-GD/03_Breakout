LevelGenerator = class()

function LevelGenerator:init()
    self.fancyBricks = table.slice(gSprites['bricks'], 1, 20)
    self.solidBricks = table.slice(gSprites['bricks'], 21, 40)
    self.lockBricks = table.slice(gSprites['bricks'], 41, 42)
end

function LevelGenerator:generateLevel(level)
    local brickLayout = {}
    local rows = math.min((WINDOW_HEIGHT - ROW_MARGIN)/(2*BRICK_HEIGHT), 2+math.floor(level/1)) -- min 2 rows, max 15 rows for 600px height
    local cols = (WINDOW_WIDTH - 2*COL_MARGIN)/BRICK_WIDTH
    local maxTier = math.min(3, math.floor(level/4))

    for i = 1, rows do
        -- initialize ith row
        brickLayout[i] = {}
        local skipRow = math.random(1, 4) == 1

        local skipAlternate = math.random(0, 1) == 1 -- skip blocks in alternate cols
        local alignLeft = skipAlternate and math.random(0, 1) == 1
        local solidRow = math.random(1, 3) == 1 -- have only one color
        local solidStyle = solidRow and math.random(0, 4)

        for j = 1, cols do
            local tier = math.random(0, maxTier)
            local style = math.random(0, 4)

            if solidRow then
                style = solidStyle
            end

            local brick = Brick(i, j, style, tier)

            if skipRow or (skipAlternate and alignLeft and j % 2 == 0) then
                brick.destroyed = true
            elseif skipAlternate and not alignLeft and j % 2 == 1 then
                brick.destroyed = true
            end

            brickLayout[i][j] = brick
        end
        ::continue::
    end

    return brickLayout
end
