require 'active_record'

class CampaignMigration < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.integer :candidate1 #don't need can1 or 2
      t.integer :candidate2
      t.integer :winner_id
      t.timestamps null:false
    end
  end
end
