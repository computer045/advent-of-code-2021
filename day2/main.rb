def part1(instructions)
  h_pos = 0
  depth = 0

  instructions.each do |i|
    instruction = Hash[ [:command, :value].zip(i.split(/\s+/,2)) ]
    case instruction[:command]
    when 'forward'
      h_pos += instruction[:value].to_i
    when 'up'
      depth -= instruction[:value].to_i
    when 'down'
      depth += instruction[:value].to_i
    end
  end

  return h_pos * depth
end

def part2(instructions)
  h_pos = 0
  depth = 0
  aim = 0

  instructions.each do |i|
    instruction = Hash[ [:command, :value].zip(i.split(/\s+/,2)) ]
    case instruction[:command]
    when 'forward'
      h_pos += instruction[:value].to_i
      depth += aim * instruction[:value].to_i
    when 'up'
      aim -= instruction[:value].to_i
    when 'down'
      aim += instruction[:value].to_i
    end
  end
  return h_pos * depth
end

def main
  instructions = File.readlines('./input.txt')
  puts part1(instructions)
  puts part2(instructions)
end

main
