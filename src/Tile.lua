Tile = Class{}

function Tile:init(x, y, id, isVariation)
  self.position = Vector2D(x, y)
  self.id = id
  self.isVariation = isVariation ~= nil and isVariation or false
  -- set the scale randomly to -1 or 1 in both axis (if it's a variation of a ground tile)
  -- just in order to have some more variation
  self.scale = Vector2D(self.isVariation and math.random(1, 2) * 2 - 3 or 1, 
    self.isVariation and math.random(1, 2) * 2 - 3 or 1)
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
