class AddOpportunityIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :opportunity_id, :integer

  end
end
