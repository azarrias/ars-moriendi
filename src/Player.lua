Player = Class{__includes = Entity}

function Player:init(def)
  Entity.init(self, def)
end

function Player:update(dt)
  Entity.update(self, dt)
  
  -- constrain player X no matter which state
  if self.position.x <= 0 then
    self.position.x = 0
  elseif self.position.x > TILE_WIDTH * self.gameLevel.tileMap.width - self.size.x then
    self.position.x = TILE_WIDTH * self.gameLevel.tileMap.width - self.size.x
  end
  
  -- check if any of the enemies detect the player
  local playerPoint = self.position + Vector2D(self.size.x / 2, self.size.y / 2)
  local playerTile = self.gameLevel.tileMap:pointToTile(playerPoint)
  local minDistance = math.max(self.gameLevel.tileMap.width * TILE_WIDTH, 
      self.gameLevel.tileMap.height * TILE_HEIGHT)
  local closestEnemy = nil
    
  for k, entity in pairs(self.gameLevel.entities) do
    local entityPoint = entity.position + Vector2D(entity.size.x / 2, entity.size.y / 2)
    local entityTile = self.gameLevel.tileMap:pointToTile(entityPoint)
    
    local dist = self:calculateDistance(entityPoint)
    
    if dist > PLAYER_SORCERER_DETECTION_RANGE or
      entity.orientation == 'left' and self.position.x > entity.position.x or
      entity.orientation == 'right' and self.position.x < entity.position.x then
    else
      local detectedPlayer = bresenham.los(entityTile.position.x, entityTile.position.y,
        playerTile.position.x, playerTile.position.y, 
        function(x, y)
          if self.gameLevel.tileMap.tiles[y][x]:collidable() then
            return false
          end
          
          return true
        end
      )
      
      if detectedPlayer then
        entity.playerPosition = self.position
        break
      end
    end
    
    entity.playerPosition = nil
    
  end
end

function Player:render()
  Entity.render(self)
end

function Player:calculateDistance(point)
  local playerPoint = self.position + Vector2D(self.size.x / 2, self.size.y / 2)
  return (playerPoint - point):magnitude()
end