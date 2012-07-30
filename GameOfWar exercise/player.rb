class Player
  attr_reader :cards

  def initialize
    @cards = []
    @books = []
  end

  def add_card(card)
    cards.unshift(card)
    #update_books
  end

  def add_cards_array(card_array)
    return unless card_array
    card_array.each do |card|
	self.add_card(card)
    end
  end

  def add_cards_string(str)
    return unless str
    self.add_cards_array(interpret_string(str))
  end

  def number_of_cards
	cards.size
  end

  def number_of_books
	@books.size
  end

  def remove_top_card
	cards.pop
  end

  def remove_cards_of_rank(r)
    cards_removed = cards.select {|card| card.equal_rank(r)}
    cards.delete_if {|card| card.equal_rank(r)}
    return cards_removed
  end

  def choose_victim(other_players)
	#return a player from this list
  end

   def seek_from(victim_player,desired_rank)
    stolen_cards = victim_player.remove_cards_of_rank(desired_rank)
    add_cards_array(stolen_cards)
    return stolen_cards.size > 0
  end

  def seek_algorithm
	#return the desired rank
  end

  def update_books
    #move sets of 4 of equal rank from cards array to a single element in book array
    (2..14).each {|rank_iterator|
	  result = cards.select {|card| card.rank==rank_iterator}
	  if result.size == 4
		puts("found a book!")
		@books << cards.select {|card| card.rank==rank_iterator}
		cards.delete_if {|card| card.rank==rank_iterator}
	  end
    }
  end

  #helper methods
  def interpret_string(str)
	hash = str.scan(/([1]*[AKQJakqj0-9])[-_]*([HCDShcds]\w*)\s*/)
	#puts("number parsed: #{hash.size}")
	hash.collect {|subarray|
	    #puts("#{subarray[0]} #{subarray[1]}")
	    Card.new(subarray[0], subarray[1])}
  end
  #test case for the above - see http://rubular.com/r/nY0KhIxVTM
  #  AH 4C 2D 2C
  #  Jd 2h
  #  K-Hearts Q-Clubs
  #  jD qH
  #  j-h q-c
  #  A_diamonds 2_hearts
  #  A-clubs 3-hearts

  #debug methods
  def showHand
	handString = cards.each {|card| card.to_s}
	puts(handString.join(" "))
	puts("\n")
  end


end
