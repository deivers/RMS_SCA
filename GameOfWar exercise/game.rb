load 'player.rb'
load 'card.rb'

class WarGame
  def initialize(player1,player2)
    @player1 = player1
    @player2 = player2
  end

  def trick(preplayedCards)
    card1 = @player1.remove_top_card
    card2 = @player2.remove_top_card
    if card1==nil || card2==nil
	self.finish_game(card1,card2,preplayedCards)
    else
	preplayedCards = Array.new unless preplayedCards!=nil
	preplayedCards << card1
	preplayedCards << card2
	#compare the played cards
	#and give the played cards to winner
	if card1 > card2
	  @player1.add_cards_array(preplayedCards)
	elsif card1 < card2
	  @player2.add_cards_array(preplayedCards)
	else #we have a tie - it's war!
	  3.times do
	    preplayedCards << @player1.remove_top_card
	    preplayedCards << @player2.remove_top_card
	  end
	  self.trick(preplayedCards) #recursion
	end
    end
  end

  def finish_game(card1,card2,preCards)
    #game over
    if card1 == nil
	@player2.add_card(card2) unless card2==nil
	@player2.add_cards_array(preCards) unless preCards==nil
	puts("Player 2 wins!")
    elsif card2 == nil
	@player1.add_card(card1)
	@player1.add_cards_array(preCards) unless preCards==nil
	puts("Player 1 wins!")
    end
  end
end
