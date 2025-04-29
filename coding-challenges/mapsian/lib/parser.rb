class Parser
  def initialize(input_stream)
    @input_stream = input_stream
    @robot = Robot.new
    @robot.set_tabletop_dimensions(5, 5)
  end

  PLACE_REGEX = %r{PLACE ([0-9]+),([0-9]+),(#{Robot::FACES.join('|')})}

  def execute(output_stream)
    @input_stream.each_line do |line|
      line.strip!

      if m = line.match(PLACE_REGEX)
        @robot.place([m[1].to_i, m[2].to_i], m[3])
      elsif line == 'MOVE'
        @robot.move
      elsif Robot::DIRECTIONS.include?(line)
        @robot.turn(line)
      elsif line == 'REPORT'
        @robot.report(output_stream)
      end
    end

    output_stream
  end
end
