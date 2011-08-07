class Group < ActiveRecord::Base
  belongs_to :org
  has_many :resource_assignments, :as => :entity

  validates_presence_of :display_name
end
