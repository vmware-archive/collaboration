require 'permission_manager'
class ApplicationController < ActionController::Base
  protect_from_forgery
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

  def check_action_can_be_done
    permission_needed = REST_TO_CRUD[params[:action].to_sym]
    path = request.path
    org = nil
    logger.info "Starting Authorization for #{current_user}"
    if (request.path_parameters.has_key? :org_id)
      org = Org.find params[:org_id]
      logger.info "Org = #{org}"
      path.gsub! "/orgs/#{params[:org_id]}/", ''
      if (org && !permission_needed.nil? & path)
        org.projects.each do |project|
          return true if project.can_user permission_needed, path, current_user
          logger.info " No permission #{permission_needed} in project #{project} for path #{path}"
        end
        redirect_to :root, :status => 401
        return false
      end
      end
    logger.info "No security controls for #{path}"
    return true

  end

end
