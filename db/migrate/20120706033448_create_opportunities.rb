class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.string :title
      t.text :description
      t.integer :responsible_id
      t.integer :user_id
      t.decimal :budget, scale: 2, precision: 10
      t.integer :probability
      t.datetime :expires_at
      t.boolean :closed

      t.timestamps
    end
  end
end
