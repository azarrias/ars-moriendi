PlayerStateBlocked = Class{__includes = BaseState}

function PlayerStateBlocked:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][3] },
  }
end

function PlayerStateBlocked:enter()
  self.player.velocity.y = 0
end