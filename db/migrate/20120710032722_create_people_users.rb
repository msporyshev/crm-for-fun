class CreatePeopleUsers < ActiveRecord::Migration
  def change
    create_table :people_users do |t|
      t.integer :user_id
      t.integer :person_id
    end
  end
end
