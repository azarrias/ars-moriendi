-- 3rd party libraries
push = require 'libs.push'
Class = require 'libs.class'
bresenham = require 'libs.bresenham'
Timer = require 'libs.knife.timer'

-- include
require 'Animation'
require 'BaseState'
require 'Camera'
require 'Collider'
require 'Entity'
require 'GameLevel'
require 'GameStatePlay'
require 'GameStateStart'
require 'Hud'
require 'LevelFactory'
require 'Player'
require 'PlayerStateBlocked'
require 'PlayerStateFalling'
require 'PlayerStateIdle'
require 'PlayerStateJumping'
require 'PlayerStateMoving'
require 'Sorcerer'
require 'SorcererStateCasting'
require 'SorcererStateIdle'
require 'SorcererStateMoving'
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
TILE_ID_GROUND_CORBEL = 3 
TILE_ID_GROUND = 4 -- normal ground sprite
TILE_ID_GROUND_VARIATIONS = { 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17 }
TILE_ID_NON_COLLIDABLE = { 1 }
  
-- resolution
WINDOW_WIDTH, WINDOW_HEIGHT = 840, 480
VIRTUAL_WIDTH, VIRTUAL_HEIGHT = 84, 48

-- sprite pixels
PLAYER_WIDTH, PLAYER_HEIGHT = 6, 6
TILE_WIDTH, TILE_HEIGHT = 6, 6
SORCERER_WIDTH, SORCERER_HEIGHT = 11, 7
SKULL_WIDTH = 7

-- physics for entities
PLAYER_MOVING_ACCELERATION = 1600
SORCERER_MOVING_ACCELERATION = 400
GRAVITY = 6
PLAYER_JUMPING_VELOCITY = -120
PLAYER_SORCERER_DETECTION_RANGE = 60

-- color palette
COLORS = {
  ['dark'] = { 67 / 255, 82 / 255, 61 / 255 },
  ['light'] = { 199 / 255, 240 / 255, 216 / 255 }
}

-- graphics resources
TEXTURES = {
  ['player'] = love.graphics.newImage('graphics/player.png'),
  ['tiles'] = love.graphics.newImage('graphics/tiles.png'),
  ['sorcerer'] = love.graphics.newImage('graphics/sorcerer.png'),
  ['skull'] = love.graphics.newImage('graphics/skull.png')
}

FRAMES = {
  ['player'] = GenerateQuads(TEXTURES['player'], PLAYER_WIDTH, PLAYER_HEIGHT),
  ['tiles'] = GenerateQuads(TEXTURES['tiles'], TILE_WIDTH, TILE_HEIGHT),
  ['sorcerer'] = GenerateQuads(TEXTURES['sorcerer'], SORCERER_WIDTH, SORCERER_HEIGHT)
}