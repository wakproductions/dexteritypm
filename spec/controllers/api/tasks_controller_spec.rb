require 'spec_helper'

describe API::TasksController do
  login_user
  let(:project) { FactoryGirl.create(:project) }
  let(:new_feature_task_attributes) { FactoryGirl.attributes_for(:new_feature_task) }
  let(:task_hierarchy) do
    tt1 = FactoryGirl.create(:new_feature_task, title: "Top Level Task #1", project_id: project.id)
    tt2 = FactoryGirl.create(:new_feature_task, title: "Top Level Task #2", project_id: project.id)
    tg1 = FactoryGirl.create(:task_group, title: "Task Group #1", project_id: project.id)
    st1 = FactoryGirl.create(:new_feature_task, title: "Subtask #1", project_id: project.id, parent_task_id: tg1.id)
    st2 = FactoryGirl.create(:new_feature_task, title: "Subtask #2", project_id: project.id, parent_task_id: tg1.id)
    [tt1, tt2, tg1]
  end
  before { subject.current_user.projects << project }

  describe "GET #index" do
    context "without a parent_task_id" do
      it "responds with all the project's tasks' details in JSON" do
        params = { project_id: project.id }
        get :index, params
        expect(response.body).to eql(Project.find(project.id).tasks.to_json)
      end
    end

    context "with a parent_task_id" do
      it "responds with the subtask details in JSON" do
        params = { project_id: project.id, parent_task_id: task_hierarchy.last }
        get :index, params
        expect(response.body).to eql(Task.find(task_hierarchy.last.id).subtasks.to_json)
      end
    end

    context "with an invalid project id" do
      it "responds with blank JSON" do
        params = { project_id: project.id+10, parent_task_id: task_hierarchy.last }
        get :index, params
        expect(response.body).to eql([].to_json)
      end
    end

    context "with a project id that does not belong to the user" do
      let(:orphan_project) { FactoryGirl.create(:project) }
      before { FactoryGirl.create_list(:new_feature_task, 3, project_id: orphan_project.id) }

      it "responds with blank JSON" do
        params = { project_id: orphan_project.id }
        get :index, params
        expect(response.body).to eql([].to_json)
      end
    end
  end

  describe "GET #jstree" do
    let(:params) {  { project_id: project.id } }

    context "without a parent_task_id" do
      it "responds with all the project's tasks' details in JSON formatted for jsTree" do
        # Should be the hash of values that the jsTree would get.
        # For this test to work the task_spec.rb tests must pass
        jsTree_hash = task_hierarchy.map { |task| task.to_jsTree }

        get :jstree, params
        expect(response.body).to eql(jsTree_hash.to_json)
      end
    end

    context "with a selected task id" do
      let(:selected_task_id) { task_hierarchy.last.subtasks.first.id }

      it "responds with selected=true in the JSON for the selected task" do
        # Should be the hash of values that the jsTree would get.
        # For this test to work the task_spec.rb tests must pass
        jsTree_hash = task_hierarchy.map { |task| task.to_jsTree }
        jsTree_hash.last[:children].first[:state] = { selected: true }

        get :jstree, params.merge({ selected_task_id: selected_task_id })
        expect(response.body).to eql(jsTree_hash.to_json)
      end
    end
  end


end