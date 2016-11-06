require_relative "test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    App
  end

  def bens_info
    {first_name: "Ben",
    last_name: "Mangelsen",
    image_url: "https://urlsample.com",
    intelligence: 3,
    charisma: 3,
    willpower: 4}
  end

  def russells_info
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
    candidate1 = Candidate.create!(bens_info)
    candidate2 = Candidate.create!(russells_info)
    Campaign.create!(candidates: [candidate1, candidate2])
    Campaign.create!(candidates: [candidate1, candidate2])
  end

  def candidate1
    Candidate.create!(bens_info)
  end

  def candidate2
    Candidate.create!(russells_info)
  end

  def test_can_list_all_candidates
    get "/candidates"
    assert last_response.ok?
    assert_equal "Ben", JSON.parse(last_response.body)[0]["first_name"]
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_404_error_message_if_no_candidates_exist
    Candidate.delete_all
    get "/candidates"
    assert_equal 404, last_response.status
    assert_equal "No candidates exist", JSON.parse(last_response.body)["message"]
  end

  def test_can_list_all_campaigns
    get "/campaigns"
    assert last_response.ok?
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_404_error_message_if_no_campaigns_exist
    Campaign.delete_all
    get "/campaigns"
    assert_equal 404, last_response.status
    assert_equal "No campaigns exist", JSON.parse(last_response.body)["message"]
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
    get "/candidates/#{Candidate.last.id}/campaigns"
    assert_equal 2, JSON.parse(last_response.body).count
  end

  def test_404_error_message_if_candidate_has_no_campaigns
    Campaign.delete_all
    get "/candidates/#{Candidate.last.id}/campaigns"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id} has no campaigns",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_update_a_candidate_first_name
    patch "/candidates/#{Candidate.last.id}/first_name", {first_name: "Jill"}.to_json
    assert_equal "Jill", Candidate.last["first_name"]
  end

  def test_404_error_message_if_patching_unknown_candidate_first_name
    patch "/candidates/#{Candidate.last.id + 1}/first_name", {first_name: "Jill"}.to_json
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_update_a_candidate_last_name
    patch "/candidates/#{Candidate.last.id}/last_name", {last_name: "Potter"}.to_json
    assert_equal "Potter", Candidate.last["last_name"]
  end

  def test_404_error_message_if_patching_unknown_candidate_last_name
    patch "/candidates/#{Candidate.last.id + 1}/last_name", {last_name: "Potter"}.to_json
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_update_a_candidate_image_url
    patch "/candidates/#{Candidate.last.id}/image_url", {image_url: "womp.jpeg"}.to_json
    assert_equal "womp.jpeg", Candidate.last["image_url"]
  end

  def test_404_error_message_if_patching_unknown_candidate_image_url
    patch "/candidates/#{Candidate.last.id + 1}/image_url", {image_url: "womp.jpeg"}.to_json
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_delete_candidate
    delete "/candidates/#{Candidate.last.id}"
    assert_equal 1, Candidate.all.count
    assert Candidate.where(first_name: "Russel").empty?
  end

  def test_404_error_message_if_candidate_does_not_exist_on_delete
    delete "/candidates/#{Candidate.last.id + 1}"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist", JSON.parse(last_response.body)["message"]
  end

  def test_can_create_candidate
    payload = {
      first_name: "Joe",
      last_name: "Sixpack",
      image_url: "blerp",
      intelligence: 4,
      charisma: 3,
      willpower: 3
    }
    post "/candidates", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Candidate.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_404_response_and_error_message_when_candidate_fails_to_save
    payload = {
      first_name: "Joe",
      image_url: "blerp",
      intelligence: 4,
      charisma: 3,
      willpower: 3
    }
    post "/candidates", payload.to_json
    assert_equal 422, last_response.status
    assert_equal "Last name can't be blank", JSON.parse(last_response.body)["errors"]["full_messages"][0]
  end

  def test_can_create_campaign
    payload = {candidates: [candidate1.id, candidate2.id]}
    post "/campaigns", payload.to_json
    assert_equal 201, last_response.status
    assert_equal Campaign.last.winner_id, JSON.parse(last_response.body)["winner_id"]
    assert_equal Campaign.last.id, JSON.parse(last_response.body)["id"]
  end

  def test_422_response_if_unable_to_create_campaign_with_no_request_body
    post "/campaigns"
    assert_equal 422, last_response.status
    assert_equal "You didn't enter anything!", JSON.parse(last_response.body)["message"]
  end

  def test_can_get_candidate_total_points
    get "/candidates/#{Candidate.last.id}/total_points"
    assert_equal 10, JSON.parse(last_response.body)["points"]
  end

  def test_404_error_message_if_candidate_doest_not_exist_when_points_requested
    get "/candidates/#{Candidate.last.id + 1}/total_points"
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

  def test_can_update_a_candidate_characteristics
    payload = {
      intelligence: 4,
      charisma: 3,
      willpower: 3
    }
    patch "/candidates/#{Candidate.last.id}/characteristics", payload.to_json
    assert_equal 4, Candidate.last["intelligence"]
    assert_equal 3, Candidate.last["charisma"]
    assert_equal 3, Candidate.last["willpower"]
  end

  def test_404_error_message_if_patching_unknown_candidate_characteristics
    payload = {
      intelligence: 4,
      charisma: 3,
      willpower: 3
    }
    patch "/candidates/#{Candidate.last.id + 1}/characteristics", payload.to_json
    assert_equal 404, last_response.status
    assert_equal "Candidate with id ##{Candidate.last.id + 1} does not exist",
      JSON.parse(last_response.body)["message"]
  end

end
