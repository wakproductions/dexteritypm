class CreateProjectsUsers < ActiveRecord::Migration
  def change
    create_table :projects_users do |t|
      t.integer :project_id
      t.integer :user_id

      t.timestamps
    end

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
