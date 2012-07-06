class CreateOpportunitiesPeople < ActiveRecord::Migration
  def change
    create_table :opportunities_people do |t|
      t.integer :person_id
      t.integer :opportunity_id
    end
  end
end
