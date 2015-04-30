require 'spec_helper'

describe CreateTaskGroup do
  let(:project) { FactoryGirl.create(:project) }

  # Note: other validations are checked in the taskgroup_spec.rb file based on the Task model
  it 'creates a task group' do
    result = CreateTaskGroup.call(title: Forgery(:name).job_title, project: project)
    expect(result).to be_a_success
  end

end