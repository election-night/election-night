require_relative "test_helper"

class CandidateTest < Minitest::Test

  def setup
    Candidate.delete_all
  end

  def test_exists
    Candidate
  end

  def test_can_create_candidate
    assert Candidate.create!
  end

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
