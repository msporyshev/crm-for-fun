class CreateOpportunitiesUsers < ActiveRecord::Migration
  def change
    create_table :opportunities_users do |t|
      t.integer :user_id
      t.integer :opportunity_id
    end
  end
end
