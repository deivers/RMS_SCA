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

	it 'should create a new game and redirect...' do
		post '/game/new'
		last_response.should be_redirect
		follow_redirect!
		#id = last_response.path.split('/').last
		#app.clear_current_game
		#get "/game/#{id}"
		last_response.body.should =~ /3 players/

	end

	it 'should retrieve a saved file' do
		app_to_save = app.new!
		game = GoFishGame.new(4)
		id = app_to_save.unique_id(game)
		app_to_save.save(game, id)
		puts "game id is: #{id}"
		get "/game/#{id}"
		last_response.body.should =~ /4 players/
	end

	it 'should present a player status page when player is identified' do
		#want to enter a player name
		post 'player', {:name => 'Joe'} #alt#:params => {:name => 'Joe'}
		last_response.should be_redirect
		follow_redirect!
		last_response.body.should =~ /Joe/
		#verify able to create new game for Joe to play
	end

	it 'should present a player status page when existing player is identified' do
		#create a game with player 'joe'
		#verify joe is existing player, check win/loss history
	#	get '/player/joe'
		#verify stats on page
		#verify joe can create new game
		#post '/player/joe/game/new' ?
	end




end
