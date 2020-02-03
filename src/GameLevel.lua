GameLevel = Class{}

function GameLevel:init(tileMap)
  self.tileMap = tileMap
  self.entities = {}
end

function GameLevel:update(dt)
  self.tileMap:update(dt)
  
  for k, entity in pairs(self.entities) do
    entity:update(dt)
  end
end

function GameLevel:render()
  self.tileMap:render()
  
  for k, entity in pairs(self.entities) do
    entity:render(dt)
  end
end

--[[
    Randomly adds a series of enemies to the level
]]
function GameLevel:spawnEnemies()
  -- spawn sorcerers in the level
  -- check for each column if there is a ground tile
  -- if one is found, there is a 5% chance of spawning a sorcerer on that column
  for x = 1, self.tileMap.width do
    
    local groundFound = false
    
    for y = 1, self.tileMap.height do
      if not groundFound then
        if self.tileMap.tiles[y][x].id == TILE_ID_GROUND then
          groundFound = true
          
          if math.random(20) == 1 then
            
            -- instantiate sorcerer, must declare it first so it can be passed into the state machine
            local sorcerer
            sorcerer = Sorcerer({
              position = Vector2D(x * TILE_WIDTH - SORCERER_WIDTH, (y - 1) * TILE_HEIGHT - SORCERER_HEIGHT),
              size = Vector2D(SORCERER_WIDTH, SORCERER_HEIGHT),
              texture = 'sorcerer',
              stateMachine = StateMachine {
                ['idle'] = function() return SorcererStateIdle(sorcerer) end,
                ['moving'] = function() return SorcererStateMoving(sorcerer) end,
                ['casting'] = function() return SorcererStateCasting(sorcerer) end
              },
              gameLevel = self
            })
          
            sorcerer:changeState('idle', {
              wait = math.random(5)
            })
            
            table.insert(self.entities, sorcerer)
          end
          
          -- once that ground has been found and processed, we can skip the rest of the column
          break
        end
      end
    end
  end
end