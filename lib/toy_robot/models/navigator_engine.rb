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
      !negative_positions?(x, y) && positions_inside_table?(x, y) && !hole?(x, y)
    end

    def on_table?
      !@robot_x_position.nil? && !@robot_y_position.nil?
    end

    def viable_route?(x, y, visited = [])
      return visit(0, 0)

    end

    def visit(x_, y_, visited = [])
      visited << {x: x_, y: y_}

      if x_ == x && y_ == y
        return true
      end

      moves = possible_moves(x_, y_, visited)

      moves.each do |move|
        visit(move[:x], move[:y], visited)
      end

      false
    end

    def possible_moves(x, y, visited)
      #
    end

    private

    def hole?(x, y)
      @table.holes.include?({x: x, y: y})
    end

    def negative_positions?(x, y)
      x.negative? || y.negative?
    end

    def positions_inside_table?(x, y)
      x <= @table.x_range && y <= @table.y_range
    end
  end
end
