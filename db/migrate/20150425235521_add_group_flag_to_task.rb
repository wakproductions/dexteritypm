class AddGroupFlagToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :group, :boolean, :default=>false
    Task.all.each { |t| t.update(group: true) if t.category==Task::CATEGORY[:group] }
  end
end
