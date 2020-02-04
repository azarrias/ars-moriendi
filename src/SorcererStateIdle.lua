SorcererStateIdle = Class{__includes = BaseState}

function SorcererStateIdle:init(sorcerer)
  self.sorcerer = sorcerer
  self.waitTimer = 0
  self.monitoring = false
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][1] }
  }
end

function SorcererStateIdle:enter(params)
  self.waitPeriod = params.wait
  self.monitoring = params.monitoring
end

function SorcererStateIdle:update(dt)
  if self.sorcerer.playerDetection ~= nil then
    if self.sorcerer.playerDetection.position.y >= (TOP_GROUND_TILE_Y - 1) * TILE_HEIGHT then
      self.sorcerer.playerDetection:changeState('blocked')
      self.sorcerer:changeState('casting', { player = self.sorcerer.playerDetection })
      
    elseif not self.monitoring and 
      self.sorcerer:calculateDistance(self.sorcerer.playerDetection.position) > 15 then
        self.sorcerer:changeState('moving')
    end
  elseif self.waitTimer < self.waitPeriod then
    self.waitTimer = self.waitTimer + dt
  elseif not self.monitoring then
    self.sorcerer:changeState('moving')
  else
    self.monitoring = false
  end
end