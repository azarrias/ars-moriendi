Player = Class{__includes = Entity}

function Player:init(def)
  Entity.init(self, def)
end

function Player:update(dt)
  Entity.update(self, dt)
  
  -- constrain player X no matter which state
  if self.position.x <= 0 then
    self.position.x = 0
  elseif self.position.x > TILE_WIDTH * self.tileMap.width - self.size.x then
    self.position.x = TILE_WIDTH * self.tileMap.width - self.size.x
  end
end

function Player:render()
  Entity.render(self)
end