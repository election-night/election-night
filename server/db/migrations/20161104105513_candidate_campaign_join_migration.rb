require 'active_record'

class CandidateCampaignJoinMigration < ActiveRecord::Migration[5.0]
  def change
    create_join_table :candidates, :campaigns
  end
end
