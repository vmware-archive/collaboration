class User < ActiveRecord::Base
  has_many :acls, :as => :entity
  has_many :projects, :through => :acls
  has_many :orgs, :through => :projects
  has_many :group_members, :dependent => :destroy

  validates_presence_of :display_name
end
