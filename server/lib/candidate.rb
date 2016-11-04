require 'active_record'

class Candidate < ActiveRecord::Base

  has_and_belongs_to_many :campaigns
  validates :first_name, :last_name, :image_url, :intelligence, :charisma, :willpower,
            presence: true
  # validates :image_url, format: { with: /\A(http|https):\/\// }
  validates :first_name, :last_name, format: { with: /\A[a-zA-Z][- a-zA-Z.]*\z/ }
  validates :intelligence, :charisma, :willpower, format: {with: /\A([0-9]|10)\z/}
  
end
