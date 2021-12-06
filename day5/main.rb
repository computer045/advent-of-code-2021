class Point
  attr_reader :x, :y
  
  def initialize(x, y)
    @x = x
    @y = y
  end

  def to_s
    return "(#{@x}, #{@y})"
  end
end

class Vector
  attr_reader :point1, :point2, :direction

  def initialize(point1, point2)
    @point1 = point1
    @point2 = point2
    
    if point1.x == point2.x then
      @direction = :vertical
    elsif point1.y == point2.y then
      @direction = :horizontal
    else
      @direction = :diagonal
    end
  end

  def to_s
    return "(#{@point1}, #{@point2})"
  end

  def get_line()
    line = []

    x_delta = @point2.x - @point1.x
    y_delta = @point2.y - @point1.y
    len = [x_delta.abs, y_delta.abs].max

    dir_x = x_delta == 0 ? 0 : x_delta.positive? ? 1 : -1
    dir_y = y_delta == 0 ? 0 : y_delta.positive? ? 1 : -1

    for i in 0..len do
      line.push(Point.new((@point1.x + (dir_x * i)), (@point1.y + (dir_y * i))))
    end
    return line
  end
end

def part1(vectors)
  return count_intersections(vectors)
end

def part2(vectors)
  return count_intersections(vectors)
end

def count_intersections(vectors)
  grid = Array.new(1000) { Array.new(1000, 0) }
  vectors.each do |v|
    v.get_line.each do |p|
      grid[p.x][p.y] += 1
    end
  end
  cmpt = 0
  grid.each do |line|
    cmpt += line.count { |n| n >= 2 }
  end
  return cmpt
end

def main
  input = File.readlines('./input.txt').map(&:chomp)
  vectors = []
  vectors_diag = []
  input.each do |line|
    points = line.split(' -> ').map { |p| p = p.split(',', 2); Point.new(p[0].to_i, p[1].to_i)}
    v = Vector.new(points[0], points[1])
    if v.direction != :diagonal then
      vectors.push(v)
    end
    vectors_diag.push(v)
  end
  puts part1(vectors)
  puts part2(vectors_diag)
end

main
