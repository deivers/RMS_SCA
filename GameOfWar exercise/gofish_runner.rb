#!/usr/bin/env ruby
load 'gofishgame.rb'

game = GoFishGame.new(4)
game.setup_cards
while (!game.is_over?) do
    game.manage_turn
    puts(" ")
    game.showAllCards
    puts(" ")

end