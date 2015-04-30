require 'spec_helper'

describe User do
  subject(:user) { FactoryGirl.create(:user) }

  it 'can have more than one projects' do
    user.projects << 2.times.map { FactoryGirl.create(:project) }
    expect(user.projects.count).to eql(2)
  end

  it 'can have a default project' do
    project = FactoryGirl.create(:project)
    user.default_project = project
    expect(user.default_project).to eql(project)
  end


  it 'cannot create a task in an unassociated project'
  it 'cannot move a task in an unassociated project'
  it 'cannot comment on a task in an unassociated project'
end
