# frozen_string_literal: true

module ToyRobot
  # Public: Class responsible for the commands parsing
  #
  # instructions_path - directory of the instructions file
  class Parser
    def initialize(instructions_path, adapter: Adapters::InstructionsFromTxt)
      @instructions_path = instructions_path
      @adapter = adapter
    end

    # Public: Parse given commands into a friendly interface with
    # the subject who should receive the message.
    #
    # Examples
    #   .parse
    # =>[
    #     {
    #       command: :place, options: { x:0, y:5, facing: :north },
    #       subject: :robot
    #     },
    #     { command: :move, options: nil, subject: :robot },
    #     { command: :report, options: nil, subject: :robot },
    #   ]
    #
    # Returns an array of hashes
    def parse
      instructions_array.inject([]) do |collection, instruction|
        collection << ParserCommand.new(instruction).normalize
      end
    end

    private

    def instructions_array
      @adapter.new(@instructions_path).execute
    end
  end
end
