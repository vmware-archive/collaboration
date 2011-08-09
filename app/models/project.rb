class Project < ActiveRecord::Base
  belongs_to :org
  has_many :acls, :dependent => :destroy

  validates_presence_of :display_name
end
