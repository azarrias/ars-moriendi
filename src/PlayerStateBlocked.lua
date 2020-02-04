PlayerStateBlocked = Class{__includes = BaseState}

function PlayerStateBlocked:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][3] },
  }
end

function PlayerStateBlocked:enter()
  -- self.player.velocity.y = 0
  
  local tile = self.player.gameLevel.tileMap:pointToTile(self.player.position)
  local leftSideLimit = math.max(1, tile.position.x - 3)
  local rightSideLimit = math.min(tile.position.x + 3, self.player.gameLevel.tileMap.width)
  local targetTileFound = false
  local randX
  local targetY
  
  while not targetTileFound do
    randX = math.random(leftSideLimit, rightSideLimit)
    --local groundFound = false
    
    for y = 1, self.player.gameLevel.tileMap.height do
      if not groundFound then
        if self.player.gameLevel.tileMap.tiles[y][randX].id ~= TILE_ID_EMPTY then
          targetTileFound = true
          targetY = y
          --groundFound = true
          break
        end
      end
    end
  end
  
  Timer.tween(1.2, {
    [self.player.position] = { 
      x = randX * TILE_WIDTH - PLAYER_WIDTH, 
      y = (targetY - 1) * TILE_HEIGHT - PLAYER_HEIGHT 
    }
  })
  :finish(function()
    self.player:changeState('idle')
  end)

end

function PlayerStateBlocked:update(dt)
  Timer.update(dt)
end