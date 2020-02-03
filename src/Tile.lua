Tile = Class{}

function Tile:init(x, y, id, platform, scale)
  self.position = Vector2D(x, y)
  self.id = id
  self.platform = platform or false
  self.scale = scale or Vector2D(1, 1)
end

function Tile:render()
  love.graphics.draw(
    TEXTURES['tiles'], 
    FRAMES['tiles'][self.id],
    (self.position.x - 1) * TILE_WIDTH + TILE_WIDTH * 0.5, 
    (self.position.y - 1) * TILE_HEIGHT + TILE_HEIGHT * 0.5,
    0,
    self.scale.x,
    self.scale.y,
    TILE_WIDTH / 2,
    TILE_HEIGHT / 2
  )
end

--[[
    Checks that this ID is not blacklisted as non collidable in a global constants table
]]
function Tile:collidable(target)
  for k, v in pairs(TILE_ID_NON_COLLIDABLE) do
    if v == self.id then
      return false
    end
  end

  return true
end