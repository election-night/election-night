ENV['RACK_ENV'] ||= 'development'

require 'bundler/setup'
require 'sinatra'
require 'json'

require_relative 'database'

class App < Sinatra::Base
  set :static, true
  set :public_folder, proc { File.join(root, '..', '..', 'client', 'public') }

  enable :sessions

  before do
    content_type 'application/json'
  end

  get '/' do
    content_type 'text/html'
    body File.read(File.join(settings.public_folder, 'index.html'))
  end

  get "/candidates" do #list all candidates
    candidates = Candidate.all
    if candidates == []
      status 404
      {message: "No candidates exist"}.to_json
    else
      candidates.to_json
    end
  end

  get "/campaigns" do #list all campaigns
    campaigns = Campaign.all
    if campaigns == []
      status 404
      {message: "No campaigns exist"}.to_json
    else
      campaigns.to_json
    end
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

  get "/candidates/:id/wins" do #list all win campaigns for single candidate
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

  patch "/candidates/:id/first_name" do #update first name
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.update(first_name: JSON.parse(request.body.read)["first_name"])
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  patch "/candidates/:id/last_name" do #update last name
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.update(last_name: JSON.parse(request.body.read)["last_name"])
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  patch "/candidates/:id/image_url" do #update image url
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.update(image_url: JSON.parse(request.body.read)["image_url"])
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
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
      candidate_ids = JSON.parse(request_body)
      campaign = Campaign.new(candidates: [Candidate.find_by(id: candidate_ids["candidates"][0]),
                                          Candidate.find_by(id: candidate_ids["candidates"][1])])
      if campaign.save
        status 201
        campaign.pick_winner
        campaign.to_json
      else
        status 422
        {errors: {full_messages: campaign.errors.full_messages}}.to_json
      end
    end
  end

  get "/candidates/:id/total_points" do #get total points for candidate
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      {points: candidate.total_points}.to_json
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  patch "/candidates/:id/characteristics" do #update candidate characteristics
    request_body = request.body.read
    candidate_characteristics = JSON.parse(request_body)
    candidate = Candidate.find_by(id: params["id"])
    if candidate
      candidate.update(intelligence: candidate_characteristics["intelligence"])
      candidate.update(charisma: candidate_characteristics["charisma"])
      candidate.update(willpower: candidate_characteristics["willpower"])
    else
      status 404
      {message: "Candidate with id ##{params["id"]} does not exist"}.to_json
    end
  end

  run! if app_file == $PROGRAM_NAME
end
