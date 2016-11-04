# This is used to select which database to use.
ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'sinatra'
require 'json'
# require_relative './candidate'
# require_relative './campaign'

require_relative 'database'

class App < Sinatra::Base
  # Serve any HTML/CSS/JS from the client folder
  set :static, true
  set :public_folder, proc { File.join(root, '..', '..', 'client', 'public') }

  # Enable the session store
  enable :sessions

  # This ensures that we always return the content-type application/json
  before do
    content_type 'application/json'
  end

  # DO NOT REMOVE THIS ENDPOINT IT ENABLES HOSTING HTML FOR THE FRONT END
  get '/' do
    content_type 'text/html'
    body File.read(File.join(settings.public_folder, 'index.html'))
  end

  get "/candidates" do #list all candidates
    Candidate.all.to_json
  end

  get "/campaigns" do #list all campaigns
    Campaign.all.to_json
  end

  get "/candidates/:id" do #list single candidate
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.to_json
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  get "/candidates/:id/wins" do
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      #code to calculate total wins
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  get "/campaigns/:candidate_id" do #list all campaigns for a single candidate
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      #code to list all campaigns with candidate id
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  patch "/candidates/:id" do #update a single candidate

  end

  delete "/candidates/:id" do #delete a single candidate

  end

  post "/campaigns" do #create campaign

  end

  post "/candidates" do

  end

  # You can delete this route but you should nest your endpoints under /api
  # get '/api' do
  #   { msg: 'The server is running' }.to_json
  # end

  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
