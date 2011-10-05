class App < ActiveRecord::Base
  has_many :owned_resources, :as => :resource, :dependent => :destroy

  attr_accessor :creator, :project, :project_id

  validates_presence_of :display_name, :url

  validates_presence_of :creator, :on => :create
  validates_presence_of :project, :on => :create

  validates_uniqueness_of :url

  after_create do
    owned_res = project.org.owned_resources.build :resource => self
    owned_res.save!
  end


  def main_owned_resource
    if owned_resources.count >0
      owned_resources.first
    else
      nil
    end
  end
end
