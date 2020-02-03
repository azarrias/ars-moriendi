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
    },
    tileMap = self.tileMap
  })
  
  self.player:changeState('idle')
  
  self.camera = Camera(self.player)
end

function GameStatePlay:update(dt)
  self.player:update(dt)
  self.camera:update()
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  
  -- translate scene by camera scroll amount; negative shifts have the effect of making it seem
  -- like we're actually moving right and vice-versa; note the use of math.floor, as rendering
  -- fractional camera offsets with a virtual resolution will result in weird pixelation and artifacting
  -- as things are attempted to be drawn fractionally and then forced onto a small virtual canvas
  love.graphics.translate(-math.floor(self.camera.position.x), 0)
  
  self.tileMap:render()
  self.player:render()
end