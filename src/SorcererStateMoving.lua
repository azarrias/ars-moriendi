SorcererStateMoving = Class{__includes = BaseState}

function SorcererStateMoving:init(sorcerer)
  self.sorcerer = sorcerer
  
  self.animation = Animation {
    frames = { FRAMES[sorcerer.texture][1], FRAMES[sorcerer.texture][2] },
    interval = 0.6
  }
end

function SorcererStateMoving:enter(params)
  if self.sorcerer.playerPosition ~= nil then
    self.sorcerer.orientation = self.sorcerer.playerPosition.x < self.sorcerer.position.x 
      and 'left' or 'right'
    self.movingPeriod = 1
  else
    self.sorcerer.orientation = math.random(2) == 1 and 'left' or 'right'
    self.movingPeriod = math.random(5)
  end
    
  self.movingTimer = 0
end

function SorcererStateMoving:update(dt)
  self.movingTimer = self.movingTimer + dt
  self.animation:update(dt)
  
  if self.movingTimer > self.movingPeriod then
    if self.sorcerer.playerPosition ~= nil then
      self.sorcerer.orientation = self.sorcerer.playerPosition.x < self.sorcerer.position.x 
        and 'left' or 'right'
      self.movingPeriod = 1
      self.movingTimer = 0
    elseif math.random(4) == 1 then
      self.sorcerer:changeState('idle', {
        wait = math.random(5)
      })
    else
      self.sorcerer.orientation = math.random(2) == 1 and 'left' or 'right'
      self.movingPeriod = math.random(5)
      self.movingTimer = 0
    end
  
  elseif self.sorcerer.orientation == 'left' then
    self.sorcerer.velocity.x = -SORCERER_MOVING_ACCELERATION * dt
    self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
    local tiles = self.sorcerer.colliders['collider']:checkTileCollisions(self.sorcerer.gameLevel.tileMap)
    
    -- if there are no tiles below or a solid tile on the current direction, check if the player is visible
    if tiles['left-top'] or not tiles['left-bottom'] then
      if self.sorcerer.playerPosition ~= nil then
        self.sorcerer:changeState('idle', {
          wait = 1
        })
      else -- turn around and go
        self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
        self.sorcerer.orientation = 'right'
        self.movingPeriod = math.random(5)
        self.movingTimer = 0
      end
    end
  
  elseif self.sorcerer.orientation == 'right' then
    self.sorcerer.velocity.x = SORCERER_MOVING_ACCELERATION * dt
    self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
    local tiles = self.sorcerer.colliders['collider']:checkTileCollisions(self.sorcerer.gameLevel.tileMap)
    
    -- if there are no tiles below or a solid tile on the current direction, check if the player is visible
    if tiles['right-top'] or not tiles['right-bottom'] then
      if self.sorcerer.playerPosition ~= nil then
        self.sorcerer:changeState('idle', {
          wait = 1
        })
      else -- turn around and go
        self.sorcerer.position.x = self.sorcerer.position.x + self.sorcerer.velocity.x * dt
        self.sorcerer.orientation = 'left'
        self.movingPeriod = math.random(5)
        self.movingTimer = 0
      end
    end
  end
end