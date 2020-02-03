Tile = Class{}

function Tile:init(x, y, id, scale)
  self.position = Vector2D(x, y)
  self.id = id
  self.scale = scale or Vector2D(1, 1)
end

function Tile:render()
  love.graphics.draw(
    TEXTURES['tiles'], 
    FRAMES['tiles'][self.id],
    (self.position.x - 1) * TILE_WIDTH + TILE_WIDTH / 2, 
    (self.position.y - 1) * TILE_HEIGHT + TILE_HEIGHT / 2,
    0,
    self.scale.x,
    self.scale.y,
    TILE_WIDTH / 2,
    TILE_HEIGHT / 2
  )
end
