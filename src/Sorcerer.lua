Sorcerer = Class{__includes = Entity}

function Sorcerer:init(def)
  Entity.init(self, def)
  self.playerPosition = nil
end

function Sorcerer:update(dt)
  Entity.update(self, dt)
end

function Sorcerer:render()
  Entity.render(self)
end