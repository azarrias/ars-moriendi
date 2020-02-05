PlayerStateFalling = Class{__includes = BaseState}

function PlayerStateFalling:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][3] },
  }
end

function PlayerStateFalling:update(dt)
  self.animation:update(dt)
  self.player.velocity.y = self.player.velocity.y + GRAVITY
  self.player.position.y = self.player.position.y + self.player.velocity.y * dt
  
  -- check the tiles below the player's feet
  local tiles = self.player.colliders['bottom']:checkTileCollisions(self.player.gameLevel.tileMap)
  
  if tiles['left-bottom'] or tiles['right-bottom'] then
    SOUNDS['jump-landing']:stop()
    SOUNDS['jump-landing']:play()
    self.player.velocity.y = 0
    
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
      self.player:changeState('moving')
    else
      self.player:changeState('idle')
    end
  
    -- rectify the player's y coordinate to its appropriate value
    local tile = not tiles['left-bottom'] and tiles['right-bottom'] or tiles['left-bottom']
    self.player.position.y = (tile.position.y - 1) * TILE_HEIGHT - self.player.size.y
    
  -- die if it falls out of bounds down below
  elseif self.player.position.y > VIRTUAL_HEIGHT then
    SOUNDS['death']:stop()
    SOUNDS['death']:play()
    self.player:changeState('dying', { dyingX = self.player.position.x + self.player.size.x / 2 })
  
  -- if the player is moving in the air, check for side collisions
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
end