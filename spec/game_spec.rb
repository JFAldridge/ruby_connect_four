require './lib/game.rb'
require './lib/interface.rb'
require './lib/players.rb'
require './lib/board.rb'

describe Interface do
  before(:each) do
    @interface = Class.new
    @interface.extend(Interface)
  end

  describe '#rules' do
    
    it 'explains the rules of the game' do 
      expect { @interface.explain_rules('Patty', 'Wack') }.to output(/Rules:/).to_stdout
    end

    it 'customizes the rules for the players' do
      expect { @interface.explain_rules('Patty', 'Wack') }.to output(/\nPatty and Wack will each pick a color/).to_stdout
    end
  end

  describe '#get_player_name' do
    it 'promps user for name' do
      $stdin = StringIO.new('Bilbo\n')
      expect { @interface.get_player_name('one')}.to output("What is player one's name?\n").to_stdout
    end

    it 'receives name input and returns it' do
      $stdin = StringIO.new('Bilbo\n')
      allow($stdout).to receive(:puts)
      expect(@interface.get_player_name('one')).to eql('Bilbo\n')
    end
  end
end 

describe Board do
  before(:each) do
    @board = Board.new
  end

  it 'creates the desired board' do
    expect(@board.board_state).to eq([[{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}], [{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}], [{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}], [{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}], [{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}], [{"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}, {"\u262E"=>"yellow"}]])
  end

  describe '#where_the_disc_falls' do
    it 'falls to the bottom of an open row' do
      expect(@board.where_the_disc_falls(2)).to eq(5)
    end

    it 'falls on top of existing discs' do
      @board.board_state[5][2] = {"\u26A3" => "light_blue"}
      @board.board_state[4][2] = {"\u26A3" => "light_blue"}
      expect(@board.where_the_disc_falls(2)).to eq(3)
    end

    it 'adds to the @filled_columns array when a column gets filled' do
      @board.board_state[5][3] = {"\u26A3" => "light_blue"}
      @board.board_state[4][3] = {"\u26A3" => "light_blue"}
      @board.board_state[3][3] = {"\u26A3" => "light_blue"}
      @board.board_state[2][3] = {"\u26A3" => "light_blue"}
      @board.board_state[1][3] = {"\u26A3" => "light_blue"}
      @board.where_the_disc_falls(3)
      expect(@board.filled_columns[0]).to eq(3)
    end
  end

  describe '#set_piece' do
    it 'sets the correct hash in the correct spot' do
      @board.set_piece(5, 3, 1)
      expect(@board.board_state[5][3]).to eq({"\u26A2" => "pink"})
    end
  end
  
  describe '#check_if_winning_move' do
    it 'verifies an upwards diagnal of four from the center' do
      @board.board_state[1][5] = {"\u26A3" => "light_blue"}
      @board.board_state[2][4] = {"\u26A3" => "light_blue"}
      @board.board_state[3][3] = {"\u26A3" => "light_blue"}
      @board.board_state[4][2] = {"\u26A3" => "light_blue"}
      expect(@board.check_if_winning_move(3, 3)).to eq(true)
    end

    it 'fails an upwards diagnal of three from the center' do
      @board.board_state[2][4] = {"\u26A3" => "light_blue"}
      @board.board_state[3][3] = {"\u26A3" => "light_blue"}
      @board.board_state[4][2] = {"\u26A3" => "light_blue"}
      expect(@board.check_if_winning_move(3, 3)).to eq(false)
    end

    it 'verifies a downwards diagnal of four from the side' do
      @board.board_state[5][6] = {"\u26A3" => "light_blue"}
      @board.board_state[4][5] = {"\u26A3" => "light_blue"}
      @board.board_state[3][4] = {"\u26A3" => "light_blue"}
      @board.board_state[2][3] = {"\u26A3" => "light_blue"}
      expect(@board.check_if_winning_move(2, 3)).to eq(true)
    end

    it 'fails a downwards diagnal of three from the side' do
      @board.board_state[4][6] = {"\u26A3" => "light_blue"}
      @board.board_state[4][5] = {"\u26A3" => "light_blue"}
      @board.board_state[3][4] = {"\u26A3" => "light_blue"}
      @board.board_state[2][3] = {"\u26A3" => "light_blue"}
      expect(@board.check_if_winning_move(2, 3)).to eq(false)
    end
  end
end





