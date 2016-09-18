# frozen_string_literal: true

module ToyRobot
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

    def valid_position?(x_desirable_position, y_desirable_position)
      x_desirable_position <= @table.x_range &&
        y_desirable_position <= @table.y_range
    end

    def destruction_risk?(walking_unit)
      desirable_x = @robot_x_position + walking_unit
      desirable_y = @robot_y_position + walking_unit

      desirable_x > @table.x_range || desirable_y > @table.y_range
    end

    def on_table?
      @robot_x_position && @robot_y_position
    end
  end
end
