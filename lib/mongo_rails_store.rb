require 'action_dispatch/middleware/session/abstract_store'
require 'rack/session/mongo'

# Monkey Patch for now.
# TODO submit pull request so dbs which require username and pwd can work
module Rack
  module Session

    class Mongo
     def initialize(app, options = {})
        super
        @mutex = Mutex.new
        @pool = nil
        unless options.has_key? :database
          connection = @default_options[:connection] || ::Mongo::Connection.new
          @pool = connection.db(@default_options[:db]).collection(@default_options[:collection])
        else
          @pool = options[:database].collection(@default_options[:collection])
        end

        @pool.create_index([['expires', -1]])
        @pool.create_index('sid', :unique => true)
        @marshal_data = @default_options[:marshal_data].nil? ? true : @default_options[:marshal_data] == true
        @next_expire_period = nil
        @recheck_expire_period = @default_options[:clear_expired_after].nil? ? 1800 : @default_options[:clear_expired_after].to_i
      end
    end
  end

end

module ActionDispatch
  module Session
    class MongoRailsStore < Rack::Session::Mongo
      def initialize app, options
        super
      end
    end
  end
end