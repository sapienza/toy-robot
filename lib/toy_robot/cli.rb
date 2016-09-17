# frozen_string_literal: true
module ToyRobot
  class CLI < Thor
    desc 'execute', 'executes given commands'

    option :instructions_file,
           required: true,
           banner: './example-data/instructions-1.txt'

    def execute
      'Hello World!'
    end
  end
end
