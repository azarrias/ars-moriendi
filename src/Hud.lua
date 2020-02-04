Hud = Class{}

function Hud:init(def)
  self.position = def.position
  self.texture = def.texture
  self.player = def.player
end

function Hud:render()
  for i = 1, self.player.deaths do
    love.graphics.draw(
      TEXTURES['skull'],
      self.position.x + (i - 1) * SKULL_WIDTH + i,
      self.position.y
    )
  end
end  