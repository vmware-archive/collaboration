class Project < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :dependent => :destroy

  validates_presence_of :display_name
  validates_uniqueness_of :display_name, :scope => :org_id

  attr_accessor :is_default



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
