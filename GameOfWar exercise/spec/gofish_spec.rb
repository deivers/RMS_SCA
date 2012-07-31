require_relative '../gofishgame.rb'


describe GoFishGame do
	before(:each) do
	  @game = GoFishGame.new(4)
	end
	context "when a new game is setup" do
		it "should give each player 5 cards" do
		@game.setup_cards
		@game.players[0].number_of_cards.should == 5
		@game.players[3].number_of_cards.should == 5
		end
	end
	context "during a turn in which all players have same rank" do
	  it "should transfer a card from victim to requestor" do
		@game.players[0].add_cards_string("AC")		#this player will ask for Aces
		@game.players[1].add_cards_string("AH")
		@game.players[2].add_cards_string("AS")
		@game.players[3].add_cards_string("AD")
		@game.manage_turn
		@game.players[0].number_of_cards.should == 2
		sum_of_other_players_cards(@game).should == 2
	  end
	end
	context "during a turn in which all players have different rank" do
	  it "requestor must go fish, getting a card from the deck" do
		@game.players[0].add_cards_string("AC")		#this player will ask for Aces
		@game.players[1].add_cards_string("KC")
		@game.players[2].add_cards_string("QC")
		@game.players[3].add_cards_string("JC")
		@game.manage_turn
		@game.players[0].number_of_cards.should == 2
		sum_of_other_players_cards(@game).should == 3
	  end
	end
	context "when a player runs out of cards" do
	  it "should end the game" do
		#note: player[0] has no cards
		@game.players[1].add_cards_string("AH")
		@game.players[2].add_cards_string("AS")
		@game.players[3].add_cards_string("AD")
		@game.is_over?.should be_true
	  end
	end
	context "commandline player asking for rank from a player (and card is present)" do
		it "should steal that card from the other player" do
			player_mock = double("player")
			PlayerCommandline.stub(:seek_algorithm => 14)
			player_mock = PlayerCommandline.new("")
			victim = PlayerRobot.new("")
			victim.add_cards_string("AC")
			player_mock.seek_from(victim, player_mock.seek_algorithm).should be_true
		end
	end
 end

describe Card do
	subject {Card.new("A","clubs")}
	context "when a new card is created" do
	  it "should return the rank that was set" do
		subject.rank.should == 14
		subject.equal_rank("A").should == true
		subject.equal_rank("14").should == true
	  end
	  it "should return the suit that was set" do
		subject.suit.should == "C"
	  end
	end

end

describe PlayerRobot do
	before(:each) do
	  @player1 = PlayerRobot.new("")
	  @player2 = PlayerRobot.new("")
	end
	context "when given a stack (string) of cards" do
	  it "should parse the cards" do
		@player1.add_cards_string("AH 4C 2D 2C Jd 2h 10s")
		@player1.number_of_cards.should == 7
		@player1.add_cards_string("K-Hearts Q-Clubs jD qH 5-h q-c A_diamonds 3_hearts 6-clubs 7-hearts")
		@player1.number_of_cards.should == 17	#caution: books may be automatically created
	  end
	end
	context "when asking another player for a rank that is present" do
	  it "should steal the card(s) of that rank" do
		@player1.add_cards_string("AH")
		@player2.add_cards_string("AC")
		@player1.seek_from(@player2,@player1.seek_algorithm)
		#card should have moved from player2 to player1
		@player1.number_of_cards.should == 2
		@player2.number_of_cards.should == 0
	  end
	end
	context "when asking another player for a rank that is absent" do
	  it "should not steal the card(s) of that rank" do
		@player2.add_cards_string("AC")
		stolen_cards = @player2.remove_cards_of_rank("K")
		stolen_cards.size.should == 0
		@player1.add_cards_array(@player2.remove_cards_of_rank("K"))
		@player1.number_of_cards.should == 0
		@player2.number_of_cards.should == 1 	#verify no cards removed
	  end
	end
end

describe PlayerCommandline do
end


#helper methods
 def sum_of_other_players_cards(game)
	 game.players[1].number_of_cards+game.players[2].number_of_cards+game.players[3].number_of_cards
 end
