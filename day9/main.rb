def part1(lava_tubes)
  low_points = []
  lava_tubes.each_index do |y|
    lava_tubes[y].each_index do |x|
      if check_low_point(lava_tubes, x, y) then
        low_points.push(lava_tubes[y][x])
      end
    end
  end
  return low_points.map{ |lp| lp += 1 }.sum
end

def part2(input)
  return 0
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
  lava_tubes = input.map{ |c| c.map(&:to_i) }

  puts part1(lava_tubes)
  #puts part2(lava_tubes)
end

main