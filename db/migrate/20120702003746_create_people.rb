class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :user_id
      t.string :name
      t.string :surname
      t.string :email
      t.string :address
      t.string :phone_num
      t.text :description
    end
  end
end
