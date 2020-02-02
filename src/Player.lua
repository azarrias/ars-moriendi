Player = Class{__includes = Entity}

function Player:init(def)
  def.animation = Animation {
    frames = { FRAMES[def.texture][1], FRAMES[def.texture][2] },
    interval = 0.3
  }
  Entity.init(self, def)
end

function Player:update(dt)
  Entity.update(self, dt)
end

function Player:render()
  Entity.render(self)
end