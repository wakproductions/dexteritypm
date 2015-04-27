class AddDefaultProjectToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_project_id, :integer
    remove_column :projects, :user_id
  end
end
