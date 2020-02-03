GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init()
  self.tileMap = LevelFactory.create(100, 10)  
  
  self.player = Player({
    position = Vector2D((PLAYER_STARTING_X - 1) * PLAYER_WIDTH, (PLAYER_STARTING_Y - 1) * PLAYER_HEIGHT),
    size = Vector2D(PLAYER_WIDTH, PLAYER_HEIGHT),
    texture = 'player',
    stateMachine = StateMachine {
      ['idle'] = function() return PlayerStateIdle(self.player) end,
      ['moving'] = function() return PlayerStateMoving(self.player) end,
      ['jumping'] = function() return PlayerStateJumping(self.player) end
    }
  })
  
  self.player:changeState('idle')
end

function GameStatePlay:update(dt)
  self.player:update(dt)
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  self.tileMap:render()
  self.player:render()
end