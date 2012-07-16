load 'card.rb'

class CardDeck
  @@suits = %w(clubs diamonds hearts spades)
  @@ranks = %w(2 3 4 5 6 7 8 9 10 J Q K A)

  def initialize
    @cards = []
    @@suits.each do |suit|
	@@ranks.each do |rank|
	  @cards << Card.new(rank, suit)
	end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal(player1, player2)
    26.times do
	player1.add_card(@cards.pop)
	player2.add_card(@cards.pop)
    end
  end

  def deal_n_cards(players, number_cards_each_player=1)
    #assume there are enough cards remaining
    number_cards_each_player.times do
	players.each do |player|
	  player.add_card(@cards.pop)
	end
    end
  end

  def remove_top_card
    @cards.pop
  end

  def number_of_cards
	return @cards.size
  end

  def clear
	@cards.clear
  end
end
