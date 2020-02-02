Entity = Class{}

function Entity:init(def)
  self.position = def.position
  self.velocity = Vector2D(0, 0)
  self.size = def.size
  self.texture = def.texture
  self.stateMachine = def.stateMachine
end

function Entity:update(dt)
  self.stateMachine:update(dt)
end

function Entity:render()
  self.stateMachine.current.animation:draw(
    TEXTURES[self.texture], 
    -- shift the character half its width and height, since the origin must be at the sprite's center
    math.floor(self.position.x) + self.size.x / 2, 
    math.floor(self.position.y) + self.size.y / 2,
    0, 1, 1,
    -- set origin to the sprite center (to allow reversing it through negative scaling)
    self.size.x / 2, self.size.y / 2
  )
end

function Entity:changeState(state, params)
  self.stateMachine:change(state, params)
end