class Group < ActiveRecord::Base
  belongs_to :org
  has_many :resource_assignments, :as => :entity
end
