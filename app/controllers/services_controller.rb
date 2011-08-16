class ServicesController < ApplicationController
  before_filter :list_projects, :only => :new

  def list_projects
    @projects = []
    current_user.orgs_with_access.each do |org|
      org.projects.each do |project|
        @projects << ["#{org.display_name}-#{project.display_name}", project.id] if project.can_user PermissionManager::CREATE, 'services', current_user
      end
    end
  end

  # GET /services
  # GET /services.json
  def index
    # TODO: Only show the orgs that the logged in user has access
    @services = Service.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @services }
    end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @service = Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @service }
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    #TODO: Assign the newly created service to the user's current org
    @service = Service.new(params[:service])
    @service.creator = current_user
    begin
      @service.project = Project.find params[:service][:project_id]
    rescue
    end

    respond_to do |format|
      if @service.save
        format.html { redirect_to(@service, :notice => 'Service was successfully created.') }
        format.json  { render :json => @service, :status => :created, :location => @service }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to(@service, :notice => 'Service was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @service.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to(services_url) }
      format.json  { head :ok }
    end
  end
end
