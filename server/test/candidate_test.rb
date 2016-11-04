require_relative "test_helper"

class CandidateTest < Minitest::Test

  def setup
    Candidate.delete_all
  end

  def test_exists
    Candidate
  end

  def candidate_info
    {first_name: "Ben",
    last_name: "Mangelsen",
    image_url: "https://urlsample.com",
    intelligence: 3,
    charisma: 3,
    willpower: 4}
  end

  def test_can_create_candidate
    assert Candidate.create!(candidate_info)
  end

  def test_first_name_must_be_present
    assert_raises do
      Candidate.create!(
        last_name: "Mangelsen",
        image_url: "https://urlsample.com",
        intelligence: 3,
        charisma: 3,
        willpower: 4
      )
    end
  end

  def test_last_name_must_be_present
    assert_raises do
      Candidate.create!(
        first_name: "Ben",
        image_url: "https://urlsample.com",
        intelligence: 3,
        charisma: 3,
        willpower: 4
      )
    end
  end

  def test_url_must_be_present
    assert_raises do
      Candidate.create!(
        first_name: "Ben",
        last_name: "Mangelsen",
        intelligence: 3,
        charisma: 3,
        willpower: 4
      )
    end
  end


  def test_intelligence_must_be_present
    assert_raises do
      Candidate.create!(
        first_name: "Ben",
        last_name: "Mangelsen",
        image_url: "https://urlsample.com",
        charisma: 3,
        willpower: 4
      )
    end
  end

  def test_charisma_must_be_present
    assert_raises do
      assert Candidate.create!(
        first_name: "Ben",
        last_name: "Mangelsen",
        image_url: "https://urlsample.com",
        intelligence: 3,
        willpower: 4
      )
    end
  end

  def test_willpower_must_be_present
    assert_raises do
      assert Candidate.create!(
        first_name: "Ben",
        last_name: "Mangelsen",
        image_url: "https://urlsample.com",
        intelligence: 3,
        charisma: 3
      )
    end
  end

end
