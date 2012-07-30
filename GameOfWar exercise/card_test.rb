require 'test/unit'
load 'card.rb'

class CardTest < Test::Unit::TestCase
    def test_equals
		ace_spades = Card.new("A","spades")
		ace_spades2 = Card.new("A","spades")
		assert_equal(ace_spades,ace_spades2)
		two_clubs = Card.new("2","clubs")
		two_spades = Card.new("2","spades")
		assert_not_equal(ace_spades,two_clubs)
		assert_not_equal(two_spades,two_clubs)
		assert_not_equal(ace_spades,"some string")
    end

end
