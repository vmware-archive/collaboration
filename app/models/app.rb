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

  def info
    AppInfo.find_or_create_by(app_id: id)
  end

  # Takes the response from the Cloud Foundry API and Updates the local copy
  def self.create_or_find app_hash, current_user, email
    begin
      url = app_hash['uris'].first
      app = App.find_by_url url
      unless (app)
        logger.info "Could not find #{app_hash.inspect} -- Creating"
        app = App.create!({
          :display_name => app_hash['name'],
          :state => app_hash['state'],
          :url => url,
          :framework => app_hash['staging']['model'],
          :runtime => app_hash['staging']['stack'],
          :creator => current_user,
          :project => current_user.personal_org.default_project
        })
      end
      app.add_health_snapshot app_hash, email
      app.store_current_info! app_hash

      return app
    rescue Exception => ex
      logger.error "Could not import #{app_hash['name']} due to #{ex.inspect}"
    end
    nil
  end

  def store_current_info! app_hash
    app_services = app_hash['services']
    info.services = {}
    app_services.each do |service_name|
      service = Service.find_by_display_name(service_name)
      info.services[service_name] = service.display_name
    end

    app_vars = app_hash['env']
    info.env_vars = {}
    app_vars.each do |env|
      key, val = env.split '='
      #More secure not to store this
      info.env_vars[key] ||= "Describe how to get value"
    end

    info.save!
  end


  def latest_health_snapshot
    AppHealthSnapshot.latest id
  end

  def add_health_snapshot app_hash, email
    begin
      app_health = {
         :app_id => id,
         :email => email,
         :provider => "cloudfoundry.com",
         :running_instances => app_hash['runningInstances'],
         :instances => app_hash['instances']
       }
      AppHealthSnapshot.create! app_health
    rescue Exception => ex
       logger.error "Could not store health snapshot for #{id} due to #{ex}"
    end
  end

  def main_owned_resource
    if owned_resources.count >0
      owned_resources.first
    else
      nil
    end
  end
end
