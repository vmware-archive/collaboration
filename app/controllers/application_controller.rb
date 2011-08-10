class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  before_filter :check_action_can_be_done

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
     true
  end

end
