GameStateTitle = Class{__includes = BaseState}

function GameStateTitle:init()
  self.title = {
    { scale = 2, string = 'Ars' },
    { scale = 1.5, string = 'moriendi' }
  }
  
  self.texts = {}
  self.texts[1] = {{string = 'They say that'}, {string = 'ignorance is'}, {string = 'bliss...'}}
  self.texts[2] = {{string = 'but see how'}, {string = 'far that has'}, {string = 'led you'}}
  self.texts[3] = {{string = 'The only way'}, {string = 'for you to'}, {string = 'escape this'}, {string = 'prison of'}, {string = 'a life...'}}
  self.texts[4] = {{string = 'is by'}, {string = 'mastering'}, {string = 'the craft of'}, {string = 'dying'}}
  self.text = self.texts[1]
  self.counter = 1
  
  self.timer = 0
end

function GameStateTitle:update(dt)
  if love.keyboard.keysPressed['enter'] or love.keyboard.keysPressed['return'] 
    and self.counter <= #self.texts then
      self.counter = self.counter + 1
      self.timer = 0
  end
    
  self.timer = self.timer + dt
    
  if self.counter <= #self.texts then
    self.text = self.texts[self.counter]
      
  elseif self.counter == #self.texts + 1 then
    self.text = {{ string = '' }}
    if self.timer > 0.7 then
      self.text = self.title
      self.counter = self.counter + 1
      self.timer = 0
    end
      
  elseif self.counter == #self.texts + 2 then
    if self.timer > 2 then
      self.counter = self.counter + 1
      self.timer = 0
    end
      
  else
    self.text = {{ string = '' }}
    if self.timer > 0.5 then
      gameStateMachine:change('start', { level = 1 })
    end
  end
end  

function GameStateTitle:render()
  RenderCenteredText(self.text)
end