GameStateStart = Class{__includes = BaseState}

function GameStateStart:init()
  self.timer = 0
  self.counter = 1
end

function GameStateStart:enter(param)
  SOUNDS['start-level']:stop()
  SOUNDS['start-level']:play()
  self.level = param.level
  self.text = {{ string = 'Chapter ' .. param.level }}
end

function GameStateStart:update(dt)
  self.timer = self.timer + dt
  
  if self.counter == 1 and self.timer > 1.5 then
    self.text = {{ string = '' }}
    self.timer = 0
    self.counter = self.counter + 1
  elseif self.counter == 2 and self.timer > 0.3 then
    gameStateMachine:change('play', { level = self.level })
  end
end

function GameStateStart:render()
  RenderCenteredText(self.text)
end