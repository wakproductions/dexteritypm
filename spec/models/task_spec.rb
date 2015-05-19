require 'spec_helper'

describe Task do
  it 'requires a parent project' do
    expect(FactoryGirl.build(:new_feature_task, project: nil)).to be_invalid
  end

  describe '#to_jsTree' do
    let(:project) { FactoryGirl.create(:project) }
    let(:task_hierarchy) do
      level1a = FactoryGirl.create(:new_feature_task, title: "Top Level Task #1", project_id: project.id)
      level1b = FactoryGirl.create(:task_group, title: "Task Group #1", project_id: project.id)
      level1b1a = FactoryGirl.create(:new_feature_task, title: "Subtask #1", project_id: project.id, parent_task_id: level1b.id)
      level1b2b = FactoryGirl.create(:new_feature_task, title: "Subtask #2", project_id: project.id, parent_task_id: level1b.id)
      {
          level1a: level1a,
          level1b: level1b,
          level1b1a: level1b1a,
          level1b2b: level1b2b
      }
    end
    let(:task_hierarchy_jstree) do
      # Converts the task_hierarchy values into the layout expected by jsTree
      h = Hash.new
      h[:level1a] = { id: task_hierarchy[:level1a].id, text: task_hierarchy[:level1a].title }
      h[:level1b] = {
          id: task_hierarchy[:level1b].id,
          text: task_hierarchy[:level1b].title,
          children: [
              { id: task_hierarchy[:level1b1a].id, text: task_hierarchy[:level1b1a].title },
              { id: task_hierarchy[:level1b2b].id, text: task_hierarchy[:level1b2b].title }
          ]
      }
      h
    end

    it 'converts a task with no children to jsTree hash (pre-JSON)' do
      expect(task_hierarchy[:level1a].to_jsTree).to eql(task_hierarchy_jstree[:level1a])
    end

    it 'converts a task with two children to jsTree hash (pre-JSON)' do
      expect(task_hierarchy[:level1b].to_jsTree).to eql(task_hierarchy_jstree[:level1b])
    end

  end
end
