class Group < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls
  has_many :group_members, :dependent => :destroy

  validates_uniqueness_of :display_name, :scope => :org_id
  validates_presence_of :display_name

  public
    def includes? user
      group_members.each do |member|
        return true if (member.user_id == user.id)
      end
      false
    end
end
