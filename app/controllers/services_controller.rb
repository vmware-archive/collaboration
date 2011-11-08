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

  def import
    saved = 0
    access_token_records = UserAccessToken.get_access_tokens(current_user, :cloudfoundry).values
    if (access_token_records.count == 0)
      unless session.has_key?(:url_after_oauth)
        # Make the user sign up
        session[:url_after_oauth] = request.path
        logger.info "No tokens sending the user to authenticate with cloud foundry"
        redirect_to omniauth_authorize_path("user", :cloudfoundry)
      else
        session.delete :url_after_oauth
        redirect_to services_path
      end
    else
      session.delete :url_after_oauth

      access_token_records.each do |user_token|
        if user_token
          services = nil
          begin
            api = CloudFoundry::Api.new :access_token => user_token.token
            services = api.services
          rescue OAuth2::Error => ex
            user_token.delete
            logger.error "Got error getting services #{ex.inspect} with access token #{user_token} -- deleting"
            next
          end

          if (services && services.respond_to?(:parsed))
            services = JSON.parse  services.parsed

            puts "SERVICES = #{services.inspect}"
            services.each do |service|
              begin

                service_hash = {
                  :display_name => service['name'],
                  :type => service['type'],
                  :version => service['version'],
                  :vendor => service['vendor'],
                  :creator => current_user,
                  :project => current_user.personal_org.default_project
                }
                @service = Service.create_or_find(service_hash)
                saved += 1
              rescue Exception => ex
                logger.error "Could not import #{service['name']} due to #{ex.inspect}"
              end
            end
          else
            logger.error "Did not get a valid response from services #{services.inspect}"
            user_token.delete
          end
          flash[:notice] = "Done importing #{saved.to_s} services"
        end
      end
      redirect_to services_path
    end

  end
end
