class ServicesForApps
  include Mongoid::Document
  field :service_id, :type => Integer
  field :app_id, :type => Integer

  index :app_id
end
