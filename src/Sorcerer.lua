Sorcerer = Class{__includes = Entity}

function Sorcerer:init(def)
  Entity.init(self, def)
  self.playerDetection = nil
end

function Sorcerer:update(dt)
  Entity.update(self, dt)
end

function Sorcerer:render()
  Entity.render(self)
  
  if self.playerDetection ~= nil then
    local r, g, b, a = love.graphics.getColor()
  
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.rectangle('fill', math.floor(self.position.x), math.floor(self.position.y),
      self.size.x, self.size.y)
  
    love.graphics.setColor(r, g, b, a)
  end
end