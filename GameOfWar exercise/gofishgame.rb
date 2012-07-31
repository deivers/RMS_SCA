load 'player_robot.rb'
load 'player_commandline.rb'
load 'deck.rb'

class GoFishGame
    attr_reader :players, :deck

    def initialize(number_players)
	  @deck = CardDeck.new
	  @players = []
	  (number_players-1).times do
		@players << PlayerRobot.new("")
	  end
	  @players << PlayerCommandline.new("")			# human player
	  @current_player = @players[0]
    end

    def setup_cards
	  deck.shuffle
	  deck.deal_n_cards(players,5)
    end

    def manage_turn
	  victim = @current_player.choose_victim(other_players)
	  success = @current_player.seek_from(victim, @current_player.seek_algorithm)
	  @current_player.update_books
	  if !success
		go_fish
		@current_player = victim
	  end
    end

    def go_fish
	  @current_player.add_card(deck.remove_top_card)
	  @current_player.update_books
    end

    def is_over?
	  return deck.number_of_cards==0 || players.any? {|player| player.number_of_cards==0}
    end

    def other_players  #returns an array list of players other than the current player
	players.reject {|player| player == @current_player}
    end

    #debug methods
    def showAllCards
	  players.each {|player| player.showHand}
    end
end
