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
  -- if one is found, there is a 10% chance of spawning a sorcerer on that column
  local MIN_LENGTH = 4
  local groundHeights = {}
  
  for x = PLAYER_STARTING_X + 3, self.tileMap.width - (PLAYER_STARTING_X + 2) do
    
    for y = 1, TOP_GROUND_TILE_Y do
      
      if self.tileMap.tiles[y][x].id ~= TILE_ID_EMPTY then
        -- this height has previous contiguous tiles
        if groundHeights[y] then
          
          if groundHeights[y][#groundHeights[y]] == x - 1 
            and self.tileMap.tiles[y - 1][x].id == TILE_ID_EMPTY then
              table.insert(groundHeights[y], x)
          else -- this height has no more contiguous tiles
            
            if #groundHeights[y] >= MIN_LENGTH then
              local randX = math.random(groundHeights[y][1] + 1, 
                groundHeights[y][#groundHeights[y]] - 1)
              
              -- instantiate sorcerer, must declare it first so it can be passed into the state machine
              local sorcerer
              sorcerer = Sorcerer({
                position = Vector2D(randX * TILE_WIDTH - SORCERER_WIDTH, (y - 1) * TILE_HEIGHT - SORCERER_HEIGHT),
                size = Vector2D(SORCERER_WIDTH, SORCERER_HEIGHT),
                texture = 'sorcerer',
                stateMachine = StateMachine {
                  ['idle'] = function() return SorcererStateIdle(sorcerer) end,
                  ['moving'] = function() return SorcererStateMoving(sorcerer) end,
                  ['casting'] = function() return SorcererStateCasting(sorcerer) end
                },
                gameLevel = self,
                pivotPoint = Vector2D(4, SORCERER_HEIGHT * 0.5)
              })
          
              local sorcererCollider = Collider {
                center = Vector2D(4, SORCERER_HEIGHT * 0.5),
                size = Vector2D(8, SORCERER_HEIGHT)
              }
              sorcerer:addCollider('collider', sorcererCollider)
          
              sorcerer:changeState('idle', {
                wait = math.random(3)
              })
            
              table.insert(self.entities, sorcerer)
            end
            
            groundHeights[y] = nil
          end
        elseif self.tileMap.tiles[y - 1][x].id == TILE_ID_EMPTY then
          groundHeights[y] = { x }
        end
      end
    end
  end
end
