# frozen_string_literal: true

module ToyRobot
  # Internal: The NavigatorEngine is a layer which works as a midfield
  # between the Table and the Robot. It decouples from Robot the validations
  # regarding the table
  class NavigatorEngine
    def initialize(table)
      @table = table
      @robot_x_position = nil
      @robot_y_position = nil
    end

    # Internal: Receives positions from a robot through the
    # Observable pattern.
    def update(x_position, y_position)
      @robot_x_position = x_position
      @robot_y_position = y_position
    end

    # Internal: validates if the robot can make the move.
    # Valid positions are considered those inside the table
    # zeros are considered corners thus they are allowed too.
    def valid_position?(x, y)
      !negative_positions?(x, y) && positions_inside_table?(x, y)
    end

    def on_table?
      !@robot_x_position.nil? && !@robot_y_position.nil?
    end

    private

    def negative_positions?(x, y)
      x.negative? || y.negative?
    end

    def positions_inside_table?(x, y)
      x <= @table.x_range && y <= @table.y_range
    end
  end
end
