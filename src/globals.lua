-- 3rd party libraries
push = require 'libs.push'
Class = require 'libs.class'

-- include
require 'Animation'
require 'BaseState'
require 'Entity'
require 'GameStatePlay'
require 'GameStateStart'
require 'LevelFactory'
require 'Player'
require 'PlayerStateIdle'
require 'PlayerStateJumping'
require 'PlayerStateMoving'
require 'StateMachine'
require 'Tile'
require 'TileMap'
require 'util'
require 'Vector2D'

--[[
    constants
  ]]
-- coordinates
TOP_GROUND_TILE_Y = 7
PLAYER_STARTING_X = 3
PLAYER_STARTING_Y = 6

-- tile ID constants
TILE_ID_EMPTY = 1 -- transparent sprite
TILE_ID_GROUND = 4 -- normal ground sprite
  
-- resolution
WINDOW_WIDTH, WINDOW_HEIGHT = 840, 480
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 84, 48

-- sprite pixels
PLAYER_WIDTH, PLAYER_HEIGHT = 6, 6
TILE_WIDTH, TILE_HEIGHT = 6, 6

-- physics for entities
PLAYER_MOVING_SPEED = 40
GRAVITY = 6
PLAYER_JUMPING_VELOCITY = -120

-- color palette
COLORS = {
  ['dark'] = { 67 / 255, 82 / 255, 61 / 255 },
  ['light'] = { 199 / 255, 240 / 255, 216 / 255 }
}

-- graphics resources
TEXTURES = {
  ['player'] = love.graphics.newImage('graphics/player.png'),
  ['tiles'] = love.graphics.newImage('graphics/tiles.png')
}

FRAMES = {
  ['player'] = GenerateQuads(TEXTURES['player'], PLAYER_WIDTH, PLAYER_HEIGHT),
  ['tiles'] = GenerateQuads(TEXTURES['tiles'], TILE_WIDTH, TILE_HEIGHT)
}