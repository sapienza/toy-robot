# frozen_string_literal: true

require 'singleton'

module ToyRobot
  # Internal: Responsible for cardinal points and which way to go

  # It works as a simple compass:
  ######## NORTH #################
  # WEST ######### EAST###########
  ######## SOUTH #################

  # But can be extend such as:
  ############ NORTH #############
  ####### NW ########## NE #######
  # WEST #################### EAST
  ####### SW ########## SE #######
  ############ SOUTH #############
  class CompassEngine
    include Singleton

    COORDINATES = {
      north: { y: :+ },
      east: { x: :+ },
      south: { y: :- },
      west: { x: :- }
    }.freeze

    private_constant :COORDINATES

    # Internal: information about which is the next or previous
    # cardinal point following a counterclockwise direction
    #
    # current_direction - The symbol of the current cardinal_point
    #
    # Examples
    #
    #   walking_directions(:north)
    #   # => { y: :+ }
    #
    #   walking_directions(:west)
    #   # => { x: :- }
    #
    # Returns a Hash with the axis and its operator
    def walking_directions(current_direction)
      COORDINATES[current_direction]
    end

    # Internal: information about which is the next or previous
    # cardinal point following a counterclockwise direction
    #
    # current_direction - The symbol of the current cardinal_point
    #
    # Examples
    #
    #   left_cardinal_name(:north)
    #   # => :west
    #
    #   left_cardinal_name(:west)
    #   # => :south
    #
    # Returns the cardinal Symbol.
    def left_cardinal_name(current_direction)
      COORDINATES.keys[left_cardinal_index(current_direction)]
    end

    # Internal: information about which is the next or previous
    # cardinal point following a clockwise direction
    #
    # current_direction - The symbol of the current cardinal_point
    #
    # Examples
    #
    #   right_cardinal_name(:north)
    #   # => :east
    #
    #   right_cardinal_name(:east)
    #   # => :south
    #
    # Returns the cardinal Symbol.
    def right_cardinal_name(current_direction)
      return COORDINATES.keys.first if last_coordinate?(current_direction)

      COORDINATES.keys[right_cardinal_index(current_direction)]
    end

    private

    def right_cardinal_index(current_direction)
      current_index(current_direction) + 1
    end

    def left_cardinal_index(current_direction)
      current_index(current_direction) - 1
    end

    def current_index(current_direction)
      COORDINATES.keys.index(current_direction)
    end

    def last_coordinate?(current_direction)
      last_direction_index = COORDINATES.length - 1

      COORDINATES.keys.index(current_direction) == last_direction_index
    end
  end
end
