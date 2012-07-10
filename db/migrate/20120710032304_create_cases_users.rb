class CreateCasesUsers < ActiveRecord::Migration
  def change
    create_table :cases_users do |t|
      t.integer :user_id
      t.integer :case_id
    end
  end
end
