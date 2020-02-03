Entity = Class{}

function Entity:init(def)
  self.position = def.position
  self.velocity = Vector2D(0, 0)
  self.size = def.size
  self.texture = def.texture
  self.stateMachine = def.stateMachine
  self.orientation = 'left'
  self.gameLevel = def.gameLevel
  self.colliders = {}
end

function Entity:update(dt)
  self.stateMachine:update(dt)
end

function Entity:render()
  self.stateMachine.current.animation:draw(
    TEXTURES[self.texture], 
    -- shift the character half its width and height, since the origin must be at the sprite's center
    math.floor(self.position.x + self.size.x * 0.5), 
    math.floor(self.position.y + self.size.y * 0.5),
    0, self.orientation == 'right' and 1 or -1, 1,
    -- set origin to the sprite center (to allow reversing it through negative scaling)
    math.floor(self.size.x * 0.5), math.floor(self.size.y * 0.5)
  )
  
  for k, collider in pairs(self.colliders) do
    collider:render()
  end
end

function Entity:changeState(state, params)
  self.stateMachine:change(state, params)
end

function Entity:addCollider(label, collider)
  collider.parent = self
  self.colliders[label] = collider
end