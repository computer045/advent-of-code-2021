def part1(input)
  return get_corruption_score(get_corrupted_indexes(input))
end

def part2(input)
  corrupted_lines = get_corrupted_lines(input, get_corrupted_indexes(input))
  incomplete_lines = input.difference(corrupted_lines)
  return get_incomplete_score(incomplete_lines)
end

def get_incomplete_score(lines)
  openers = ['(', '[', '{', '<']
  closers = [')', ']', '}', '>']
  scores = []
  lines.each do |line|
    total_score = 0
    temp = []
    line.each do |separator|
      if not openers.index(separator).nil? then
        temp.push(separator)
      elsif not closers.index(separator).nil? then
        temp.pop
      end
    end
    temp.reverse_each do |separator|
      total_score = (total_score * 5) + get_separator_score2(closers[openers.index(separator)])
    end
    scores.push(total_score)
  end
  return scores.sort[(scores.count.to_f / 2)]
end

def get_separator_score2(separator)
  score = 0
  case separator
  when ')'
    score = 1
  when ']'
    score = 2
  when '}'
    score = 3
  when '>'
    score = 4
  end
  return score
end

def get_corrupted_lines(lines, indexes)
  corrupted_lines = []
  indexes.each do |i|
    corrupted_lines.push(lines[i[:index]])
  end
  return corrupted_lines
end

def get_corrupted_indexes(input)
  openers = ['(', '[', '{', '<']
  closers = [')', ']', '}', '>']
  corrupted_indexes = []
  index = 0
  input.each do |line|
    temp = []
    line.each do |separator|
      if not openers.index(separator).nil? then
        temp.push(separator)
      elsif not closers.index(separator).nil? then
        if openers.index(temp[-1]) == closers.index(separator) then
          temp.pop
        else
          corrupted_indexes.push({'index': index, 'separator': separator})
          break
        end
      end
    end
    index += 1
  end
  return corrupted_indexes
end

def get_corruption_score(indexes)
  total_score = 0
  indexes.each do |i|
    total_score += get_separator_score(i[:separator])
  end
  return total_score
end

def get_separator_score(separator)
  score = 0
  case separator
  when ')'
    score = 3
  when ']'
    score = 57
  when '}'
    score = 1197
  when '>'
    score = 25137
  end
end

def main
  input = File.readlines('./input.txt').map(&:chomp).map {|l| l.chars }

  puts part1(input)
  puts part2(input)
end

main