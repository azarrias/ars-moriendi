SorcererStateCasting = Class{__includes = BaseState}

function SorcererStateCasting:init(sorcerer)
  self.sorcerer = sorcerer
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][3] }
  }
end

function SorcererStateCasting:enter(params)
  self.player = params.player
end

function SorcererStateCasting:update(dt)
  self.animation:update(dt)
  self.player:changeState('blocked')
end
