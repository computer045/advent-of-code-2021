def part1(depths)
  previous = -1
  cmpt = 0
  depths.each do |measurement|
    measurement = measurement.to_i
    if measurement > previous and previous > -1 then
      cmpt += 1
    end
    previous = measurement
  end
  return cmpt
end

def part2(depths)
  window = []
  previous = -1
  cmpt = 0
  depths.each do |measurement|
    sum = 0
    window.push(measurement.to_i)
    if window.size > 3 then
      window.shift
    end
    if window.size == 3 then
      sum = window.sum
      if sum > previous and previous > -1 then
        cmpt += 1
      end
      previous = sum
    end
  end
  return cmpt
end

def main
  depths = File.readlines('./input.txt').map(&:to_i)
  puts part1(depths)
  puts part2(depths)
end

main
