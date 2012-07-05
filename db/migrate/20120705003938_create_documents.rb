class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :person_id
      t.integer :case_id
      t.string :document
    end
  end
end
