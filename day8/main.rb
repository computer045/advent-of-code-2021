def part1(input)
  count = 0
  input.each do |line|
    for d in line[-4,4] do
      if get_digit(d) > -1 then
        count += 1
      end
    end
  end
  return count
end

def part2(input)
  sum = 0
  outputs = []
  input.each do |line|
    found = ''
    values = line[-4,4]
    template = get_template(line)
    values.each do |v|
      found += template.find{ |t| t[:combination].chars.sort == v.chars.sort }[:digit].to_s
    end
    outputs.push(found.to_i)
  end
  return outputs.sum
end

def get_template(input)
  template = []
  for combination in input.take(10) do
    template.push({'combination': combination, 'digit': get_digit(combination)})
  end
  template.each do |temp|
    if temp[:digit] == -1 then
      segments1 = template.find { |t| t[:digit] == 1 }
      segments4 = template.find { |t| t[:digit] == 4 }
      case temp[:combination].length
      when 5
        if temp[:combination].chars.intersection(segments1[:combination].chars).count == 2 then
          temp[:digit] = 3
        elsif temp[:combination].chars.intersection(segments4[:combination].chars).count == 3 then
          temp[:digit] = 5
        else
          temp[:digit] = 2
        end
      when 6
        if temp[:combination].chars.intersection(segments1[:combination].chars).count == 2 then
          if temp[:combination].chars.intersection(segments4[:combination].chars).count == 4 then
            temp[:digit] = 9
          else
            temp[:digit] = 0
          end
        else
          temp[:digit] = 6
        end
      end
    end
  end
  template.sort_by! { |r| r[:digit] }
  return template
end

def get_digit(combination)
  digit = -1
  case combination.length
  when 2
    digit = 1
  when 3
    digit = 7
  when 4
    digit = 4
  when 7
    digit = 8
  end
  return digit
end

def main
  input = File.readlines('./input.txt').map(&:chomp).map { |l| l.scan(/\w+/) }

  puts part1(input)
  puts part2(input)
end

main