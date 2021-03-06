Collider = Class{}

function Collider:init(def)
  -- will be set when the parent adds it (Entity:addCollider)
  self.parent = nil
  
  -- center, size and position in the collider's local space
  self.center = def.center
  self.size = def.size
  self.position = self.center - Vector2D(self.size.x / 2, self.size.y / 2)
end

function Collider:render()
  local r, g, b, a = love.graphics.getColor()
  local coord = self:getWorldCoordinates()
  
  love.graphics.setColor(1, 0.6, 0.6, 0.6)
  love.graphics.rectangle('fill', math.floor(coord.x), math.floor(coord.y),
    self.size.x, self.size.y)
  
  love.graphics.setColor(r, g, b, a)
end      

function Collider:getWorldCoordinates()
  return self.parent.position + self.position
end

function Collider:checkTileCollisions(tilemap)
  local tiles = {}
  local coord = self:getWorldCoordinates()
  
  tiles['left-top'] = tilemap:pointToTile(coord)
  tiles['right-top'] = tilemap:pointToTile(coord + Vector2D(self.size.x, 0))
  tiles['left-bottom'] = tilemap:pointToTile(coord + Vector2D(0, self.size.y))
  tiles['right-bottom'] = tilemap:pointToTile(coord + self.size)
  
  for k, tile in pairs(tiles) do
    if not tile:collidable() then
      tiles[k] = nil
    end
  end
  
  return tiles
end