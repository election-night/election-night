require 'active_record'

class Candidate < ActiveRecord::Base

  has_and_belongs_to_many :campaigns
  validates :first_name, :last_name, :image_url, :intelligence, :charisma, :willpower,
            presence: true
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z][- a-zA-Z.]*\z/ }
  validates :intelligence, :charisma, :willpower, format: {with: /\A([0-9]|10)\z/}

  validate :total_points_cannot_be_exceeded_by_sum_of_characteristics

  def total_points
    10 + campaigns_won_count
  end

  def collect_candidate_wins
    wins = []
    campaigns = Campaign.all
    campaigns.each do |campaign|
      if campaign.winner_id == self.id
        wins << campaign
      end
    end
    wins
  end

  def campaigns_won_list
    collect_candidate_wins
  end

  def campaigns_won_count
    collect_candidate_wins.count
  end

  def total_points_cannot_be_exceeded_by_sum_of_characteristics
    if (self.intelligence + self.charisma + self.willpower) > total_points
      errors.add(:total_points, "cannot be exceeded by sum of candidate characteristics")
    end
  end

end
