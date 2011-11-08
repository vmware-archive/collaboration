class Service < ActiveRecord::Base
  has_many :owned_resources, :as => :resource, :dependent => :destroy

  attr_accessor :creator, :project, :project_id

  validates_presence_of :display_name
  validates_presence_of :creator, :on => :create
  validates_presence_of :project, :on => :create

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

  def self.create_or_find service_hash
    service = Service.find_by_display_name service_hash[:display_name]
    unless (service)
      logger.info "Could not find #{service.inspect} -- Creating"
      service = Service.create! service_hash
    end
    service
  end
end
