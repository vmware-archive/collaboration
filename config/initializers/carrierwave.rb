#initializers/carrierwave.rb
require 'serve_gridfs_image'

CarrierWave.configure do |config|
  config.storage = :grid_fs

  conn_info = nil

  if ENV['VCAP_SERVICES']
    services = JSON.parse(ENV['VCAP_SERVICES'])
    services.each do |service_version, bindings|
      bindings.each do |binding|
        if binding['label'] =~ /mongo/i
          conn_info = binding['credentials']
          break
        end
      end
    end
    raise "could not find connection info for mongo" unless conn_info
  else
    conn_info = {'hostname' => 'localhost', 'port' => 27017}
  end

  cnx = Mongo::Connection.new(conn_info['hostname'], conn_info['port'], :pool_size => 5, :timeout => 5)
  db = cnx['db']

  if conn_info['username'] and conn_info['password']
    db.authenticate(conn_info['username'], conn_info['password'])
  end


  config.grid_fs_connection = db

  # Storage access url
  config.grid_fs_access_url = "/grid"
end
