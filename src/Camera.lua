Camera = Class{}

function Camera:init(parent)
  self.parent = parent
  self.position = Vector2D(0, 0)
end

function Camera:update()
  -- set the camera to follow its parent X coordinate (within the boundaries of the level)
  self.position.x = math.max(0, 
    math.min(TILE_WIDTH * self.parent.gameLevel.tileMap.width - VIRTUAL_WIDTH, 
      self.parent.position.x + - (VIRTUAL_WIDTH / 2) + (self.parent.size.x / 2)))
end