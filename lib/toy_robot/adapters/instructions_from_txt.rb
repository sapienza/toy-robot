# frozen_string_literal: true

module ToyRobot
  module Adapters
    class InstructionsFromTxt
      def initialize(instructions_path)
        @instructions_path = instructions_path
      end

      # Internal: Split instructions
      #
      # file_path - directory of the instructions file
      #
      # Examples
      #   .execute
      #   =>["PLACE 0,0,NORTH", "MOVE", "REPORT"]
      #
      # Returns an array with each line of instruction
      def execute
        instructions = File.open(@instructions_path).read

        instructions.split("\n").map(&:downcase)
      end
    end
  end
end
