#lib/serve_gridfs_image.rb

class ServeGridfsImage
  def initialize(app)
      @app = app
  end

  def call(env)
    if env["PATH_INFO"] =~ /^\/grid\/(.+)$/
      process_request(env, $1)
    else
      @app.call(env)
    end
  end

  private
  def process_request(env, key)
    begin
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
      Mongo::GridFileSystem.new(db).open(key, 'r') do |file|
        [200, { 'Content-Type' => file.content_type }, [file.read]]
      end
    rescue
      [404, { 'Content-Type' => 'text/plain' }, ['File not found.']]
    end
  end
end
