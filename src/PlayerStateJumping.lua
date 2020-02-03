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
  
  -- TO DO - implement collisions
  if love.keyboard.isDown('left') then
    self.player.velocity.x = -PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'left'

  elseif love.keyboard.isDown('right') then
    self.player.velocity.x = PLAYER_MOVING_ACCELERATION * dt
    self.player.position.x = self.player.position.x + self.player.velocity.x * dt
    self.player.orientation = 'right'
  end
end