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
            paddles[i][j] = love.graphics.newQuad(j*(j-1)*10, 60+i*20, j*20, 20, spriteSheet:getDimensions())
        end
    end
    return paddles
end

function generatePowerupQuads(spriteSheet)
    return {}
end

function generateBallQuads(spriteSheet)
    local balls = {}
    for i = 1, 5 do
        balls[i] = love.graphics.newQuad((i+2)*40, 160, 40, 40, spriteSheet:getDimensions())
    end
    return balls
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
        ['health'] = generateHealthQuads(spriteSheet),
        ['star'] = generateStarQuads(spriteSheet),
    }

    return sprites
end
