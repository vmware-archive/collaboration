require 'cloud_foundry'
require 'facebook'

class AppsController < ApplicationController
  before_filter :list_projects, :only => :new

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
        redirect_to apps_path
      end
    else
      session.delete :url_after_oauth

      access_token_records.each do |user_token|
        if user_token
          apps = nil
          begin
            api = CloudFoundry::Api.new :access_token => user_token.token
            apps = api.apps
          rescue OAuth2::Error => ex
            user_token.delete
            logger.error "Got error getting apps #{ex.inspect} with access token #{user_token} -- deleting"
            next
          end

          if (apps && apps.respond_to?(:parsed))
            apps = apps.parsed
            apps.each do |app|
              begin

                app_hash = {
                  :display_name => app['name'],
                  :state => app['state'],
                  :url => app['uris'].first,
                  :framework => app['staging']['model'],
                  :runtime => app['staging']['stack'],
                  :creator => current_user,
                  :project => current_user.personal_org.default_project
                }
                @app = App.create_or_find(app_hash)
                app_health = {
                  :app_id => @app.id,
                  :email => user_token.email,
                  :provider => user_token.provider,
                  :running_instances => app['runningInstances'],
                  :instances => app['instances']
                }
                AppHealthSnapshot.create! app_health
                saved += 1
              rescue Exception => ex
                logger.error "Could not import #{app['name']} due to #{ex.inspect}"
              end
            end
          else
            logger.error "Did not get a valid response from apps #{apps.inspect}"
            user_token.delete!
          end
          flash[:notice] = "Done importing #{saved.to_s} apps"
        end
      end
      redirect_to apps_path
    end

  end

  def list_projects
    @projects = []
    current_user.orgs_with_access.each do |org|
      org.projects.each do |project|
        @projects << ["#{org.display_name}-#{project.display_name}", project.id] if project.can_user PermissionManager::CREATE, 'apps', current_user
      end
    end
  end

  def visit
    app = App.find(params[:id])
    access_token_records = UserAccessToken.get_access_tokens(current_user, :facebook).values
    if (access_token_records.count == 1)

      api = Facebook::Api.new access_token_records.first.token

      #TODO pass other types like profile, app, etc
      api.visit :website, "http://#{app.url}"
    end
    redirect_to "http://#{app.url}"
  end

  # GET /apps
  # GET /apps.json
  def index
    # TODO: Only show the orgs that the logged in user has access
    @apps = App.all

    respond_to do |format|
      format.html # index.html.erb
      format.json  { render :json => @apps }
    end
  end

  # GET /apps/1
  # GET /apps/1.json
  def show
    @app = App.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json  { render :json => @app }
    end
  end

  # GET /apps/new
  # GET /apps/new.json
  def new
    @app = App.new

    respond_to do |format|
      format.html # new.html.erb
      format.json  { render :json => @app }
    end
  end

  # GET /apps/1/edit
  def edit
    @app = App.find(params[:id])
  end

  # POST /apps
  # POST /apps.json
  def create
    #TODO: Assign the newly app service to the user's current org
    @app = App.new(params[:app])
    @app.creator = current_user
    begin
      @app.project = Project.find params[:app][:project_id]
    rescue
    end

    respond_to do |format|
      if @app.save
        format.html { redirect_to(@app, :notice => 'App was successfully created.') }
        format.json  { render :json => @app, :status => :created, :location => @app }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /apps/1
  # PUT /apps/1.json
  def update
    @app = App.find(params[:id])

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to(@app, :notice => 'App was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @app.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /apps/1
  # DELETE /apps/1.json
  def destroy
    @app = App.find(params[:id])
    @app.destroy

    respond_to do |format|
      format.html { redirect_to(apps_url) }
      format.json  { head :ok }
    end
  end
end
