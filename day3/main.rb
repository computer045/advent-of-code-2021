def part1(numbers)
  counters = get_counters(numbers)
  return get_gamma_rate(counters) * get_epsilon_rate(counters)
end

def part2(numbers)
  size = numbers[0].length - 1
  return get_oxygen_generator_rating(numbers, size) * get_co2_scrubber_rating(numbers, size)
end

def get_oxygen_generator_rating(numbers, size)
  for i in 0..(size - 1) do
    counter = get_counters(numbers)[i]
    search_value = counter[:zeros] > counter[:ones] ? 0 : 1
    if (numbers.size > 1) then
      numbers = filter_numbers(numbers, i, search_value)
    else
      break
    end
  end
  return numbers[0].to_i(2)
end

def get_co2_scrubber_rating(numbers, size)
  for i in 0..(size - 1) do
    counter = get_counters(numbers)[i]
    search_value = counter[:zeros] <= counter[:ones] ? 0 : 1
    if (numbers.size > 1) then
      numbers = filter_numbers(numbers, i, search_value)
    else
      break
    end
  end
  return numbers[0].to_i(2)
end

def filter_numbers(numbers, position, search_value)
  new_numbers = []
  numbers.each do |num|
    if num[position].to_i == search_value then
      new_numbers.push(num)
    end
  end
  return new_numbers
end

def get_counters(numbers)
  counters = Array.new((numbers[0].length - 1)) {{:zeros => 0, :ones => 0}}
  numbers.each do |num|
    index = 0
    num.each_char do |c|
      case c
      when '0'
        counters[index][:zeros] += 1
      when '1'
        counters[index][:ones] += 1
      end
      index += 1
    end
  end
  return counters
end

def get_gamma_rate(counters)
  str_gamma = ''
  counters.each do |counter|
    str_gamma += counter[:zeros] > counter[:ones] ? '0' : '1' 
  end
  return str_gamma.to_i(2)
end

def get_epsilon_rate(counters)
  str_epsilon = ''
  counters.each do |counter|
    str_epsilon += counter[:zeros] < counter[:ones] ? '0' : '1' 
  end
  return str_epsilon.to_i(2)
end

def main
  numbers = File.readlines('./input.txt')
  puts part1(numbers)
  puts part2(numbers)
end

main
