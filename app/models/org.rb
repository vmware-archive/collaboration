class Org < ActiveRecord::Base
  has_many :projects, :dependent => :destroy
  has_many :groups, :dependent => :destroy
  has_many :owned_resources, :dependent => :destroy, :as => :owner
  has_many :apps, :through => :owned_resources

  validates_presence_of :display_name
  attr_accessor :creator
  validates_presence_of :creator, :on => :create

  after_create do
    admins = self.groups.build :display_name => 'Admins'
    admins.save!
    member = admins.group_members.build :user => @creator
    member.save!
    devs = self.groups.build :display_name => 'Developers'
    devs.save!
    default_project = self.projects.build :display_name => 'Default', :is_default => true
    default_project.save!
    acl = default_project.acls.build :route => 'groups', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'groups/*/group_members', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'projects', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'projects/*/acls', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'projects/*/acls/*', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'owned_resources', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
    acl = default_project.acls.build :route => 'owned_resources/*', :permission_set => PermissionManager::ALL, :entity => admins
    acl.save!
  end

public
  def can_user(perm_to_check, path, user)
    default_project = projects.find_by_display_name 'Default'
    if default_project
      default_project.can_user(perm_to_check, path, user)
    else
      false
    end
  end
end
