#initializers/carrierwave.rb
require 'serve_gridfs_image'
require 'mongo_cloud_foundry'

Mongoid.configure do |config|
  config.master = CloudFoundry::MongoEnv.getDB
end

CarrierWave.configure do |config|
  config.storage = :grid_fs
  config.grid_fs_connection = Mongoid.database

  # Storage access url
  config.grid_fs_access_url = "/grid"
end
