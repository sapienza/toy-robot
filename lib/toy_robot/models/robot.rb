# frozen_string_literal: true

require 'observer'

module ToyRobot
  class Robot
    include Observable

    attr_reader :x_position, :y_position, :facing

    MAX_WALKING_UNIT = 1

    def initialize(compass_engine, navigator_engine)
      @compass_engine = compass_engine
      @navigator_engine = navigator_engine

      add_observer(navigator_engine)
    end

    def place(options)
      x_position = options.fetch(:x).to_i
      y_position = options.fetch(:y).to_i

      return unless @navigator_engine.valid_position?(x_position, y_position)

      @x_position = x_position
      @y_position = y_position
      @facing = options.fetch(:facing).to_sym

      changed && notify_observers(@x_position, @y_position)
    end

    def move(walking_unit = MAX_WALKING_UNIT)
      return unless @navigator_engine.on_table?

      directions = desirable_directions(walking_unit)
      unless @navigator_engine.valid_position?(directions[:x], directions[:y])
        return
      end

      update_coordinates(directions)
    end

    def left
      return unless @navigator_engine.on_table?

      @facing = @compass_engine.left_cardinal_name(@facing)
    end

    def right
      return unless @navigator_engine.on_table?

      @facing = @compass_engine.right_cardinal_name(@facing)
    end

    def report
      return unless @navigator_engine.on_table?

      puts "#{@x_position},#{@y_position},#{@facing}"
    end

    private

    def walking_directions
      @compass_engine.walking_directions(@facing)
    end

    def desirable_directions(walking_unit)
      directions = walking_directions

      {
        x: x_destination(directions, walking_unit),
        y: y_destination(directions, walking_unit)
      }
    end

    def update_coordinates(desirable_directions)
      @x_position = desirable_directions[:x]
      @y_position = desirable_directions[:y]

      changed && notify_observers(@x_position, @y_position)
    end

    def x_destination(directions, walking_unit)
      return @x_position unless directions[:x]

      @x_position.public_send(directions[:x], walking_unit)
    end

    def y_destination(directions, walking_unit)
      return @y_position unless directions[:y]

      @y_position.public_send(directions[:y], walking_unit)
    end
  end
end
