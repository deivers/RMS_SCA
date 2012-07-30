require File.dirname(__FILE__) + '/../go_fish_app.rb'
require 'rack/test'

set :environment, :test

def app
  GoFishApp
end

describe GoFishApp do
  include Rack::Test::Methods

  it 'should load the home page' do
    get '/game'
    last_response.should be_ok
    last_response.status.should == 200
    puts last_response.body
    last_response.body.should =~ /<html>.*play.*<\/html>/mi

  end

  it 'should create a new game and redirect...' do
	  post '/game/new'
	  last_response.should be_redirect

	  follow_redirect!
	  last_response.body.should =~ /3 players/

  end



end
