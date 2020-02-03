LevelFactory = Class{}

function LevelFactory.create(width, height)
  local tiles = {}
  
  -- create 2D table full of transparent tiles
  for y = 1, height do
    table.insert(tiles, {})
    
    for x = 1, width do
      -- keep IDs for whatever quad we want to render
      table.insert(tiles[y], Tile(x, y, TILE_ID_EMPTY))
    end
  end
  
  local startedPlatform = false
  local remainingTiles = 0
  local platformHeight = 0
  local platformCooldown = 0
  
  -- iterate over X at the top level to generate the level in columns instead of rows
  for x = 1, width do
    
    -- 15% random chance to skip this column; i.e. a chasm
    -- 12% random chance for a pillar
    -- 20% random chance for a platform
    local spawnChasm = false
    local spawnPillar = false
    local spawnPlatform = false
    platformCooldown = platformCooldown - 1
    
    if x > PLAYER_STARTING_X + 2 and x < width - (PLAYER_STARTING_X + 2) then
      spawnChasm = math.random(100) <= 15
      spawnPillar = math.random(100) <= 12
      
      if not startedPlatform and platformCooldown <= 0 then
        spawnPlatform = math.random(100) <= 12
        if spawnPlatform  then
          startedPlatform = true
          remainingTiles = math.random(2, 10)
          platformHeight = math.random(3, 4)
        end
      end
    end 
    
    if spawnPlatform then
      local scale = Vector2D(-1, 1)
      tiles[platformHeight][x] = Tile(x, platformHeight, TILE_ID_GROUND_CORBEL, scale)
      remainingTiles = remainingTiles - 1
      spawnPlatform = false
    elseif startedPlatform and remainingTiles > 1 then
      tiles[platformHeight][x] = Tile(x, platformHeight, TILE_ID_GROUND)
      remainingTiles = remainingTiles - 1
    elseif startedPlatform then
      tiles[platformHeight][x] = Tile(x, platformHeight, TILE_ID_GROUND_CORBEL)
      startedPlatform = false
      platformCooldown = 3
    end

    if spawnChasm then
      -- workaround for lua missing the 'continue' statement
      goto continue
    end
    
    if spawnPillar then
      for y = 5, 6 do
        tiles[y][x] = Tile(x, y, TILE_ID_GROUND)
      end
    end
    
    -- always generate ground
    for y = TOP_GROUND_TILE_Y, height do
      local tileId = TILE_ID_GROUND
      local scale = Vector2D(1, 1)
      -- introduce random variations within the ground tiles
      -- use different quads and randomize rotation
      if math.random(15) == 1 then
        tileId = TILE_ID_GROUND_VARIATIONS[math.random(#TILE_ID_GROUND_VARIATIONS)]
        scale = Vector2D(math.random(1, 2) * 2 - 3 or 1, math.random(1, 2) * 2 - 3 or 1)
      end
      tiles[y][x] = Tile(x, y, tileId, scale)
    end
    
    ::continue::
  end
  
  local tileMap = TileMap(tiles)
  
  return GameLevel(tileMap)
end