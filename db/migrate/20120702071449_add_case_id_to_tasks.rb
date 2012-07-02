class AddCaseIdToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :case_id, :integer
  end
end
