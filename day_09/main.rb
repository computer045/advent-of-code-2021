class PointValue
  attr_accessor :value
  attr_reader :x, :y
  
  def initialize(x, y, value)
    @x = x
    @y = y
    @value = value
  end

  def to_s
    return "(#{@x}, #{@y}) => #{@value}"
  end
end

def part1(lava_tubes)
  return get_low_points(lava_tubes).map{ |lp| lp.value += 1 }.sum
end

def get_low_points(lava_tubes)
  low_points = []
  lava_tubes.each_index do |y|
    lava_tubes[y].each_index do |x|
      if check_low_point(lava_tubes, x, y) then
        low_points.push(PointValue.new(x, y, lava_tubes[y][x]))
      end
    end
  end
  return low_points
end

def part2(lava_tubes)
  counts = []
  get_low_points(lava_tubes).each do |lp|
    counts.push(get_basin(lava_tubes, lp.x, lp.y))
  end
  return counts.max(3).inject(:*)
end

def get_basin(lava_tubes, pos_x, pos_y)
  cmpt = 0
  if not lava_tubes[pos_y].nil? and
    not lava_tubes[pos_y][pos_x].nil? and
    lava_tubes[pos_y][pos_x] < 9 and
    lava_tubes[pos_y][pos_x] >= 0 and pos_x >= 0 and pos_y >= 0 then
    lava_tubes[pos_y][pos_x] = -1
    cmpt += get_basin(lava_tubes, (pos_x - 1), pos_y)
    cmpt += get_basin(lava_tubes, (pos_x + 1), pos_y)
    cmpt += get_basin(lava_tubes, pos_x, (pos_y + 1))
    cmpt += get_basin(lava_tubes, pos_x, (pos_y - 1))
    cmpt += 1
  else
    return 0
  end
  return cmpt
end

def check_low_point(lava_tubes, pos_x, pos_y)
  is_low_point = false
  value = lava_tubes[pos_y][pos_x]
  check_up = lava_tubes[(pos_y - 1)].nil? ? true : lava_tubes[(pos_y - 1)][pos_x] > value
  check_down = lava_tubes[(pos_y + 1)].nil? ? true : lava_tubes[(pos_y + 1)][pos_x] > value
  check_left = lava_tubes[pos_y][(pos_x - 1)].nil? ? true : lava_tubes[pos_y][(pos_x - 1)] > value
  check_right = lava_tubes[pos_y][(pos_x + 1)].nil? ? true : lava_tubes[pos_y][(pos_x + 1)] > value
  if check_up and check_down and check_left and check_right then
    is_low_point = true
  end
  return is_low_point
end

def main
  input = File.readlines('./input.txt').map(&:chomp).map {|l| l.chars }
  lava_tubes1 = input.map{ |c| c.map(&:to_i) }
  lava_tubes2 = lava_tubes1.map(&:clone)
  puts part1(lava_tubes1)
  puts part2(lava_tubes2)
end

main