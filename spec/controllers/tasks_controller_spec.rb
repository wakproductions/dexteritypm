require 'spec_helper'

describe TasksController do
  login_user
  let(:project) { FactoryGirl.create(:project) }
  let(:new_feature_task_attributes) { FactoryGirl.attributes_for(:new_feature_task) }
  before { subject.current_user.projects << project }

  describe "GET #new" do
    it 'renders the :new view with template' do
      params = { project_id: project.id }

      get :new, params
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    let(:params) { { task: new_feature_task_attributes, project_id: project.id } }

    context "with valid attributes" do
      context "at top level" do
        it "renders the new task's detail page" do
          post :create, params
          is_expected.to redirect_to(project_task_path(project_id: project.id, id: Task.last.id))
          expect(Task.last.parent_task_id).to be_nil
        end
      end

      context "under a group" do
        let(:task_group) { FactoryGirl.create(:task_group, project: project) }
        it "renders the new task's detail page" do
          params[:task] = params[:task].update({ parent_task_id: task_group.id})
          post :create, params
          is_expected.to redirect_to(project_task_path(project_id: project.id, id: Task.last.id))
          expect(Task.last.parent_task_id).to eql(task_group.id)
        end
      end

      context "as a subtask" do
        let(:parent_task) { FactoryGirl.create(:new_feature_task, project: project)}
        it "renders the new task's detail page" do
          params[:task] = params[:task].update({ parent_task_id: parent_task.id })
          post :create, params
          is_expected.to redirect_to(project_task_path(project_id: project.id, id: Task.last.id))
          expect(Task.last.parent_task_id).to eql(parent_task.id)
        end
      end

      context "when submitted by an unassociated user" do
        it "should not process the request" do

        end
      end
    end

    context "with invalid attributes" do
      it 'it renders the new task group page with an error' do
        params[:task][:title] = nil # title is required so this should be invalid
        post :create, params
        is_expected.to render_template(:new)
        expect(assigns(:task).errors.count).to be > 0
      end
    end
  end

  describe "GET #move" do
    let(:tasks) { FactoryGirl.create_list(:new_feature_task, 3, project_id: project.id) }
    let(:params) { { task_id: tasks.first.id, project_id: project.id } }

    it 'renders the move template' do
      get :move, params
      is_expected.to render_template(:move)
    end
  end

  describe "PUT #move_action" do
    let(:first_task) { FactoryGirl.create(:new_feature_task, project_id: project.id) }
    let(:second_task) { FactoryGirl.create(:new_feature_task, project_id: project.id) }
    let(:params) { { project_id: project.id, task_id: first_task.id, to_task_id: second_task.id } }

    it 'moves the first task to become a child of the second task' do
      put :move_action, params
      expect(Task.find(first_task.id).parent_task_id).to eql(second_task.id)
    end
  end
end