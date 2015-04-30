require 'spec_helper'

describe TaskGroupsController do
  login_user
  let(:project) { FactoryGirl.create(:project) }

  describe "GET #new" do
    it 'renders the :new view with template' do
      params = { project_id: project.id }

      get :new, params
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it 'redirects to the project home' do
        params = FactoryGirl.attributes_for(:task_group, project_id: project.id)
        post :create, params
        expect(response).to redirect_to(project_tasks_path(project_id: project.id))
      end

      context "when submitted by an unassociated user" do
        it "should not process the request"
      end
    end

    context "with invalid attributes" do
      it 'it renders the new task group page with an error'
    end
  end
end