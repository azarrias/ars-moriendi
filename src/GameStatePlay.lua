GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init()
  self.player = Player({
    position = Vector2D(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2),
    size = Vector2D(PLAYER_WIDTH, PLAYER_HEIGHT),
    texture = 'player'
  })
end

function GameStatePlay:update(dt)
  self.player:update(dt)
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  self.player:render()
end