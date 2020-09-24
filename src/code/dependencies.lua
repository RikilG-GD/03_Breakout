-- add main game constants and required libraries
require 'lib/class'
require 'code/utils'
require 'code/constants'

-- add required class files
require 'code/Text'
require 'code/Paddle'
require 'code/Ball'
require 'code/Brick'
require 'code/LevelGenerator'

-- add game state machine files
require 'code/StateMachine'
require 'code/states/BaseState'
require 'code/states/MenuState'
require 'code/states/PaddleSelectState'
require 'code/states/ServeState'
require 'code/states/PlayState'
