def get_boards_array(input)
  boards = []
  index = -1
  input.each do |line|
    if line.length == 1 then
      boards.push(Array.new)
      index += 1
    else
      boards[index].push(line.scan(/\w+/))
    end
  end
  return boards
end

def get_board_results(board, numbers)
  found = []
  numbers.each do |n|
    index = 0
    board.each do |line|
      if not line.index(n).nil? then
        found.push({ 'line': index, 'column': line.index(n)})
      end
      index += 1
    end
  end
  return found
end

def check_for_win(results, size)
  has_won = false

  # horizontal validation
  results.sort_by! { |r| r[:line] }
  for i in 0..(size - 1) do
    cmpt = 0
    results.each do |res|
      if res[:line].eql? i then
        cmpt += 1
      end
      if cmpt == size then
        has_won = true
      end
      break if has_won
    end
  end

  # vertical validation
  if not has_won then
    results.sort_by! { |r| r[:column] }
    for i in 0..(size - 1) do
      cmpt = 0
      results.each do |res|
        if res[:column] == i then
          cmpt += 1
        end
        if cmpt == size then
          has_won = true
        end
        break if has_won
      end
    end
  end

  return has_won
end

def get_boards_wins(boards, numbers)
  win_steps = []
  index = 0
  boards.each do |board|
    win_steps.push({ 'index': index, 'step': get_board_win_step(board, numbers) })
    index += 1
  end
  return win_steps
end

def get_board_win_step(board, numbers)
  step = 0
  for i in 1..numbers.count do
    drawn_numbers = numbers.take(i)
    if check_for_win(get_board_results(board, drawn_numbers), board.size) then
      step = i
      break
    end
  end
  return step
end

def calculate_score(board, numbers)
  results = get_board_results(board, numbers)
  marked_score = 0
  unmarked_score = 0
  results.each do |res|
    marked_score += board[res[:line]][res[:column]].to_i
  end
  board.each do |line|
    line.each do |column|
      unmarked_score += column.to_i
    end
  end

  return (unmarked_score - marked_score) * numbers.last.to_i
end

def part1(boards, numbers, win)
  winning_board = boards[win[:index]]
  return calculate_score(winning_board, numbers.take(win[:step]))
end

def part2(boards, numbers, win)
  winning_board = boards[win[:index]]
  return calculate_score(winning_board, numbers.take(win[:step]))
end

def main
  input = File.readlines('./input.txt')
  numbers = input.shift.gsub("\n", '').split(',')
  boards = get_boards_array(input)
    
  wins = get_boards_wins(boards, numbers).sort_by { |w| w[:step] }
  puts part1(boards, numbers, wins.first)
  puts part2(boards, numbers, wins.last)
end

main
