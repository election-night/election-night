require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def candidate_info
    {first_name: "Ben",
    last_name: "Mangelsen",
    image_url: "https://urlsample.com",
    intelligence: 3,
    charisma: 3,
    willpower: 4}
  end

  def russell_s_info
    {first_name: "Russell",
    last_name: "Osborne",
    image_url: "https://avatars2.githubusercontent.com/u/243989?v=3&s=400",
    intelligence: 2,
    charisma: 4,
    willpower: 2}
  end

  def setup
    Candidate.delete_all
    Campaign.delete_all
    candidate1 = Candidate.create!(candidate_info)
    candidate2 = Candidate.create!(russell_s_info)
    campaign1 = Campaign.create!(candidates: [candidate1, candidate2])
    campaign2 = Campaign.create!(candidates: [candidate1, candidate2])
  end

  def test_can_list_all_candidates
    get "/candidates"
    assert last_response.ok?
    assert_equal "Ben", JSON.parse(last_response.body)[0]["first_name"]
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_can_list_all_campaigns
    get "/campaigns"
    assert last_response.ok?
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_can_list_single_candidate
    get "/candidates/:id"
    assert last_response.ok?
    binding.pry
    assert_equal candidate2.id,
  end

  def test_can_list_all_wins_for_candidate

  end



end
