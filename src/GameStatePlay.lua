GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init(def)
  -- TO DO
end

function GameStatePlay:update(dt)
  -- TO DO
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  love.graphics.draw(TEXTURES['player'], FRAMES['player'][1],
    VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 0, 1, 1)
end