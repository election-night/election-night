require_relative "test_helper"

class CandidateTest < Minitest::Test

  def setup
    Candidate.delete_all
  end

  def test_exists
    Candidate
  end

  def test_can_create_candidate
    assert Candidate.create!(
      first_name: "Ben",
      last_name: "Mangelsen",
      image_url: "https://urlsample.com",
      intelligence: 3,
      charisma: 3,
      willpoer: 4
    )
  end

  validates :first_name, :last_name, :image_url, :intelligence, :charisma, :willpower,
            presence: true

  def test_name_must_be_present

  end

  def test_url_must_be_present

  end

  def test_intelligence_must_be_present

  end

  def test_charisma_must_be_present

  end

  def test_willpower_must_be_present

  end


end
