class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :type
      t.integer :status
      t.integer :parent_task_id

      t.timestamps
    end
  end
end
