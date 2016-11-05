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
    wins = candidate.campaigns_won_list
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

  patch "/candidates/:id/first_name" do
    Candidate.find_by(id: params["id"]).update(first_name: params["update"])
  end

  patch "/candidates/:id/last_name" do
    Candidate.find_by(id: params["id"]).update(last_name: params["update"])
  end

  patch "/candidates/:id/image_url" do
    Candidate.find_by(id: params["id"]).update(image_url: params["update"])
  end

  delete "/candidates/:id" do #delete a single candidate
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.delete
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  post "/candidates" do #create candidate
    request_body = request.body.read
    candidate_info = JSON.parse(request_body)
    candidate = Candidate.new(candidate_info)
    if candidate.save
      status 201
      candidate.to_json
    else
      status 422
      {errors: {full_messages: candidate.errors.full_messages}}.to_json
    end
  end

  post "/campaigns" do #create campaign
    request_body = request.body.read
    if request_body == ""
      status 422
      {message: "You didn't enter anything!"}.to_json
    else
      campaign_info = JSON.parse(request_body)
      campaign = Campaign.new {campaign_info}
      if campaign.save
        status 201
        campaign.to_json
      else
        status 422
        {errors: {full_messages: campaign.errors.full_messages}}.to_json
      end
    end
  end

  get "/candidates/:id/total_points" do

  end

  patch "/candidates/:id/intelligence" do

  end

  patch "/candidates/:id/charisma" do

  end

  patch "/candidates/:id/willpower" do

  end

  run! if app_file == $PROGRAM_NAME
end
