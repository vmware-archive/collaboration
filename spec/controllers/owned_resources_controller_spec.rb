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

describe OwnedResourcesController do
  before(:each) do
    @org = Org.create! :display_name => 'VMWare'
    @app = App.create! :display_name => 'Stream'
    @owned_resource = @org.owned_resources.build valid_attributes
    @owned_resource.save!
  end

  # This should return the minimal set of attributes required to create a valid
  # OwnedResource. As you add validations to OwnedResource, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {
      :resource_id => @app.id,
      :resource_type => 'App'
    }
  end

  describe "GET index" do
    it "assigns all owned_resources as @owned_resources" do
      get :index, :org_id => @org.id
      assigns(:owned_resources).should eq([@owned_resource])
    end
  end

  describe "GET show" do
    it "assigns the requested owned_resource as @owned_resource" do
      get :show, :id => @owned_resource.id.to_s, :org_id => @org.id
      assigns(:owned_resource).should eq(@owned_resource)
    end
  end

  describe "GET new" do
    it "assigns a new owned_resource as @owned_resource" do
      get :new, :org_id => @org.id
      assigns(:owned_resource).should be_a_new(OwnedResource)
    end
  end

  describe "GET edit" do
    it "assigns the requested owned_resource as @owned_resource" do
      get :edit, :id => @owned_resource.id.to_s, :org_id => @org.id
      assigns(:owned_resource).should eq(@owned_resource)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new OwnedResource" do
        expect {
          post :create, :owned_resource => valid_attributes, :org_id => @org.id
        }.to change(OwnedResource, :count).by(1)
      end

      it "assigns a newly created owned_resource as @owned_resource" do
        post :create, :owned_resource => valid_attributes, :org_id => @org.id
        assigns(:owned_resource).should be_a(OwnedResource)
        assigns(:owned_resource).should be_persisted
      end

      it "redirects to the created owned_resource" do
        post :create, :owned_resource => valid_attributes, :org_id => @org.id
        response.should redirect_to org_owned_resource_path(@org, OwnedResource.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved owned_resource as @owned_resource" do
        # Trigger the behavior that occurs when invalid params are submitted
        OwnedResource.any_instance.stub(:save).and_return(false)
        post :create, :owned_resource => {}, :org_id => @org.id
        assigns(:owned_resource).should be_a_new(OwnedResource)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OwnedResource.any_instance.stub(:save).and_return(false)
        post :create, :owned_resource => {}, :org_id => @org.id
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested owned_resource" do
        # Assuming there are no other owned_resources in the database, this
        # specifies that the OwnedResource created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        OwnedResource.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => @owned_resource.id, :owned_resource => {'these' => 'params'}, :org_id => @org.id
      end

      it "assigns the requested owned_resource as @owned_resource" do
        put :update, :id => @owned_resource.id, :owned_resource => valid_attributes, :org_id => @org.id
        assigns(:owned_resource).should eq(@owned_resource)
      end

      it "redirects to the owned_resource" do
        put :update, :id => @owned_resource.id, :owned_resource => valid_attributes, :org_id => @org.id
        response.should redirect_to org_owned_resource_path(@org, @owned_resource)
      end
    end

    describe "with invalid params" do
      it "assigns the owned_resource as @owned_resource" do
        # Trigger the behavior that occurs when invalid params are submitted
        OwnedResource.any_instance.stub(:save).and_return(false)
        put :update, :id => @owned_resource.id.to_s, :owned_resource => {}, :org_id => @org.id
        assigns(:owned_resource).should eq(@owned_resource)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        OwnedResource.any_instance.stub(:save).and_return(false)
        put :update, :id => @owned_resource.id.to_s, :owned_resource => {}, :org_id => @org.id
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested owned_resource" do
      expect {
        delete :destroy, :id => @owned_resource.id.to_s, :org_id => @org.id
      }.to change(OwnedResource, :count).by(-1)
    end

    it "redirects to the owned_resources list" do
      delete :destroy, :id => @owned_resource.id.to_s, :org_id => @org.id
      response.should redirect_to(org_owned_resources_url @org)
    end
  end

end
