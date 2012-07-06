class AddOpportunityIdToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :opportunity_id, :integer

  end
end
