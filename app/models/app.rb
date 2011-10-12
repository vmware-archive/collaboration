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

  def self.create_or_find app_hash
    app = App.find_by_url app_hash[:url]
    unless (app)
      logger.info "Could not find #{app_hash.inspect} -- Creating"
      app = App.create! app_hash
    end
    app
  end

  def latest_health_snapshot
    AppHealthSnapshot.latest id
  end

  def main_owned_resource
    if owned_resources.count >0
      owned_resources.first
    else
      nil
    end
  end
end
