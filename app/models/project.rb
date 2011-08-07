class Project < ActiveRecord::Base
  belongs_to :org
  has_many :resource_assignments, :dependent => :destroy
end
