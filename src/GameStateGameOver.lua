GameStateGameOver = Class{__includes = BaseState}

GameStateTitle = Class{__includes = BaseState}

function GameStateGameOver:init()
  self.text = {{ string = 'You did it'}, {string = 'You are...'}, {string = 'really dead...' }}
  self.timer = 0
end

function GameStateGameOver:update(dt)
  self.timer = self.timer + dt
  if self.timer > 3 then
    self.text = {{ string = '' }}
  end
end  

function GameStateGameOver:render()
  RenderCenteredText(self.text)
end