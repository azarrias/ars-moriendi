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
  
  -- TO DO - implement collisions
  if self.player.position.y >= VIRTUAL_HEIGHT / 2 then
    self.player.velocity.y = 0
    self.player.position.y = VIRTUAL_HEIGHT / 2
    
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
      self.player:changeState('moving')
    else
      self.player:changeState('idle')
    end
  
  elseif love.keyboard.isDown('left') then
    self.player.position.x = self.player.position.x - PLAYER_MOVING_SPEED * dt
    self.player.orientation = 'left'

  elseif love.keyboard.isDown('right') then
    self.player.position.x = self.player.position.x + PLAYER_MOVING_SPEED * dt
    self.player.orientation = 'right'
  end
  
  
end