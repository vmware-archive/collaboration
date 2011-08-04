class Group < ActiveRecord::Base
  belongs_to :organization
  has_many :resource_assignments, :as => :entity
end
