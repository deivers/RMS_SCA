require 'sinatra'
#require 'haml'
require_relative 'gofishgame.rb'

class GoFishApp < Sinatra::Base
	configure do

	end
	def initialize
		super
		@@games ||= Hash.new
	end

	get '/game/:id' do
		@game = @@games[params[:id]]
		erb :'/game/show'
	end

	post '/game/new' do
		game = GoFishGame.new(3)
		@@games[game.object_id] = game
		redirect "/game/#{game.object_id}"
	end

	run! if app_file == $0

end

#GoFishApp.run!