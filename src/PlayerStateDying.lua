PlayerStateDying = Class{__includes = BaseState}

function PlayerStateDying:init(player)
  self.player = player
  
  self.animation = Animation {
    frames = { FRAMES[player.texture][1] }
  }
  
  self.newTile = nil
end

function PlayerStateDying:enter(params)
  self.player.deaths = self.player.deaths + 1  
  
  local x = math.floor(params.dyingX / TILE_WIDTH) + 1
  local y = self.player.gameLevel.tileMap.height + 1
  self.newTile = Tile(x, y, TILE_ID_GROUND)
  self.player.gameLevel.tileMap.tiles[TOP_GROUND_TILE_Y][x] = self.newTile
  
  Timer.after(0.5, function()
    Timer.tween(0.5, {
      [self.newTile.position] = { y = TOP_GROUND_TILE_Y }
    })
    : finish(function()
        if self.player.deaths == 5 then
          if self.player.gameLevel.level == 5 then
            gameStateMachine:change('game-over')
          else
            gameStateMachine:change('start', {level = self.player.gameLevel.level + 1})
          end
        else
          Timer.tween(math.floor(x / 7), {
            [self.player.position] = { x = PLAYER_STARTING_X * TILE_WIDTH - PLAYER_WIDTH }
          })
          : finish(function()
              Timer.tween(1, {
                [self.player.position] = { y = PLAYER_STARTING_Y * TILE_HEIGHT - PLAYER_HEIGHT }
              })
              : finish(function()
                  self.player:changeState('idle')
                end)
            end)
        end
      end)
  end) 
end

function PlayerStateDying:update(dt)
  Timer.update(dt)
end