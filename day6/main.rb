class Fish
  attr_reader :timer
  def initialize(timer = 8)
    @timer = timer
  end
  def reset_timer
    @timer = 6
  end
  def reduce_timer
    @timer -= 1
  end
end

class School < Fish
  attr_reader :count
  def initialize(count, timer = 8)
    @count = count
    super(timer)
  end
  def to_s
    return "t:#{@timer} c:#{@count}"
  end
end

def get_fishes_count(fishes, days)
  for i in 1..days do
    cmpt = 0
    fishes.each do |f|
      if f.timer == 0 then
        f.reset_timer
        cmpt += f.count
      else
        f.reduce_timer
      end
    end
    if cmpt > 0 then
      fishes.push(School.new(cmpt))
    end
  end
  final_count = 0
  fishes.each do |f|
    final_count += f.count
  end
  return final_count
end

def part1(fishes, days)
  return get_fishes_count(fishes, days)
end

def part2(fishes, days)
  return get_fishes_count(fishes, days)
end

def main
  input = File.readlines('./input.txt').map(&:chomp)[0].split(',').map(&:to_i)
  small_input = [3,4,3,1,2]
  fishes1 = []
  for i in 1..6 do
    if input.count(i) > 0 then
      fishes1.push(School.new(input.count(i), i))
    end
  end
  fishes2 = fishes1.map(&:clone)

  puts part1(fishes1, 80)
  puts part2(fishes2, 256)
end

main