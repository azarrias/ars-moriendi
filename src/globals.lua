-- 3rd party libraries
push = require 'libs.push'
Class = require 'libs.class'

-- include
require 'Animation'
require 'BaseState'
require 'Entity'
require 'GameStatePlay'
require 'GameStateStart'
require 'Player'
require 'PlayerStateIdle'
require 'PlayerStateMoving'
require 'StateMachine'
require 'util'
require 'Vector2D'

--[[
    constants
  ]]
  
-- resolution
WINDOW_WIDTH, WINDOW_HEIGHT = 840, 480
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 84, 48

-- sprite pixels
PLAYER_WIDTH, PLAYER_HEIGHT = 6, 6

-- physics for entities
PLAYER_MOVING_SPEED = 40

-- color palette
COLORS = {
  ['dark'] = { 67 / 255, 82 / 255, 61 / 255 },
  ['light'] = { 199 / 255, 240 / 255, 216 / 255 }
}

-- graphics resources
TEXTURES = {
  ['player'] = love.graphics.newImage('graphics/player.png')
}

FRAMES = {
  ['player'] = GenerateQuads(TEXTURES['player'], PLAYER_WIDTH, PLAYER_HEIGHT)
}