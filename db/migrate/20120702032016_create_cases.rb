class CreateCases < ActiveRecord::Migration
  def change
    create_table :cases do |t|
      t.string :title
      t.boolean :closed
      t.integer :user_id
    end
  end
end
