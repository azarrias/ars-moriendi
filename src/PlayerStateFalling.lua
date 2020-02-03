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
  local tileLeftBottom = self.player.colliders['bottom']:checkTileCollisions(self.player.gameLevel.tileMap, 'left-bottom')
  local tileRightBottom = self.player.colliders['bottom']:checkTileCollisions(self.player.gameLevel.tileMap, 'right-bottom')
  
  if tileLeftBottom or tileRightBottom then
    self.player.velocity.y = 0
    
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
      self.player:changeState('moving')
    else
      self.player:changeState('idle')
    end
  
    -- rectify the player's y coordinate to its appropriate value
    local tile = tileLeftBottom ~= nil and tileLeftBottom or tileRightBottom
    self.player.position.y = (tile.position.y - 1) * TILE_HEIGHT - self.player.size.y
  
  elseif love.keyboard.isDown('left') then
    self.player.velocity.x = -PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'left'

  elseif love.keyboard.isDown('right') then
    self.player.velocity.x = PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'right'
  end
end