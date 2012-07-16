require 'test/unit'
load 'gofishgame.rb'
load 'deck.rb'
load 'card.rb'

class GoFishTest < Test::Unit::TestCase
    def setup
    end
    def test_distribute_cards
	  game = GoFishGame.new(4)
	  assert_equal(4,game.players.size)
	  game.setup_cards
	  assert_equal(5,game.players[0].number_of_cards)
	  assert_equal(5,game.players[3].number_of_cards)
    end
    def test_card_rank
	  card1 = Card.new("A","clubs")
	  assert_equal(true, card1.equal_rank("A"))
	  assert_equal(true, card1.equal_rank("14"))		#String
	  assert_equal(true, card1.equal_rank(14))		#Number
    end
    def test_card_suit
	  card1 = Card.new("A","C")
	  assert_equal("C", card1.suit)
	  card2 = Card.new("A","clubs")
	  assert_equal("C", card2.suit)
	  assert_equal("14 C",card2.to_s)
    end
    def test_player_cards_from_string
	  player1 = PlayerRobot.new
	  player1.add_cards_string("AH 4C 2D 2C Jd 2h 10s")
	  assert_equal(7, player1.number_of_cards)
	  player1.add_cards_string("K-Hearts Q-Clubs jD qH 5-h q-c A_diamonds 3_hearts 6-clubs 7-hearts")
	  assert_equal(17, player1.number_of_cards)		#caution: books may be automatically created in player1, which decreases the card count
    end
    def test_turn_with_requested_card_exists
	  player1 = PlayerRobot.new
	  player2 = PlayerRobot.new
	  player1.add_cards_string("AH")
	  player2.add_cards_string("AC")
	  player1.seek_from(player2,player1.seek_algorithm)
	  #player1.add_cards_array(player2.remove_cards_of_rank("A"))
	  #card should have moved from player2 to player1
	  assert_equal(2,player1.number_of_cards)
	  assert_equal(0,player2.number_of_cards)
    end
    def test_turn_with_requested_card_absent
	  player1 = PlayerRobot.new
	  player2 = PlayerRobot.new
	  player2.add_cards_string("AC")
	  assert_equal(0,player1.number_of_cards)
	  stolen_cards = player2.remove_cards_of_rank("K")
	  assert_equal(0,stolen_cards.size)		#verify no cards of rank K found
	  player1.add_cards_array(player2.remove_cards_of_rank("K"))
	  assert_equal(0,player1.number_of_cards)	#verify no cards removed
    end
    def test_game_turn_with_requested_card_present
	  game = GoFishGame.new(4)
	  game.players[0].add_cards_string("AC")		#this player will ask for Aces
	  game.players[1].add_cards_string("AH")
	  game.players[2].add_cards_string("AS")
	  game.players[3].add_cards_string("AD")
	  game.manage_turn
	  assert_equal(2, game.players[0].number_of_cards)
	  assert_equal(2, sum_of_other_players_cards(game))
    end
    def test_game_turn_with_requested_card_absent
	  game = GoFishGame.new(4)
	  game.players[0].add_cards_string("10C")		#this player will ask for 10's
	  game.players[1].add_cards_string("AH")
	  game.players[2].add_cards_string("AS")
	  game.players[3].add_cards_string("AD")
	  game.manage_turn
	  assert_equal(2, game.players[0].number_of_cards)
	  assert_equal(3, sum_of_other_players_cards(game))
	  #there are now 5 cards in play, so Game's go_fish method worked
    end
    def test_game_over_when_player_has_no_cards
	  game = GoFishGame.new(4)
	  #note: player[0] has no cards
	  game.players[1].add_cards_string("AH")
	  game.players[2].add_cards_string("AS")
	  game.players[3].add_cards_string("AD")
	  assert_equal(true, game.is_over?)
    end
    def test_game_end_by_running_out_of_cards
	  game = GoFishGame.new(4)
	  game.setup_cards
	  assert_equal(false, game.is_over?)
	  game.deck.clear
	  assert_equal(true, game.is_over?)
    end
    def test_player_creating_books
	  player = PlayerRobot.new
	  player.add_cards_string("AC")
	  player.add_cards_string("AH")
	  player.add_cards_string("AS")
	  player.add_cards_string("AD")
	  player.update_books
	  assert_equal(0, player.number_of_cards)	# because the above creates a book
	  assert_equal(1, player.number_of_books)
	  player.add_cards_string("10C")
	  player.add_cards_string("10H")
	  player.add_cards_string("10S")
	  player.update_books
	  assert_equal(3, player.number_of_cards)
	  assert_equal(1, player.number_of_books)
	  player.add_cards_string("10D")
	  player.update_books
	  assert_equal(0, player.number_of_cards)
	  assert_equal(2, player.number_of_books)
    end
    #todo: test_a_complete_game

    #helper methods
    def sum_of_other_players_cards(game)
	  game.players[1].number_of_cards+game.players[2].number_of_cards+game.players[3].number_of_cards
    end
end
