require_relative '../go_fish_game.rb'

describe GoFishGame do
  subject {GoFishGame.new(3)}

  context 'set up' do
    it 'should have 3 players' do
      subject.players.size.should == 3
    end
    it 'should not empty the deck' do
      subject.deck.number_of_cards.should == 52 - 15
    end

    describe 'players hands' do
      let(:player1) {subject.players[0]}
      let(:player2) {subject.players[1]}

      it 'should deal equally to players' do
        player1.number_of_cards.should == player2.number_of_cards
      end
      it 'should deal 5 cards to each player' do
        player1.number_of_cards.should == 5
      end
    end

    describe 'player asking other player for cards' do
      context 'when other player does not have them' do

      end
      context 'when other player has them' do
        context 'and that gets asking player a book' do

        end
      end

    end
  end
end

describe GoFishPlayer do
  game = GoFishGame.new(3)
  subject {game.players[0]}

  its(:number_of_cards) {should == 5}
end
