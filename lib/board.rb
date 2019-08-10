require_relative 'colorize.rb'

class Board
  def initialize
    @board_state = Array.new(6) { Array.new(7, {"\u262E" => 'yellow'})}
    @filled_columns = []
  end

  attr_accessor :board_state, :filled_columns

  def print_board
    @board_state.each do |a| 
      a.each { |obj| print "#{ obj.keys[0].encode.send(obj[obj.keys[0]] ) } "} 
      puts
    end
    puts "1 2 3 4 5 6 7"
  end

  def where_the_disc_falls(column)
    row = 5
    @board_state.each_with_index do |arr, i|
      if arr[column].keys[0] != "\u262E" 
        row = i - 1
        
        break
      end
    end
    @filled_columns.push(column) if row == 0
    row
  end

  def set_piece(y, x, active_player)
    @board_state[y][x] = player_symbol(active_player)
  end

  def check_if_winning_move(y, x)
    directions = [[[-1, 0], [1, 0]], [[-1, -1], [1, 1]], [[0, -1], [0, 1]], [[1, -1], [-1, 1]]]
    puts "#{y},#{x}"
    is_a_winner = directions.any? do |dir_arr|
     row_total = direction_count(y, x, dir_arr[0][0], dir_arr[0][1]) + direction_count(y, x, dir_arr[1][0], dir_arr[1][1]) - 1
     row_total >= 4
    end
  end
  
  def direction_count(y, x, d1, d2)
    counter = 0
    matcher = @board_state[y][x]
    while @board_state[y][x] == matcher
      y += d1
      x += d2
      counter += 1
  
      break if @board_state[y].nil?
    end
    counter
  end

  def player_symbol(active_player)
    active_player == 0 ? {"\u26A3" => "light_blue"} : {"\u26A2" => "pink"}
  end
end

