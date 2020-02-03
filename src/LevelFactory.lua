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
      tiles[y][x] = Tile(x, y, TILE_ID_GROUND)
    end
  end
  
  local tileMap = TileMap(tiles)
  
  return GameLevel(tileMap)
end