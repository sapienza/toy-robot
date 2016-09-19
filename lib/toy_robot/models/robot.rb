# frozen_string_literal: true

require 'observer'

module ToyRobot
  class Robot
    include Observable

    attr_reader :x_position, :y_position, :facing
    attr_accessor :navigator_engine

    MAX_WALKING_UNIT = 1

    def initialize(compass_engine, navigator_engine)
      @compass_engine = compass_engine
      @navigator_engine = navigator_engine

      add_observer(navigator_engine)
    end

    def place(options)
      x_position = options.fetch(:x)
      y_position = options.fetch(:y)

      return unless @navigator_engine.valid_position?(x_position, y_position)

      @x_position = x_position
      @y_position = y_position
      @facing = options.fetch(:facing)

      changed && notify_observers(@x_position, @y_position)
    end

    def move(walking_unit = MAX_WALKING_UNIT)
      if !@navigator_engine.on_table? ||
          @navigator_engine.destruction_risk?(walking_unit)

        return
      end

      update_coordinates(walking_unit)
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

    def update_coordinates(walking_unit)
      if walking_directions[:x]
        operator = walking_directions[:x]

        @x_position = @x_position.public_send(operator, walking_unit)
      end

      if walking_directions[:y]
        operator = walking_directions[:y]

        @y_position = @y_position.public_send(operator, walking_unit)
      end

      changed && notify_observers(@x_position, @y_position)
    end

    def walking_directions
      @walking_directions ||= @compass_engine.walking_directions(@facing)
    end
  end
end
