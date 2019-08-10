 require_relative 'interface.rb'
 require_relative 'board.rb'
 require_relative 'players.rb'

class Game
  include Interface

  def initialize
    @players = [Players.new('one'), Players.new('two')]
   
    explain_rules(@players[0].name, @players[1].name)
    @board = Board.new 
    @whos_turn = 1
    @game_over = false
    game_cycle
  end
  attr_accessor :players

  def game_cycle
    until @game_over
      switch_turns
      @board.print_board
      column = get_column_choice(@players[@whos_turn].name, (@board.filled_columns.map {|c| c + 1})).to_i - 1
      row = @board.where_the_disc_falls(column)
      @board.set_piece(row, column, @whos_turn)
      @board.print_board
      check_for_game_over(row, column)
    end
  end

  def check_for_game_over(y, x)
    if @board.check_if_winning_move(y, x)
      puts "#{@players[@whos_turn].name} wins!"
      @game_over = true
      play_again
    elsif @board.filled_columns.length == 7
      puts "It's a draw!"
      @game_over = true
    end
  end


  def switch_turns
    @whos_turn = 1 - @whos_turn 
  end
end