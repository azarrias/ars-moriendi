push = require 'libs.push'

local MOBILE_OS = (love._version_major > 0 or love._version_minor >= 9) and (love.system.getOS() == 'Android' or love.system.getOS() == 'OS X')
local WEB_OS = (love._version_major > 0 or love._version_minor >= 9) and love.system.getOS() == 'Web'
local WINDOW_WIDTH, WINDOW_HEIGHT = 840, 480
local VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 84, 48
local GAME_TITLE = 'Ars moriendi'
--local FONT_SIZE = 8

function love.load()
  if arg[#arg] == "-debug" then 
    require("mobdebug").start() 
  end
  
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
  
  font = love.graphics.newImageFont('fonts/nokia-3310-classic.png',
    "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 $€£¥¤+-*/=%\"'#@&_(),.;:?!\\|[]<>{}`^~")

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
  love.graphics.clear(67 / 255, 82 / 255, 61 / 255)
  love.graphics.scale(2)
  love.graphics.setColor(199 / 255, 240 / 255, 216 / 255)
  love.graphics.printf('Ars', 0, 20 / 2, VIRTUAL_WIDTH / 2, 'center')
  push:finish()
  
  push:start()
  love.graphics.setColor(199 / 255, 240 / 255, 216 / 255)
  love.graphics.printf('moriendi', 0, 36, VIRTUAL_WIDTH, 'center')
  push:finish()
end