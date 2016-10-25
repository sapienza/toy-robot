# frozen_string_literal: true

module ToyRobot
  class InvalidTableSize < StandardError; end

  class Table
    attr_accessor :robot
    attr_reader :x_range, :y_range

    def initialize(options)
      x_range = options.fetch(:x_range)
      y_range = options.fetch(:y_range)

      validate_position!(x_range, y_range)

      @x_range = x_range
      @y_range = y_range
    end

    def validate_position!(x_range, y_range)
      unless x_range.positive? && y_range.positive?
        raise InvalidTableSize, 'Table sizes have to be bigger than 0'
      end
    end
  end
end
