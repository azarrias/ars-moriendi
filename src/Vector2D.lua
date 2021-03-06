Vector2D = Class{}

function Vector2D:init(x, y)
  self.x = x
  self.y = y
end

function Vector2D:__add(other)
  return Vector2D(self.x + other.x, self.y + other.y)
end

function Vector2D:__sub(other)
  return Vector2D(self.x - other.x, self.y - other.y)
end

function Vector2D:__tostring()
  return "(" .. self.x .. ", " .. self.y .. ")"
end

function Vector2D:magnitude()
  return math.sqrt(math.pow(self.x, 2) + math.pow(self.y, 2))
end