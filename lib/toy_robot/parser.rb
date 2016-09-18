# frozen_string_literal: true

module ToyRobot
  class InvalidCommandError < StandardError; end

  class Parser
    # Public: Class responsible for the commands parsing
    #
    # instructions_path - directory of the instructions file
    #
    def initialize(instructions_path, adapter: Adapters::InstructionsFromTxt)
      @instructions_path = instructions_path
      @adapter = adapter
    end

    # Public: Parse given commands into a friendly interface with
    # the subject who should receive the message, the message itself
    # and args if inluded. This configuration creates extensibility
    # not just for commands related to the robot, but also for the table or
    # any other subject.
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
      # TODO: To much responsability here!
      # Many of the code bellow should me refactored
      # to a class who represents a single command
      # and know how to build it

      collection = []

      instructions_array.each do |instruction|
        has_whitespace = instruction.match(/\s/)

        if has_whitespace
          instruction_info = instruction.gsub(/\s+/m, ':').strip.split(':')
          command = instruction_info[0]

          # BUILD ARGS
          options = instruction_info[1].split(',')

          unless COMMANDS[command]['options']
            raise InvalidCommandError,
                  "#{command} does not support options!"
          end

          options_hash = Hash[options.each_with_index.map do |value, index|
            [COMMANDS[command]['options'][index], value]
          end]
        else
          command = instruction
        end

        unless COMMANDS.include?(command)
          raise InvalidCommandError, "Invalid command: #{command}"
        end

        subject = COMMANDS[command]['subject']

        collection << { command: command, options: options_hash, subject: subject }
      end

      collection
    end

    private

    attr_reader :adapter, :instructions_path

    def instructions_array
      adapter.new(instructions_path).execute
    end

    def instructions_info
      instruction.gsub(/\s+/m, ':').strip.split(':')
    end
  end
end
