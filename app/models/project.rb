class Project < ActiveRecord::Base
  belongs_to :organization
  has_many :resource_assignments, :dependent => :destroy
end
