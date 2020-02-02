Player = Class{}

function Player:init(def)
  self.position = def.position
  self.size = def.size
  self.texture = def.texture
end

function Player:render()
  love.graphics.draw(TEXTURES[self.texture], FRAMES[self.texture][1],
    VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2, 0, 1, 1)
end