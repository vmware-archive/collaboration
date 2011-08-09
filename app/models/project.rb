class Project < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :dependent => :destroy

  attr_accessor :is_default

  validates_presence_of :display_name

  public
    def can_user(perm_to_check, path, user)
      perms = 0
      acls.find_each do |acl|
        if acl.route == path
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
