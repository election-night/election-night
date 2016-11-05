require 'active_record'

class Campaign < ActiveRecord::Base

  has_and_belongs_to_many :candidates
  # validates :candidate1, :candidate2, presence: true

  def pick_winner
    candidate1 = candidates[0]
    candidate2 = candidates[1]
    self.winner_id = candidate1.id
    save
  end

end
