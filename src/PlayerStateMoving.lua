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
  
  if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
    self.player:changeState('idle')
    
  elseif love.keyboard.isDown('left') then
    self.player.velocity.x = -PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'left'

elseif love.keyboard.isDown('right') then
    self.player.velocity.x = PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'right'
  end
  
  if love.keyboard.keysPressed['space'] then
    self.player:changeState('jumping')
  end
end