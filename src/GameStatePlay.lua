GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init()
  self.player = Player({
    position = Vector2D(VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2),
    size = Vector2D(PLAYER_WIDTH, PLAYER_HEIGHT),
    texture = 'player',
    stateMachine = StateMachine {
      ['idle'] = function() return PlayerStateIdle(self.player) end,
      ['moving'] = function() return PlayerStateMoving(self.player) end
    }
  })
  
  self.player:changeState('idle')
end

function GameStatePlay:update(dt)
  self.player:update(dt)
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  self.player:render()
end