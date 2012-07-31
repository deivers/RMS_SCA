load 'card.rb'

describe Card, "should be able to set the suit and rank" do
	it "returns 'C' for Ace of clubs" do
		card = Card.new(14,'clubs')
		card.suit.should == 'C'
	end
	it "returns '14' for Ace of clubs" do
	    card = Card.new('A', 'clubs')
	    card.rank.should == 14
	end
end
