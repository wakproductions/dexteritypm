require 'spec_helper'

describe Task do
  it 'requires a parent project' do
    expect(FactoryGirl.build(:new_feature_task, project: nil)).to be_invalid
  end
end
