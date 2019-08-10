require_relative 'interface.rb'

class Players
    include Interface
  def initialize(player_number)
    @name = get_player_name(player_number)
  end
  attr_accessor :name
 
end