require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe OrgsController do

  before do
    pwd = 'cloud$'
    @user = User.create! :first_name => 'Tester', :last_name => 'Testing', :display_name => 'TT', :password => pwd, :confirm_password => pwd, :email => 'tt@vmware.com'
    sign_in @user

    @org = @user.personal_org
  end

  # This should return the minimal set of attributes required to create a valid
  # Organization. As you add validations to Organization, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :display_name => "VMWare",
      :creator => @user
    }
  end

  describe "GET index" do
    it "assigns all orgs as @orgs" do
      get :index
      assigns(:orgs).should eq([@user.personal_org])
    end
  end

  describe "GET show" do
    it "assigns the requested org as @org" do
      get :show, :id => @org.id.to_s
      assigns(:org).should eq(@org)
    end
  end

  describe "GET new" do
    it "assigns a new org as @org" do
      get :new
      assigns(:org).should be_a_new(Org)
    end
  end

  describe "GET edit" do
    it "assigns the requested org as @org" do
      get :edit, :id => @org.id.to_s
      assigns(:org).should eq(@org)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Organization" do
        expect {
          post :create, :org => valid_attributes
        }.to change(Org, :count).by(1)
      end

      it "assigns a newly created org as @org" do
        post :create, :org => valid_attributes
        assigns(:org).should be_a(Org)
        assigns(:org).should be_persisted
      end

      it "redirects to the created org" do
        post :create, :org => valid_attributes
        response.should redirect_to(Org.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved org as @org" do
        # Trigger the behavior that occurs when invalid params are submitted
        Org.any_instance.stub(:save).and_return(false)
        post :create, :org => {}
        assigns(:org).should be_a_new(Org)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Org.any_instance.stub(:save).and_return(false)
        post :create, :org => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested org" do
        # Assuming there are no other orgs in the database, this
        # specifies that the Organization created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Org.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @org.id, :org => {'these' => 'params'}
      end

      it "assigns the requested org as @org" do
        put :update, :id => @org.id, :org => valid_attributes
        assigns(:org).should eq(@org)
      end

      it "redirects to the org" do
        put :update, :id => @org.id, :org => valid_attributes
        response.should redirect_to(@org)
      end
    end

    describe "with invalid params" do
      it "assigns the org as @org" do
        # Trigger the behavior that occurs when invalid params are submitted
        Org.any_instance.stub(:save).and_return(false)
        put :update, :id => @org.id.to_s, :org => {}
        assigns(:org).should eq(@org)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Org.any_instance.stub(:save).and_return(false)
        put :update, :id => @org.id.to_s, :org => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested org" do
      expect {
        delete :destroy, :id => @org.id.to_s
      }.to change(Org, :count).by(-1)
    end

    it "redirects to the orgs list" do
      delete :destroy, :id => @org.id.to_s
      response.should redirect_to(orgs_url)
    end
  end

end
