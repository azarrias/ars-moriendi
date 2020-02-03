SorcererStateMoving = Class{__includes = BaseState}

function SorcererStateMoving:init(sorcerer)
  self.sorcerer = sorcerer
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][1], FRAMES[sorcerer.texture][2] },
    interval = 0.5
  }
  
  self.sorcerer.orientation = math.random(2) == 1 and 'left' or 'right'
  self.movingPeriod = math.random(5)
  self.movingTimer = 0
end

function SorcererStateMoving:update(dt)
  self.movingTimer = self.movingTimer + dt
  self.animation:update(dt)
  
  if self.movingTimer > self.movingPeriod then
    if math.random(4) == 1 then
      self.sorcerer:changeState('idle', {
        wait = math.random(5)
      })
    else
      self.sorcerer.orientation = math.random(2) == 1 and 'left' or 'right'
      self.movingPeriod = math.random(5)
      self.movingTimer = 0
    end
  
  elseif self.sorcerer.orientation == 'left' then
    self.sorcerer.velocity.x = -SORCERER_MOVING_ACCELERATION * dt
    self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
  
  elseif self.sorcerer.orientation == 'right' then
    self.sorcerer.velocity.x = SORCERER_MOVING_ACCELERATION * dt
    self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
  end
end