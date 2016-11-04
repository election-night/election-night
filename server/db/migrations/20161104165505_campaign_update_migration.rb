require 'active_record'

class CampaignUpdateMigration < ActiveRecord::Migration[5.0]
  def change
    remove_column :campaigns, :candidate1
    remove_column :campaigns, :candidate2
  end
end
