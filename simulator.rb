class Robot
  attr_reader :bearing, :coordinates

  DIRECTIONS = [:north, :east, :south, :west]

  def initialize
    @bearing = ''
    @coordinates = [0, 0]
  end 

  def orient(direction)
    if DIRECTIONS.include?(direction)
      @bearing = direction
    else
      raise ArgumentError.new("invalid direction given")
    end   
  end 

  def turn_right
    new_bearing_idx = DIRECTIONS.index(@bearing) + 1
    new_bearing_idx = 0 if new_bearing_idx == 4
    self.orient(DIRECTIONS.at(new_bearing_idx))
  end  

  def turn_left
    new_bearing_idx = DIRECTIONS.index(@bearing) - 1
    new_bearing_idx = 3 if new_bearing_idx == -1
    self.orient(DIRECTIONS.at(new_bearing_idx))
  end 

  def at(x, y) 
    @coordinates = [x, y]
  end 

  def advance
    case @bearing
    when :north
      self.at(@coordinates[0], @coordinates[1] + 1)
    when :south 
      self.at(@coordinates[0], @coordinates[1] - 1) 
    when :east
      self.at(@coordinates[0] + 1, @coordinates[1])
    when :west
      self.at(@coordinates[0] - 1, @coordinates[1]) 
    end     
  end 
end 

class Simulator

  MOVEMENTS = { "L" => :turn_left, "R" => :turn_right, "A" => :advance}

  def initialize
    @instructions_list = []
  end  

  def instructions(commands)
    @instructions_list = []
    commands.each_char do |command|
      @instructions_list << MOVEMENTS[command]
    end 
    return @instructions_list 
  end 

  def place(robot, placement = {})
    robot.at(placement[:x], placement[:y])
    robot.orient(placement[:direction])
  end 

  def evaluate(robot, commands) 
    @instructions_list = instructions(commands)
    move_robot(robot, @instructions_list)
  end 

  private
  
  def move_robot(robot, instructions_list) 
    instructions_list.each do |instruction|
      robot.send(instruction)
    end
  end    
end 