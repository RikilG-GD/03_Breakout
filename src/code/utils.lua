function table.slice(tbl, first, last, step)
    local sliced = {}

    for i = first or 1, last or #tbl, step or 1 do
        sliced[#sliced+1] = tbl[i]
    end

    return sliced
end

function generateQuads(spriteSheet, tileWidth, tileHeight)
    local sheetWidth = spriteSheet:getWidth() / tileWidth
    local sheetHeight = spriteSheet:getHeight() / tileHeight

    local chunks = {}
    local counter = 1

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            chunks[counter] = love.graphics.newQuad(x*tileWidth, y*tileHeight, tileWidth, tileHeight, spriteSheet:getDimensions())
            counter = counter + 1
        end
    end

    return chunks
end

function generateBrickQuads(spriteSheet)
    return table.slice(generateQuads(spriteSheet, 60, 20), 1, 42)
end

function generatePaddleQuads(spriteSheet)
    local paddleColors = 4
    local paddleTiers = 4
    local paddles = {}
    for i = 1, paddleColors do
        paddles[i] = {}
        for j = 1, paddleTiers do
            paddles[i][j] = love.graphics.newQuad(j*(j-1)*30, 60+i*PADDLE_HEIGHT_FACTOR, j*PADDLE_WIDTH_FACTOR, PADDLE_HEIGHT_FACTOR, spriteSheet:getDimensions())
        end
    end
    return paddles
end

function generatePowerupQuads(spriteSheet)
    return {}
end

function generateBallQuads(spriteSheet)
    -- each row for 20x20 has 36 quads. skip 3 rows == 36*3
    -- now skip 6 bricks of 3 quads each = 18
    local start = 36*3+18+1
    return table.slice(generateQuads(spriteSheet, 20, 20), start, start+5)
    --[[
    local balls = {}
    for i = 1, 5 do
        balls[i] = love.graphics.newQuad((i+2)*40, 160, 40, 40, spriteSheet:getDimensions())
    end
    return balls
    ]]
end

function generateArrowQuads(spriteSheet)
    -- each row for 40x40 has 18 quads. skip 4 rows == 18*4
    -- now skip 1 star, 1 heart = 2
    local start = 18*4+2+1
    return table.slice(generateQuads(spriteSheet, 40, 40), start, start+3) -- from [1,4]
end

function generateHealthQuads(spriteSheet)
    return love.graphics.newQuad(40, 160, 40, 40, spriteSheet:getDimensions())
end

function generateStarQuads(spriteSheet)
    return love.graphics.newQuad(0, 160, 40, 40, spriteSheet:getDimensions())
end

function generateSprites(spriteSheet)
    local sprites = {
        ['bricks'] = generateBrickQuads(spriteSheet),
        ['paddles'] = generatePaddleQuads(spriteSheet),
        ['powerups'] = generatePowerupQuads(spriteSheet),
        ['balls'] = generateBallQuads(spriteSheet),
        ['arrows'] = generateArrowQuads(spriteSheet),
        ['health'] = generateHealthQuads(spriteSheet),
        ['star'] = generateStarQuads(spriteSheet),
    }

    return sprites
end
