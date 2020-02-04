SorcererStateCasting = Class{__includes = BaseState}

function SorcererStateCasting:init(sorcerer)
  self.sorcerer = sorcerer
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][3] }
  }
end

function SorcererStateCasting:enter()
  self.waitPeriod = 1.3
  self.waitTimer = 0 
end

function SorcererStateCasting:update(dt)
  self.animation:update(dt)
  
  if self.waitTimer < self.waitPeriod then
    self.waitTimer = self.waitTimer + dt
  else
    self.sorcerer:changeState('idle', {
      wait = math.random(5),
      monitoring = true
    })
  end
end
