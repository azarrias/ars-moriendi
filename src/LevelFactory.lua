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
  
  -- iterate over X at the top level to generate the level in columns instead of rows
  for x = 1, width do
    
    -- 15% random chance to skip this column; i.e. a chasm
    -- 12% random chance for a pillar
    local spawnChasm = false
    local spawnPillar = false
    
    if x > PLAYER_STARTING_X + 2 and x < width - (PLAYER_STARTING_X + 2) then
      spawnChasm = math.random(100) < 15
      spawnPillar = math.random(100) < 12
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