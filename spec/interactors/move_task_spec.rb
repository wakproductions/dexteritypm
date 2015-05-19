require 'spec_helper'

describe MoveTask do
  describe '#call' do
    let(:parent_project) { FactoryGirl.create(:project) }
    let(:another_project) { FactoryGirl.create(:project) }
    let(:task) { parent_project.tasks.create(FactoryGirl.attributes_for(:new_feature_task)) }
    let(:another_task) { parent_project.tasks.create(FactoryGirl.attributes_for(:new_feature_task)) }
    let(:another_project_task) { another_project.tasks.create(FactoryGirl.attributes_for(:task_group)) }
    let(:task_group) { parent_project.tasks.create(FactoryGirl.attributes_for(:task_group, title: "Task Group #1")) }

    it 'cannot move a task to another project' do
      result = MoveTask.call(task: task, to_task: another_project_task)
      expect(result).to be_a_failure
    end

    it 'cannot become a child of itself' do
      result = MoveTask.call(task: task, to_task: task)
      expect(result).to be_a_failure
    end

    context 'when the task does not belong to a group' do
      it 'can move the task to become the subtask (child) of another task' do
        result = MoveTask.call(task: task, to_task: another_task)
        expect(result).to be_a_success
      end

      it 'can move the task to become subtask (child) of group' do
        result = MoveTask.call(task: task, to_task: task_group)
        expect(result).to be_a_success
      end
    end


    context 'when the task is a subtask (child) of a group' do
      let(:another_task_group)  { parent_project.tasks.create(FactoryGirl.attributes_for(:task_group, title: "Task Group #2")) }

      before(:each) { task.parent_task = task_group }

      it 'can move the task to another group' do
        result = MoveTask.call(task: task, to_task: another_task_group)
        expect(result).to be_a_success
      end
    end

    context 'when the task is a subtask (child) of another task' do
      let(:parent_task) { task }
      let(:subtask) { parent_task.subtasks.create(FactoryGirl.attributes_for(:new_feature_task)) }

      it 'can move the task to be the child of another task' do
        result = MoveTask.call(task: subtask, to_task: another_task)
        expect(result).to be_a_success
      end

    end

  end
end