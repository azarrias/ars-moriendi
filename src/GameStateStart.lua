GameStateStart = Class{__includes = BaseState}

function GameStateStart:init()
  self.text = {
    { scale = 2, string = 'Ars' },
    { scale = 1, string = 'moriendi' }
  }
end

function GameStateStart:render()
  RenderCenteredText(self.text)
end