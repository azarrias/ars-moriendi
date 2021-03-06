require 'globals'

local MOBILE_OS = (love._version_major > 0 or love._version_minor >= 9) and (love.system.getOS() == 'Android' or love.system.getOS() == 'OS X')
local WEB_OS = (love._version_major > 0 or love._version_minor >= 9) and love.system.getOS() == 'Web'
local GAME_TITLE = 'Ars moriendi'
--local FONT_SIZE = 8

function love.load()
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end
  
  io.stdout:setvbuf("no")
  
  -- use nearest-neighbor (point) filtering on upscaling and downscaling to prevent blurring of text and 
  -- graphics instead of the bilinear filter that is applied by default 
  love.graphics.setDefaultFilter('nearest', 'nearest')
  
  -- Set up window
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = MOBILE_OS,
    resizable = not MOBILE_OS
  })
  love.window.setTitle(GAME_TITLE)
  math.randomseed(os.time())
  
  gameStateMachine = StateMachine {
    ['start'] = function() return GameStateStart() end,
    ['play'] = function() return GameStatePlay() end,
    ['game-over'] = function() return GameStateGameOver() end,
    ['title'] = function() return GameStateTitle() end
  }
  gameStateMachine:change('title')
  
  font = love.graphics.newImageFont('fonts/nokia-3310-classic.png',
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 $€£¥¤+-*/=%\"'#@&_(),.;:?!\\|[]<>{}`^~")
  FONT_HEIGHT = font:getHeight()

  love.graphics.setFont(font)
  os_str = love.system.getOS()
  vmajor, vminor, vrevision, vcodename = love.getVersion()
  v_str = string.format("Version: %d.%d.%d - %s", vmajor, vminor, vrevision, vcodename)
  
  love.keyboard.keysPressed = {}
end

function love.update(dt)
  -- exit if esc is pressed
  if love.keyboard.keysPressed['escape'] then
    love.event.quit()
  end
  
  gameStateMachine:update(dt)
  
  love.keyboard.keysPressed = {}
end

function love.resize(w, h)
  push:resize(w, h)
end
  
-- Callback that processes key strokes just once
-- Does not account for keys being held down
function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
end

function love.draw()
  push:start()
  gameStateMachine:render()
  push:finish()
end