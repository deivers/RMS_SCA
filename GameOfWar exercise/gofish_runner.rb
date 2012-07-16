#!/usr/bin/env ruby
load 'gofishgame.rb'

print "What is your name? "
name = gets.chomp
puts "Hello #{name}!"

game = GoFishGame.new(4)
game.setup_cards

