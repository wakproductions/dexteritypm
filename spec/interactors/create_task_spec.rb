require 'spec_helper'

describe CreateTask do
  let(:project) { FactoryGirl.create(:project) }

  it 'creates a subtask' do
    # pending
    # result = CreateTask.call(FactoryGirl.attributes_for(:new_feature_task))
    # expect(result).to be_a_success
    # expect(Task.last).to eql (result.subtask)
  end

end