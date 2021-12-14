class Octopus
  attr_reader :step, :flashes
  def initialize(step)
    @step = step
    @flashes = 0
  end
  def to_s
    return @step
  end
  def energize
      @step += 1
  end
  def flash
    @flashes += 1
    @step = 0
  end
end

def step(octopuses)
  octopuses.each do |line|
    line.each do |column|
      column.energize()
    end
  end
  return octopuses
end

def propagate(octopuses)
  octopuses.each_index do |line|
    octopuses[line].each_index do |column|
      if (octopuses[line][column].step > 9) then
        octopuses = energize_around(octopuses, column, line)
      end
    end
  end
  return octopuses
end

def energize_around(octopuses, pos_x, pos_y)
  if not octopuses[pos_y].nil? and
    not octopuses[pos_y][pos_x].nil? and
    pos_y >= 0 and pos_x >= 0 and
    pos_x < octopuses[0].count and pos_y < octopuses.count then
    if octopuses[pos_y][pos_x].step > 9 then
      octopuses[pos_y][pos_x].flash
      energize_around(octopuses, (pos_x + 1), pos_y)
      energize_around(octopuses, (pos_x - 1), pos_y)
      energize_around(octopuses, pos_x, (pos_y + 1))
      energize_around(octopuses, pos_x, (pos_y - 1))
      energize_around(octopuses, (pos_x + 1), (pos_y + 1))
      energize_around(octopuses, (pos_x + 1), (pos_y - 1))
      energize_around(octopuses, (pos_x - 1), (pos_y + 1))
      energize_around(octopuses, (pos_x - 1), (pos_y - 1))
    else
      octopuses[pos_y][pos_x].energize
    end
  end
  
  return octopuses
end

def part1(octopuses, nb_steps)
  for i in 1..nb_steps do
    octopuses = propagate(step(octopuses))
  end
  count = 0
  octopuses.each do |line|
    line.each do |column|
      count += column.flashes 
    end
  end

  #return count
  return octopuses
end

def part2(input)
  return 0
end

def main
  input = File.readlines('./input.txt').map(&:chomp).map {|l| l.chars }.map{ |s| s.map { |c| Octopus.new(c.to_i) } }
  small_input = <<~TEXT
    5483143223
    2745854711
    5264556173
    6141336146
    6357385478
    4167524645
    2176841721
    6882881134
    4846848554
    5283751526
  TEXT
  small_input = small_input.split("\n").map(&:chomp).map {|l| l.chars }.map{ |s| s.map { |c| Octopus.new(c.to_i) } }
  #puts part1(input)
  pp part1(small_input, 2)
  #puts part2(input)
end

main