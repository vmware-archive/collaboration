class Group < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :as => :entity
  has_many :group_members, :dependent => :destroy

  validates_uniqueness_of :display_name, :scope => :org_id
  validates_presence_of :display_name
end
