require 'spec_helper'

# Remember - a Task Group is merely a type of task that has the group flag set to true. When group flag is set to
# true, then all of the properties other than title should be ignored.

describe Task do
  context 'when acting as a task group' do
    let(:project) { FactoryGirl.create(:project) }
    subject(:task_group) { FactoryGirl.build(:task_group, project: project) }

    it { is_expected.to be_valid } # Check that the FactoryGirl made it correctly

    it 'must be at the top level (cannot be a subtask)' do
      parent_group = FactoryGirl.create(:new_feature_task, project: project)

      task_group.parent_task = parent_group
      expect(task_group).to be_invalid
    end

  end
end
