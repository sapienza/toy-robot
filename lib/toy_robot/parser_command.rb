# frozen_string_literal: true
module ToyRobot
  class ParserCommand
    class InvalidCommandError < StandardError; end

    def initialize(instruction)
      @instruction = instruction
    end

    # Internal: Parse given command into a friendly interface with
    # the subject who should receive the message, the message itself
    # and args if inluded. This configuration creates extensibility
    # not just for commands related to the robot, but also for the table or
    # any other subject.
    #
    # Examples
    #   .normalize
    # =>{
    #     command: :place, options: { x:0, y:5, facing: :north },
    #     subject: :robot
    #   }
    #
    # Returns a hash
    def normalize
      unless COMMANDS.include?(instruction_name)
        raise InvalidCommandError, "Invalid command: #{instruction_name}"
      end

      {
        command: instruction_name.to_sym,
        options: options,
        subject: subject.to_sym
      }
    end

    private

    attr_reader :instruction

    def subject
      COMMANDS[instruction_name]['subject']
    end

    def options
      return unless options?

      unless COMMANDS[instruction_name]['options']
        raise InvalidCommandError, options_not_support_msg
      end

      options_hash
    end

    def options_not_support_msg
      "#{instruction_name} does not support options!"
    end

    def options_hash
      Hash[instructions_options.each_with_index.map do |value, index|
        [COMMANDS[instruction_name]['options'][index].to_sym, value]
      end]
    end

    def instruction_name
      options? ? splitted_instructions[0] : instruction
    end

    def instructions_options
      splitted_instructions[1].split(',')
    end

    def splitted_instructions
      instruction.gsub(/\s+/m, ':').strip.split(':')
    end

    def options?
      instruction.match(/\s/)
    end
  end
end
