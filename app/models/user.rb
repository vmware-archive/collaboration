class User < ActiveRecord::Base
  has_many :resource_assignments, :as => :entity
  has_many :projects, :through => :resource_assignments
  has_many :organizations, :through => :projects
end
