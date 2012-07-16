load 'player.rb'

class PlayerRobot < Player


  def choose_victim(other_players)
    #for now, simply random:
	other_players.sample #use this if running ruby version 1.9x
  end

  def seek_algorithm
    #temporary algorithm
    if cards.size == 0		#should never happen because the game would have already ended
	desired_rank = 2
    else
	desired_rank = cards.first.rank
    end
  end



end
