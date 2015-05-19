require 'spec_helper'

describe CreateTask do
  let(:project) { FactoryGirl.create(:project) }
  let(:parent_task)  { FactoryGirl.create(:new_feature_task, project_id: project.id) }

  it 'creates a subtask' do
    result = CreateTask.call(task_attributes: FactoryGirl.attributes_for(:new_feature_task, parent_task_id: parent_task.id, project_id: project.id))
    expect(result).to be_a_success
    expect(Task.last).to eql(result.task)
    expect(Task.last.parent_task_id).to eql(parent_task.id)
  end

  it 'creates a top level task' do
    result = CreateTask.call(task_attributes: FactoryGirl.attributes_for(:new_feature_task, project_id: project.id))
    expect(result).to be_a_success
    expect(Task.last).to eql(result.task)
  end

  it 'will not create a task without a project id' do
    result = CreateTask.call(task_attributes: FactoryGirl.attributes_for(:new_feature_task, project_id: nil))
    expect(result).to be_a_failure
  end

end