def position_taken?(board, index)
  !(board[index].nil? || board[index] == " " || board[index] == "" )
end


WIN_COMBINATIONS = [
  [0,1,2], # Top row
  [3,4,5], # Middle row
  [6,7,8], # Bottom row
  [0,3,6], # column 1
  [1,4,7], # column 2
  [2,5,8], # column 3
  [0,4,8], # diagonal 1
  [2,4,6]  # diagonal 2
]


#jkkjkkk
def won?(board)
  WIN_COMBINATIONS.detect do |win|
    board[win[0]] == board[win[1]] &&
    board[win[1]] == board[win[2]] &&
    position_taken?(board, win[0])
  end
end



def full?(board)
    board.all? do |position|
    if position == "X" || position == "O"
      true
   else
     false
   end
 end
end



def draw?(board)
   if !won?(board) && full?(board)
     true  #draw
  else
    false
 end
end


def over?(board)
  if full?(board) || draw?(board) || won?(board)
    true
  else
    false
end
end


def winner(board)
   if !won?(board)
      return nil
    else
   return board[won?(board)[0]]
 end
end


def display_board(board)
   puts " #{board[0]} " + "|"  + " #{board[1]} " + "|"  +  " #{board[2]} "
   puts "-----------"
   puts " #{board[3]} " + "|"  + " #{board[4]} " + "|"  +  " #{board[5]} "
   puts "-----------"
   puts " #{board[6]} " + "|"  + " #{board[7]} " + "|"  +  " #{board[8]} "
end


def input_to_index(user_input)
  index = user_input.to_i
  index -= 1
  return index
end


def move(board,index,char )
  board[index] = char
  return board
end



def valid_move?(board, position)

  if position_taken?(board, position) == true
      false
      puts "Position is taken. Please re-enter."
 elsif position.to_i.between?(0, 8)
      true
  else
    false
  end
end



def turn(board)
  puts "Please enter 1-9:"
  display_board(board)
  integer_input = gets.strip
  position = input_to_index(integer_input)
  if valid_move?(board, position)
    move(board, position, current_player(board))
  else
    turn(board)
  end

end


def turn_count(board)
  turns = 0
      board.each do |position|
      if position != " "
        turns += 1
    end
  end

  return turns
end


#current_player
def current_player(board)
   if turn_count(board).even?
     return "X"
   else
     return "O"
  end
end


def play(board)

  until over?(board)
     turn(board)
  end

if won?(board)
   puts  "Congratulations #{winner(board)}!"
 elsif draw?(board)
  puts "Cats Game!"
end
end
