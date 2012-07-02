class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :hashed_pass
      t.string :name
      t.string :surname
      t.string :secure_id
      t.string :salt
      t.string :role
      t.datetime :expires_at
    end
  end
end
