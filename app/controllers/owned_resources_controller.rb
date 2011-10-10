class OwnedResourcesController < ApplicationController
  before_filter :identify_parent

  # GET /owned_resources
  # GET /owned_resources.json
  def index
    @owned_resources = nil

    @title = @org.display_name
    if params[:resource_type] == 'Service'
      @title += " Services"
      @owned_resources = @org.owned_resources.where(:resource_type => 'Service')
    elsif params[:resource_type] == 'App'
       @title += " Apps"
       @owned_resources = @org.owned_resources.where(:resource_type => 'App')
    else
       @title += "'s Resources"
       @owned_resources = @org.owned_resources
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @owned_resources }
    end
  end

  # GET /owned_resources/1
  # GET /owned_resources/1.json
  def show
    @owned_resource = @org.owned_resources.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @owned_resource }
    end
  end

  # GET /owned_resources/new
  # GET /owned_resources/new.json
  def new
    @owned_resource = @org.owned_resources.build

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @owned_resource }
    end
  end

  # GET /owned_resources/1/edit
  def edit
    @owned_resource = @org.owned_resources.find(params[:id])
  end

  # POST /owned_resources
  # POST /owned_resources.json
  def create
    @owned_resource = @org.owned_resources.build(params[:owned_resource])

    respond_to do |format|
      if @owned_resource.save
        flash[:notice] = 'Resource was successfully assigned.'
        format.html { redirect_to org_owned_resource_path(@org, @owned_resource) }
        format.json  { render :json => @owned_resource, :status => :created, :location => @owned_resource }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @owned_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /owned_resources/1
  # PUT /owned_resources/1.json
  def update
    @owned_resource = @org.owned_resources.find(params[:id])

    respond_to do |format|
      if @owned_resource.update_attributes(params[:owned_resource])
        flash[:notice] = 'Resource was successfully updated.'
        format.html { redirect_to org_owned_resource_path(@org, @owned_resource)}
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @owned_resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /owned_resources/1
  # DELETE /owned_resources/1.json
  def destroy
    @owned_resource = @org.owned_resources.find(params[:id])
    @owned_resource.destroy

    respond_to do |format|
      format.html { redirect_to(org_owned_resources_url @org) }
      format.json  { head :ok }
    end
  end
end
