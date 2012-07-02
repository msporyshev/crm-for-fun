class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :responsible_id
      t.integer :person_id
      t.string :title
      t.text :description
      t.datetime :expires_at
      t.boolean :closed
    end
  end
end
