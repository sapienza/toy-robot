# frozen_string_literal: true

module ToyRobot
  class CLI < Thor
    desc 'execute', 'executes given commands'

    option :instructions_file,
           required: true,
           banner: './example_data/instructions_1.txt'

    def execute
      CommandCenter.new(commands, table).execute

      true
    end

    private

    def table
      @table = Table.new(x_range: 5, y_range: 5)
    end

    def commands
      @commands ||= Parser.new(options[:instructions_file]).parse
    end
  end
end
