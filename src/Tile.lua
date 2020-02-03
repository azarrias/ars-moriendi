Tile = Class{}

function Tile:init(x, y, id)
  self.position = Vector2D(x, y)
  self.id = id
end

function Tile:render()
  love.graphics.draw(TEXTURES['tiles'], FRAMES['tiles'][self.id],
    (self.position.x - 1) * TILE_WIDTH, (self.position.y - 1) * TILE_HEIGHT)
end