class Robot
  attr_reader :bearing

  ORDERED_DIRECTIONS = [:north, :east, :south, :west]

  def orient(direction)
    if ORDERED_DIRECTIONS.include?(direction)
      @bearing = direction
    else
      raise ArgumentError.new("invalid direction given")
    end   
  end 

  def turn_right
    new_bearing_idx = ORDERED_DIRECTIONS.index(@bearing) + 1
    new_bearing_idx = 0 if new_bearing_idx == ORDERED_DIRECTIONS.length
    self.orient(ORDERED_DIRECTIONS.at(new_bearing_idx))
  end  

  def turn_left
    new_bearing_idx = ORDERED_DIRECTIONS.index(@bearing) - 1
    new_bearing_idx = ORDERED_DIRECTIONS.length - 1 if new_bearing_idx == -1
    self.orient(ORDERED_DIRECTIONS.at(new_bearing_idx))
  end 

  def at(x, y) 
    @x = x
    @y = y
  end 

  def coordinates
    [@x, @y]
  end  

  def advance
    case @bearing
    when :north then @y += 1
    when :south then @y -= 1
    when :east then @x += 1
    when :west then @x -= 1
    end     
  end 
end 

class Simulator

  MOVEMENTS = { "L" => :turn_left, "R" => :turn_right, "A" => :advance}

  def instructions(commands)
    commands.each_char.map { |command| MOVEMENTS[command] }
  end 

  def place(robot, placement = {})
    robot.at(placement[:x], placement[:y])
    robot.orient(placement[:direction])
  end 

  def evaluate(robot, commands) 
    instructions(commands).each { |instruction| move_robot(robot, instruction) }
  end 

  private
  
  def move_robot(robot, instruction) 
      robot.send(instruction)
  end    
end 