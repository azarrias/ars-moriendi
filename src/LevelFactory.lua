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
    -- always generate ground
    for y = TOP_GROUND_TILE_Y, height do
      local tileId = TILE_ID_GROUND
      local isVariation = false
      -- introduce random variations within the ground tiles
      if math.random(15) == 1 then
        tileId = TILE_ID_GROUND_VARIATIONS[math.random(#TILE_ID_GROUND_VARIATIONS)]
        isVariation = true
      end
      tiles[y][x] = Tile(x, y, tileId, isVariation)
    end
  end
  
  local tileMap = TileMap(tiles)
  
  return GameLevel(tileMap)
end