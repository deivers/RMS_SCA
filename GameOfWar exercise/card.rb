class Card
  #rank and suit should be read-only except for the constructor

  def initialize(rank, suit)
    @suit = parse_suit(suit)
    @rank = parse_rank(rank)
    #puts("card created: #{@rank.to_s} #{@suit.to_s}")
  end

  def rank
    @rank
  end

  def suit
    @suit
  end

  def to_s
	@rank.to_s + "" + @suit.to_s
  end

  def > other
    return true unless other.class == self.class
    self.rank > other.rank
  end

  def < other
    return true unless other.class == self.class
    self.rank < other.rank
  end

  def equal_rank(rank)
    @rank == parse_rank(rank)
  end

  def parse_suit(suit)
	#assume arg is a string
	#puts("parsed suit: #{suit[0].upcase}")
	suit[0].upcase
  end
  def parse_rank(rank)
    #allow a String to be passed in, but represent internally as a Number
    if rank.class == String
	if rank[0] == "A" || rank == "a"
	  return 14
	elsif rank[0] == "K" || rank == "k"
	  return 13
	elsif rank[0] == "Q" || rank == "q"
	  return 12
	elsif rank[0] == "J" || rank == "j"
	  return 11
	else
	  return rank.to_i
	end
    end
    return rank
  end
end
