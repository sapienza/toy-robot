# frozen_string_literal: true

module ToyRobot
  class CommandCenter
    def initialize(commands, table)
      @commands = commands
      @table = table
    end

    def execute
      execute_robot_commands
    end

    private

    def robot_commands
      @robot_commands = @commands.select { |hash| hash[:subject] == :robot }
    end

    def execute_robot_commands
      robot_commands.each do |command|
        if command[:options]
          robot.public_send(command[:command], command[:options])
        else
          robot.public_send(command[:command])
        end
      end
    end

    def navigator_engine
      @navigator_engine = NavigatorEngine.new(@table)
    end

    def compass_engine
      @compass_engine = CompassEngine.instance
    end

    def robot
      @robot ||= Robot.new(compass_engine, navigator_engine)
    end
  end
end
