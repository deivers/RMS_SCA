require 'test/unit'
load 'game.rb'
load 'player.rb'
load 'deck.rb'

class WarTest < Test::Unit::TestCase
  def test_deal
    deck = CardDeck.new
    assert_equal(52, deck.number_of_cards)
    deck.shuffle
    player1 = Player.new
    player2 = Player.new
    deck.deal(player1, player2)
    assert_equal(26, player1.number_of_cards)
    assert_equal(26, player2.number_of_cards)
    player1_top_card = player1.remove_top_card
    assert_equal(25, player1.number_of_cards)
  end

  def test_round_with_clear_winner
    player1 = Player.new
    player2 = Player.new
    game = WarGame.new(player1, player2)
    #set up player1's hand with dominant cards
    player1.add_cards_string("AS KS")
    #set up player2's hand
    player2.add_cards_string("QS JS")
    game.trick(nil)
    assert_equal(3,player1.number_of_cards)
    assert_equal(1,player2.number_of_cards)
    #check the order of player1's cards - K should be on top
    assert_equal(13,player1.remove_top_card.rank)
    #so now we know the player's set of cards is behaving like a queue
  end

  def test_round_with_preplayed
    player1 = Player.new
    player2 = Player.new
    game = WarGame.new(player1, player2)
    #set up player1's hand with dominant cards
    player1.add_cards_string("AS")
    #set up player2's hand
    player2.add_cards_string("QS")
    #play the trick/round
    game.trick([Card.new("8","clubs"),Card.new("9","clubs")]) # 2 cards are already on the table
    #check that the winner takes all cards from the table
    assert_equal(4,player1.number_of_cards)
    assert_equal(0,player2.number_of_cards)
  end

  def test_round_with_tie_but_not_enough_cards_to_complete
    player1 = Player.new
    player2 = Player.new
    game = WarGame.new(player1, player2)
    #set up player1's hand
    player1.add_cards_string("AS KS QS JS")
    #set up player2's hand
    player2.add_cards_string("AC 10C 9C 8C 7C")
    #play the trick/round
    game.trick(nil)
    # player 2 wins because player 1 runs out of cards
    assert_equal(0,player1.number_of_cards)
    assert_equal(9,player2.number_of_cards)
  end

  def test_round_with_tie_recursion
    player1 = Player.new
    player2 = Player.new
    game = WarGame.new(player1, player2)
    #set up player1's hand
    player1.add_cards_string("AS KS QS JS KH")
    #set up player2's hand
    player2.add_cards_string("AC 9C 8C 7C 6C")
    #play the trick/round
    game.trick(nil)
    # player 1 wins
    assert_equal(10,player1.number_of_cards)
    assert_equal(0,player2.number_of_cards)
  end
end
