require_relative "test_helper"

class CampaignTest < Minitest::Test

  def setup
    Campaign.delete_all
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

  def test_exists
    Campaign
  end

  def test_can_assign_candidate_to_campaign
    candidate1 = Candidate.create!(bens_info)
    candidate2 = Candidate.create!(russells_info)
    campaign = Campaign.create!(candidates: [candidate1, candidate2])
    assert_equal 2, campaign.candidates.count
    assert_equal "Ben", campaign.candidates.first.first_name
  end

  def test_candidate1_wins
    candidate1 = Candidate.create!(bens_info)
    candidate2 = Candidate.create!(russells_info)
    campaign = Campaign.create!(candidates: [candidate1, candidate2])
    campaign.pick_winner
    assert_equal candidate1.id, campaign.winner_id
  end

end
