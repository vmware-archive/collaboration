class Group < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :as => :entity
  has_many :group_members, :dependent => :destroy

  validates_presence_of :display_name
end
