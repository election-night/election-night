require 'active_record'

class CampaignMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.date :start_date
      t.integer :winner_id
    end
  end
end
