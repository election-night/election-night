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
    wins = []
    campaigns = Campaign.all
    campaigns.each do |campaign|
      if campaign.winner_id == candidate.id
        wins << campaign
      end
    end
    #wins = Campaign.where("winner_id" == candidate.id)
    if candidate
      if wins == []
        status 404
        {message: "Candidate with id ##{params["id"]} has no wins"}.to_json
      else
        wins.to_json
      end
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  get "/candidates/:id/campaigns" do #list all campaigns for a single candidate
    candidate = Candidate.find_by(id: params["id"])
    campaigns = candidate.campaigns
#     Company.where(
#   "id = :id AND name = :name AND division = :division AND created_at > :accounting_date",
#   { id: 3, name: "37signals", division: "First", accounting_date: '2005-01-01' }
# ).first
    #candidate_campaigns = Campaign.where(":candidates".include?(candidate))
    if candidate
      if campaigns == []
        status 404
        {message: "Candidate with id ##{params["id"]} has no campaigns"}.to_json
      else
        campaigns.to_json
      end
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

  post "/candidates" do #create candidate

  end

  # You can delete this route but you should nest your endpoints under /api
  # get '/api' do
  #   { msg: 'The server is running' }.to_json
  # end

  # If this file is run directly boot the webserver
  run! if app_file == $PROGRAM_NAME
end
