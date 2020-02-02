GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init()
  self.player = Player({
    position = Vector2D(0, 0),
    size = Vector2D(PLAYER_WIDTH, PLAYER_HEIGHT),
    texture = 'player'
  })
end

function GameStatePlay:update(dt)
  -- TO DO
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  self.player:render()
end