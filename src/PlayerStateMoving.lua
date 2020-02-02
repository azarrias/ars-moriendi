PlayerStateMoving = Class{__includes = BaseState}

function PlayerStateMoving:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][1], FRAMES[player.texture][2] },
    interval = 0.2
  }
end

function PlayerStateMoving:update(dt)
  self.animation:update(dt)
  
  if not love.keyboard.isDown('left') and not love.keyboard.isDown('right') then
    self.player:changeState('idle')
    
  elseif love.keyboard.isDown('left') then
    self.player.position.x = self.player.position.x - PLAYER_MOVING_SPEED * dt

  elseif love.keyboard.isDown('right') then
    self.player.position.x = self.player.position.x + PLAYER_MOVING_SPEED * dt
  end
  
  if love.keyboard.keysPressed['space'] then
    self.player:changeState('jumping')
  end
end