class Project < ActiveRecord::Base
  belongs_to :org
  has_many :resource_assignments, :dependent => :destroy

  validates_presence_of :display_name
end
