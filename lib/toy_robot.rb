# frozen_string_literal: true

# Internal libs
require 'yaml'

# External libs
require 'thor'

# CLI
require 'toy_robot/cli'

# Adapters
require 'toy_robot/adapters/instructions_from_txt.rb'

# Parser
require 'toy_robot/parser'
require 'toy_robot/parser_command'

# Models
require 'toy_robot/models/table'
require 'toy_robot/models/navigator_engine'
require 'toy_robot/models/robot'
require 'toy_robot/models/command_center'

# Singletons
require 'toy_robot/singletons/compass_engine'

# App Constants
APP_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
COMMANDS = YAML.load(File.read("#{APP_ROOT}/config/commands.yml"))

module ToyRobot; end
