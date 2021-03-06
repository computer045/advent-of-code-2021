class Octopus
  attr_reader :energy, :flashes
  def initialize(energy)
    @energy = energy
    @flashes = 0
    @can_flash = true
  end
  def to_s
    return @energy
  end
  def energize
    if @can_flash then
      @energy += 1
    end
  end
  def flash
    @flashes += 1
    @energy = 0
    @can_flash = false
  end
  def reset
    @can_flash = true
  end
end

def step(octopuses)
  octopuses.each do |line|
    line.each do |column|
      column.reset()
    end
  end
  octopuses.each do |line|
    line.each do |column|
      column.energize()
    end
  end
  return octopuses
end

def propagate(octopuses)
  step_indexes = []
  octopuses.each_index do |line|
    octopuses[line].each_index do |column|
      if (octopuses[line][column].energy > 9) then
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
    if octopuses[pos_y][pos_x].energy > 9 then
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
      if octopuses[pos_y][pos_x].energy > 9 then
        energize_around(octopuses, pos_x, pos_y)
      end
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
  return count
  #return octopuses.map{|l| l.map(&:to_s) }
end

def is_full_flash?(step_octo)
  count = 0
  step_octo.each do |line|
    line.each do |column|
      if column.energy == 0 then
        count += 1
      end
    end
  end
  return count == (step_octo.count * step_octo[0].count)
end

def part2(octopuses)
  flash_step = -1
  index = 0
  while flash_step == -1 do
    octopuses = propagate(step(octopuses))
    index += 1
    if is_full_flash?(octopuses) then
      flash_step = index
    end
  end
  return index
end

def main
  octopuses1 = File.readlines('./input.txt').map(&:chomp).map {|l| l.chars }.map{ |s| s.map { |c| Octopus.new(c.to_i) } }
  octopuses2 = octopuses1.map{ |l| l.map(&:clone) }
  puts part1(octopuses1, 100)
  puts part2(octopuses2)
end

main