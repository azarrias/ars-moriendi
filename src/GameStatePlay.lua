GameStatePlay = Class{__includes = BaseState}

function GameStatePlay:init()
  self.gameLevel = LevelFactory.create(100, 10)  
  self.gameLevel:spawnEnemies()
  
  self.player = Player({
    position = Vector2D(PLAYER_STARTING_X * TILE_WIDTH - PLAYER_WIDTH, PLAYER_STARTING_Y * TILE_HEIGHT - PLAYER_HEIGHT),
    size = Vector2D(PLAYER_WIDTH, PLAYER_HEIGHT),
    texture = 'player',
    stateMachine = StateMachine {
      ['idle'] = function() return PlayerStateIdle(self.player) end,
      ['moving'] = function() return PlayerStateMoving(self.player) end,
      ['jumping'] = function() return PlayerStateJumping(self.player) end,
      ['falling'] = function() return PlayerStateFalling(self.player) end,
      ['blocked'] = function() return PlayerStateBlocked(self.player) end,
      ['dying'] = function() return PlayerStateDying(self.player) end
    },
    gameLevel = self.gameLevel,
    pivotPoint = Vector2D(PLAYER_WIDTH * 0.5, PLAYER_HEIGHT * 0.5)
  })

  local playerBottomCollider = Collider {
    center = Vector2D(PLAYER_WIDTH / 2, PLAYER_HEIGHT + 0.5),
    size = Vector2D(2, 1)
  }
  self.player:addCollider('bottom', playerBottomCollider)

  local playerLeftCollider = Collider {
    center = Vector2D(1.5, PLAYER_HEIGHT / 2),
    size = Vector2D(1, 4)
  }
  self.player:addCollider('left', playerLeftCollider)
  
  local playerRightCollider = Collider {
    center = Vector2D(PLAYER_WIDTH - 1.5, PLAYER_HEIGHT / 2),
    size = Vector2D(1, 4)
  }
  self.player:addCollider('right', playerRightCollider)

  self.player:changeState('idle')
  
  self.camera = Camera(self.player)
  
  self.hud = Hud({
    position = Vector2D(2, 2),
    texture = 'skull',
    player = self.player
  })
end

function GameStatePlay:enter(params)
  self.gameLevel.level = params.level
end

function GameStatePlay:update(dt)
  self.player:update(dt)
  self.gameLevel:update(dt)
  self.camera:update()
end

function GameStatePlay:render()
  love.graphics.clear(COLORS['light'])
  
  love.graphics.push()
  -- translate scene by camera scroll amount; negative shifts have the effect of making it seem
  -- like we're actually moving right and vice-versa; note the use of math.floor, as rendering
  -- fractional camera offsets with a virtual resolution will result in weird pixelation and artifacting
  -- as things are attempted to be drawn fractionally and then forced onto a small virtual canvas
  love.graphics.translate(-math.floor(self.camera.position.x), 0)
  
  self.gameLevel:render()
  self.player:render()
  
  love.graphics.pop()
  self.hud:render()
end