load 'player.rb'

class PlayerCommandline < Player

  def choose_victim(other_players)
	puts("Choose a player (1 to #{other_players.size}): ")
	incoming = gets.chomp
	#puts("#{incoming}")
	other_players[incoming.to_i-1]
  end

  def seek_algorithm
    puts("Choose a rank: ")
    incoming = gets.chomp
    #puts("#{incoming}")
  end


end