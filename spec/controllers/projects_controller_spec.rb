require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  # new / create / show / index / edit / update / destroy actions

  def project
    @project ||= FactoryGirl.create(:project)
  end

  let(:user)  { FactoryGirl.create(:user) }
  let(:project_with_user) { FactoryGirl.create(:project, {user: user}) }

  describe "#new" do

    context "with user signed in" do
      before { login(user) }
      it "renders the 'new' template" do
        get :new
        expect(response).to render_template(:new)
      end
      it "instantiates a new project object and assigns it to @project" do
        get :new
        expect(assigns(:project)).to be_a_new(Project)
      end
    end

  end

  describe "#create" do

    context "with user being logged in" do
      before{ login(user) }

      context "with valid attributes" do
        def valid_request
          post :create, project: FactoryGirl.attributes_for(:project)
        end
        it "it creates a record in the DB" do
          count_before = Project.count
          valid_request
          count_after = Project.count
          expect(count_after - count_before).to eq(1)
        end
        it "redirect to the show page" do
          valid_request
          expect(response).to redirect_to(project_path(Project.last))
        end
        it "sets a flash notice message" do
          valid_request
          expect(flash[:notice]).to be
        end
      end

      context "with invalid attributes" do
        def invalid_request
          post :create, project: {due_date: "Jan 01, 2000"}
        end
        it "doesn't create a record in the DB" do
          count_before = Project.count
          invalid_request
          count_after = Project.count
          expect(count_after - count_before).to eq(0)
        end
        it "renders the 'new' template" do
          invalid_request
          expect(response).to render_template(:new)
        end
        it "sets flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end

    end
  end

  describe "#show" do
    before do
      get :show, id: project
    end
    it "finds the object by its id and assign it to @project" do
      expect(assigns(:project)).to eq(project)
    end
    it "renders the show template" do
      expect(response).to render_template(:show)
    end
    it "raises an error if the id passed doesn't match a record in the DB" do
      expect{ get :show, id:123124124 }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "#index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "fetches all records ordered DESC and assigns them to @projects" do
      c = FactoryGirl.create(:project)
      c1 = FactoryGirl.create(:project)
      get :index
      expect(assigns(:projects)).to eq([c1, c])
    end
  end

  describe "#edit" do

    context "with logged in user is the owner" do
      before do
        login(user)
        get :edit, id: project_with_user
      end
      it "renders the edit template" do
        expect(response).to render_template(:edit)
      end
      it "finds the object by its id and assign it to @project instance variable" do
        expect(assigns(:project)).to eq(project_with_user)
      end
    end

    context "with logged in user is not owner" do

    end

  end

  describe "#update" do

    context "with user is signed in and is owner" do
      before { login(user) }

      context "with valid attributes" do
        before do
          patch :update, id: project_with_user, project: {title: "new valid title"}
        end
        it "updates the record with new parameters(s)" do
          expect(project_with_user.reload.title).to eq("new valid title")
        end
        it "redirects to the show page" do
          expect(response).to redirect_to(project_path(project_with_user))
        end
        it "sets a flash notice message" do
          expect(flash[:notice]).to be
        end
      end
      context "with invalid attributes" do
        def invalid_request
          patch :update, id: project_with_user, project: {due_date: "Jan 01, 2000"}
        end
        it "doesn't update the record" do
          due_date_before = project_with_user.due_date
          invalid_request
          expect(project_with_user.reload.due_date).to eq(due_date_before)
        end
        it "reders the edit template" do
          invalid_request
          expect(response).to render_template(:edit)
        end
        it "sets s flash alert message" do
          invalid_request
          expect(flash[:alert]).to be
        end
      end
    end


  end

  describe "#destroy" do
    before { login(user) }
    context 'with user is signed in and is owner' do
      def destroy_request
        delete :destroy, id: project_with_user
      end
      it "removes it from the DB" do
        project_with_user
        count_before = Project.count
        destroy_request
        count_after = Project.count
        expect(count_before - count_after).to eq(1)
      end
      it "redirects to the index page" do
        destroy_request
        expect(response).to redirect_to(projects_path)
      end
      it "sets a flash notice message" do
        destroy_request
        expect(flash[:notice]).to be
      end
    end
  end


end
