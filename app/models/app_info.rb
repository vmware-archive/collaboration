class AppInfo
  include Mongoid::Document
  include Mongoid::Timestamps

  field :app_id, :type => Integer
  field :services, :type => Hash
  field :env_vars, :type => Hash

  index :app_id, :unique => true

end
