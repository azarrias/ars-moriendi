Player = Class{}

function Player:init(def)
  self.position = def.position
  self.size = def.size
  self.texture = def.texture
  self.animation = Animation {
    frames = { FRAMES[def.texture][1], FRAMES[def.texture][2] },
    interval = 0.3
  }
end

function Player:update(dt)
  self.animation:update(dt)
end

function Player:render()
  self.animation:draw(
    TEXTURES[self.texture], 
    -- shift the character half its width and height, since the origin must be at the sprite's center
    math.floor(self.position.x) + self.size.x / 2, 
    math.floor(self.position.y) + self.size.y / 2,
    0, 1, 1,
    -- set origin to the sprite center (to allow reversing it through negative scaling)
    self.size.x / 2, self.size.y / 2
  )
end