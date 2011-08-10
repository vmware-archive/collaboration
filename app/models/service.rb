class Service < ActiveRecord::Base
  has_many :owned_resources, :as => :resource

  attr_accessor :creator, :project

  validates_presence_of :display_name
  validates_presence_of :creator, :on => :create
  validates_presence_of :project, :on => :create

  after_create do
    project.org.owned_resources.build :resource => self
  end
end
