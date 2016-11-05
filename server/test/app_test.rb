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
    Campaign.create!(candidates: [candidate1, candidate2])
    Campaign.create!(candidates: [candidate1, candidate2])
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
    get "/candidates/#{Candidate.last.id}"
    assert last_response.ok?
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_404_error_message_if_candidate_does_not_exist
    get "/candidates/#{Candidate.last.id + 1}"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_get_candidate_campaigns_won
    Campaign.first.pick_winner
    Campaign.last.pick_winner
    get "/candidates/#{Candidate.first.id}/wins"
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_404_error_message_if_candidate_has_no_wins
    Campaign.first.pick_winner
    Campaign.last.pick_winner
    get "/candidates/#{Candidate.last.id}/wins"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id} has no wins",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_list_all_campaigns_for_single_candidate
    Campaign.first.pick_winner
    Campaign.last.pick_winner
    get "/candidates/#{Candidate.last.id}/campaigns"
    assert_equal 2, JSON.parse(last_response.body).count
  end

end
