class OwnedResourcesController < ApplicationController
  before_filter :authorize

  def authorize
    @organization = Organization.find params[:organization_id]
  end

  # GET /owned_resources
  # GET /owned_resources.xml
  def index
    @owned_resources = @organization.owned_resources.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @owned_resources }
    end
  end

  # GET /owned_resources/1
  # GET /owned_resources/1.xml
  def show
    @owned_resource = @organization.owned_resources.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @owned_resource }
    end
  end

  # GET /owned_resources/new
  # GET /owned_resources/new.xml
  def new
    @owned_resource = @organization.owned_resources.build

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @owned_resource }
    end
  end

  # GET /owned_resources/1/edit
  def edit
    @owned_resource = @organization.owned_resources.find(params[:id])
  end

  # POST /owned_resources
  # POST /owned_resources.xml
  def create
    @owned_resource = @organization.owned_resources.build(params[:owned_resource])

    respond_to do |format|
      if @owned_resource.save
        format.html { redirect_to(@owned_resource, :notice => 'Owned resource was successfully created.') }
        format.xml  { render :xml => @owned_resource, :status => :created, :location => @owned_resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @owned_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /owned_resources/1
  # PUT /owned_resources/1.xml
  def update
    @owned_resource = @organization.owned_resources.find(params[:id])

    respond_to do |format|
      if @owned_resource.update_attributes(params[:owned_resource])
        format.html { redirect_to(@owned_resource, :notice => 'Owned resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @owned_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /owned_resources/1
  # DELETE /owned_resources/1.xml
  def destroy
    @owned_resource = @organization.owned_resources.find(params[:id])
    @owned_resource.destroy

    respond_to do |format|
      format.html { redirect_to(owned_resources_url) }
      format.xml  { head :ok }
    end
  end
end
