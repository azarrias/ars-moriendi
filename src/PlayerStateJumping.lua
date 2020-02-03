PlayerStateJumping = Class{__includes = BaseState}

function PlayerStateJumping:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][3] },
  }
end

function PlayerStateJumping:enter()
  self.player.velocity.y = PLAYER_JUMPING_VELOCITY
end

function PlayerStateJumping:update(dt)
  self.animation:update(dt)
  self.player.velocity.y = self.player.velocity.y + GRAVITY
  self.player.position.y = self.player.position.y + self.player.velocity.y * dt
  
  -- when y velocity turns positive, go into falling state
  if self.player.velocity.y >= 0 then
    self.player:changeState('falling')
  end
  
  if love.keyboard.isDown('left') then
    self.player.velocity.x = -PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'left'
    local tiles = self.player.colliders['left']:checkTileCollisions(self.player.gameLevel.tileMap)
    
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
    local tiles = self.player.colliders['right']:checkTileCollisions(self.player.gameLevel.tileMap)
    
    if tiles['right-top'] or tiles['right-bottom'] then
      local tile = not tiles['right-top'] and tiles['right-bottom'] or tiles['right-top']
      if not tile.platform then
        self.player.position.x = (tile.position.x - 1) * TILE_WIDTH - self.player.size.x + 1
      end
    end    
    
  end
end