require 'sinatra'
require 'yaml'
require_relative 'gofishgame.rb'
require_relative 'player.rb'

class GoFishApp < Sinatra::Base

	configure do

	end

	def initialize
		super
		#@@games ||= Hash.new
		@games ||= Hash.new
		@players ||= Hash.new		# assume username is unique, use it as an id
	end

	get '/' do
		erb :index
	end

	post '/game/new' do
		@game = GoFishGame.new(3)
		#@@games[game.object_id.to_s] = game
		id = unique_id(@game)
		@games[id] = @game;
		save(@game, id)
		redirect "/game/#{id}"
	end

	get '/game/:id' do
		#@game = @@games[params[:id]]
		@game = retrieve(params[:id])
		#@games[params[:id]] = @game
		num_players = @game.players.size
		puts num_players
		erb :show
	end

	post '/player' do
		nameString = params[:name]
		@player = Player.new(nameString)
		@players[nameString] = @player;
		savePlayers()
		redirect "/player/#{nameString}"
	end

	get '/player/:name' do
		@player = Player.new(params[:name])
		erb :showPlayer
	end

	def savePlayers()
		File.open("saved_games/players",'w') do |file|
			file.write(@players.to_yaml)
		end
	end

	def unique_id(game)
		#increment the stored game counter
		#return the counter
		#return game.object_id.to_s
		#but for now...
		return (1..9999).to_a.sample.to_s
	end

	def save(game, id)
		filepath = File.join("saved_games",id.to_s)
		File.open(filepath,'w') do |file|
			file.write(game.to_yaml)
		end
	end
	def retrieve(game_id)
		filepath = File.join("saved_games",game_id.to_s)
		File.open(filepath,'r') do |file|
			YAML::load(file)
		end
	end

	def self.clear_current_game
		@games = null
	end

	run! if app_file == $0

end

#GoFishApp.run!