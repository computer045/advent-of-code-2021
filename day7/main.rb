def part1(crabs)
  crabs.sort!
  i = (crabs.count / 2) - 1
  median = crabs.count.even? ? (crabs[i.floor] + crabs[i.ceil]) / 2 : crabs[i]
  fuel_sum = 0
  crabs.each do |c|
    fuel_sum += (c - median).abs
  end
  return fuel_sum
end

def part2(crabs)
  fuel_sums = []
  for i in 0..crabs.max do
    sum = 0
    crabs.each do |c|
      sum += (1..(c - i).abs).sum
    end
    fuel_sums.push(sum)
  end
  return fuel_sums.min
end

def main
  input = File.readlines('./input.txt').map(&:chomp)[0].split(',').map(&:to_i)

  puts part1(input)
  puts part2(input)
end

main
