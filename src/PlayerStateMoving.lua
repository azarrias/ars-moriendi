PlayerStateMoving = Class{__includes = BaseState}

function PlayerStateMoving:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][1], FRAMES[player.texture][2] },
    interval = 0.3
  }
end

function PlayerStateMoving:update(dt)
  self.animation:update(dt)
  
  -- check the tiles below the player's feet
  local tiles = self.player.colliders['bottom']:checkTileCollisions(self.player.gameLevel.tileMap)
  
  if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
    self.player:changeState('idle')
    
  elseif not tiles['left-bottom'] and not tiles['right-bottom'] then
    self.player.velocity.y = 0
    self.player:changeState('falling')
    
  elseif love.keyboard.isDown('left') then
    self.player.velocity.x = -PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'left'
    tiles = self.player.colliders['left']:checkTileCollisions(self.player.gameLevel.tileMap)
    
    if tiles['left-top'] or tiles['left-bottom'] then
      local tile = not tiles['left-top'] and tiles['left-bottom'] or tiles['left-top']
      if not tile.platform then
        self.player.position.x = (tile.position.x - 1) * TILE_WIDTH + TILE_WIDTH - 1
      end
    end

  elseif love.keyboard.isDown('right') then
    self.player.velocity.x = PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'right'
    tiles = self.player.colliders['right']:checkTileCollisions(self.player.gameLevel.tileMap)
    
    if tiles['right-top'] or tiles['right-bottom'] then
      local tile = not tiles['right-top'] and tiles['right-bottom'] or tiles['right-top']
      if not tile.platform then
        self.player.position.x = (tile.position.x - 1) * TILE_WIDTH - self.player.size.x + 1
      end
    end
  end
  
  if love.keyboard.keysPressed['space'] then
    self.player:changeState('jumping')
  end
end