SorcererStateIdle = Class{__includes = BaseState}

function SorcererStateIdle:init(sorcerer)
  self.sorcerer = sorcerer
  self.waitTimer = 0
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][1] }
  }
end

function SorcererStateIdle:enter(params)
  self.waitPeriod = params.wait
end

function SorcererStateIdle:update(dt)
  if self.waitTimer < self.waitPeriod then
    self.waitTimer = self.waitTimer + dt
  elseif self.sorcerer.playerPosition ~= nil then
    self.waitPeriod = 1
    self.waitTimer = 0
  else -- turn around and go
    self.sorcerer:changeState('moving')
  end
end