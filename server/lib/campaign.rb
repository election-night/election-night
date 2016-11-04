require 'active_record'

class Campaign < ActiveRecord::Base

  has_and_belongs_to_many :candidates
  validates :candidate1, :candidate2, :start_date, presence: true

end
