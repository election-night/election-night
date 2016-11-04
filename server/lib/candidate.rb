require 'active_record'

class Candidate < ActiveRecord::Base

  has_and_belongs_to_many :campaigns
  validates :name, :image_url, :intelligence, :charisma, :willpower,
            presence: { message: "must be given please" }
  validates :image_url, format: { with: /\A(http|https):\/\// }
  validates :name, format: { with: /\A[a-zA-Z][- a-zA-Z.]*\z/ }

end
