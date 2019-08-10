module Interface
  def explain_rules(p_one, p_two)
    puts  "Rules:"
    puts  "#{p_one} and #{p_two} will each pick a color"
    puts  "and taketurns dropping their disks down one"
    puts  "of seven columns.  The first to form a"
    puts  "horizontal, vertical, or diagnal line of"
    puts  "four with their color, wins!"
  end

  def get_player_name(one_or_two)
    puts "What is player #{one_or_two}'s name?"
    name = gets.chomp
  end

  def get_column_choice(player, filled_columns)
    puts filled_columns
    puts "It's your turn, #{player}!"
    choice = 0
    while choice == 0
      puts "Pick a column by its number."
      input = gets.chomp
      
      if filled_columns.include? input.to_i
        puts "That column is full"
        next
      end
      choice = input if (1..7).include? input.to_i
    end
    choice
  end 
end