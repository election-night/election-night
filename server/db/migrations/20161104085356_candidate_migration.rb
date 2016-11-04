require 'active_record'

class CandidateMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :candidates do |t|
      t.string :first_name #capital first letters, no numbers
      t.string :last_name #capital first letters, no numbers
      t.string :image_url #starts with https://, check if valid address?
      t.integer :intelligence #int 1-10 make sure total is 10 for creation
      t.integer :charisma #int 1-10
      t.integer :willpower #int 1-10
    end
  end
end
