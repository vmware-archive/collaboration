module AclsHelper
  def resource_url acl
    if acl.owned_resource
      if acl.owned_resource.resource_type == 'App'
        return app_path(acl.owned_resource.resource)
      else
        return service_path(acl.owned_resource.resource)
      end
    elsif acl.route
      items = acl.route.split "*"
      path = items[0]
      unless (path[0] == '/')
        path = "#{org_path(acl.project.org)}/#{path}"
      end
      return path
    end
    ''
  end
end
