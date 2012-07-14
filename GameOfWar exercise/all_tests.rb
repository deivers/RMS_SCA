#require 'test/unit'
load 'war_test.rb'
load 'card_test.rb'

  war_test.test_deal
  war_test.test_play_card
  war_test.test_round_with_clear_winner

  card_test.test_equals
