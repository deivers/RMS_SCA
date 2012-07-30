require File.dirname(__FILE__) + '/../go_fish_app.rb'
require 'rack/test'

set :environment, :test

def app
	GoFishApp
end

describe GoFishApp do
	include Rack::Test::Methods

	it 'should load the home page' do
		get '/'
		last_response.should be_ok
		last_response.status.should == 200

		puts last_response.body
		last_response.body.should =~ /<html>.*play Go Fish.*<\/html>/mi

	end

	it 'should present a player status page when player is identified' do
		#want to enter a player name
		post 'player/new', {name: 'Joe'} #alt#:params => {:name => 'Joe'}
		last_response.should be_redirect
		follow_redirect!
		last_response.body.should =~ /Joe/
		# able to create new game for Joe to play

	end

	it 'should present a player status page when existing player is identified' do
		#verify joe is existing player, won 3:4 games
		get '/player/joe'
		#verify stats on page
		#verify joe can create new game
		#post '/player/joe/game/new' ?
	end

	it 'should create a new game and redirect...' do
		post '/game/new'
		last_response.should be_redirect
		follow_redirect!
		last_response.body.should =~ /Go Fish/
		id = last_response.path.split('/').last
		app.clear_current_game
		get "/game/#{id}"
		last_response.body.should =~ /3 Players/

	end

	it 'should retrieve a saved file' do
		app_to_save = app.new!
		game = GoFishGame.new(3)
		app_to_save.save(game)
		id = app_to_save.unique_id(game)
		get "/game/#{id}"
		last_response.body.should =~ /3 players/
	end




end
