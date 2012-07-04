class CreateCasesPeople < ActiveRecord::Migration
  def up
    create_table :cases_people do |t|
      t.integer :case_id
      t.integer :person_id
    end
  end

  def down
    drop_table :cases_people
  end
end
