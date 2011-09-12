class Project < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :dependent => :destroy

  validates_presence_of :display_name
  validates_uniqueness_of :display_name, :scope => :org_id

  attr_accessor :is_default, :admin_group, :dev_group

  before_create do
    add_admin_role @admin_group if @admin_group
    add_dev_role @dev_group if @dev_group
  end

  def add_dev_role devs
    acls.build :route => 'apps' , :permission_set => PermissionManager::ALL, :entity => devs
    acls.build :route => 'services' , :permission_set => PermissionManager::ALL, :entity => devs
  end

  def add_admin_role admins
    acls.build :route => 'groups', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'groups/*/group_members', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'projects', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'projects/*/acls', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'projects/*/acls/*', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'owned_resources', :permission_set => PermissionManager::ALL, :entity => admins
    acls.build :route => 'owned_resources/*', :permission_set => PermissionManager::ALL, :entity => admins
  end

  public
    def to_s
      display_name
    end

    def can_user(perm_to_check, path, user)
      perms = 0
      acls.find_each do |acl|
        route_expr = acl.route.gsub '*', '.+' if acl.route
        route_expr = "#{acl.owned_resource.resource_type.pluralize}/#{acl.owned_resource.resource_id}" if (acl.owned_resource)
        if (route_expr && path =~ Regexp.new(route_expr))
          if (acl.entity.class ==  User && acl.entity == user)
            perms = perms | acl.permission_set
          else
            acl.entity.group_members.each do |member|
              perms = perms | acl.permission_set if (member.user_id == user.id)
            end
          end
        end
      end
      return (perm_to_check & perms == perm_to_check)
    end
end
