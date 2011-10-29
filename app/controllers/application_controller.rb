require 'permission_manager'
require 'facebook_cookie'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :check_fb_cookie
  before_filter :authenticate_user!
  before_filter :check_action_can_be_done

  REST_TO_CRUD = {
      :index => PermissionManager::READ,
      :show => PermissionManager::READ,
      :new => PermissionManager::CREATE,
      :create => PermissionManager::CREATE,
      :destroy => PermissionManager::DELETE,
      :update => PermissionManager::UPDATE,
      :edit => PermissionManager::UPDATE
  }
  def check_fb_cookie
    unless current_user
      if (params['controller'] == "devise/sessions" && params['action'] == 'new' )
        code = FacebookCookie.get_fb_code request.cookies
        if (code)
         redirect_to "/users/auth/facebook"
        end
      end
    end
  end

  def identify_parent
    if params.has_key? :org_id
      @org = Org.find params[:org_id]
      if params.has_key? :group_id
        @group = @org.groups.find params[:group_id]
      elsif params.has_key? :project_id
        @project = @org.projects.find params[:project_id]
      end
    end
  end

  def permission_needed
    return REST_TO_CRUD[params[:action].to_sym] if params[:action]
    nil
  end

  def get_repo_and_path
    repo = nil
    path = request.path

    if (request.path_parameters.has_key? :org_id)
      repo = Org.find params[:org_id]
      path.gsub! "/orgs/#{params[:org_id]}/", ''
    elsif (request.path_parameters.has_key? 'user_id')
      repo = User.find(params[:user_id]).personal_org
    elsif request.path_parameters.has_key?(:id)
      case params['controller']
        when "orgs"
          repo = Org.find params[:id]
          path = ''
        when "users"
          repo = User.find(params[:id]).personal_org
        when "apps"
          repo = App.find(params[:id]).main_owned_resource
      end
    end

    logger.info "Auth repo = #{repo}"
    logger.info "Target Path = #{path}"
    [repo, path]
  end

  def check_action_can_be_done
    logger.info "Starting Authorization for #{current_user} with controller #{params['controller']}"
    auth_repo, path = get_repo_and_path
    perms = permission_needed
    if (auth_repo && perms && path)
      return true if auth_repo.can_user perms, path, current_user
      redirect_to :root, :status => 401
      return false
    end

    logger.info "No security controls for #{path}"
    return true

  end

end
