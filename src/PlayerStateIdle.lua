PlayerStateIdle = Class{__includes = BaseState}

function PlayerStateIdle:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][1] }
  }
end

function PlayerStateIdle:update(dt)
  if love.keyboard.keysPressed['left'] or love.keyboard.keysPressed['right'] then
    self.player:changeState('moving')
  end
end
