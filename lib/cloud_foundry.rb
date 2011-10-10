require 'omniauth/oauth'
require 'multi_json'

module CloudFoundry

  class Api

    attr_accessor :access_token

    OAUTH_OPTIONS = {
            :site => ENV['cloudfoundry_auth_server'],
            :authorize_url =>'/oauth/user/authorize?resource_id=app&scope=read_vcap,write_vcap',
            :token_url => '/oauth/authorize?scope=read_vcap,write_vcap',
            :ssl=>{:verify=>false}
        }

    def initialize session_info
      @client = OAuth2::Client.new( ENV['cloudfoundry_client_id'], ENV['cloudfoundry_client_secret'], CloudFoundry::Api::OAUTH_OPTIONS)
      @access_token = nil
      if session_info
        @access_token = OAuth2::AccessToken.from_hash @client, session_info
      else
        puts "No access token"
      end
    end

    # [{"name"=>"salesforce-demo", "staging"=>{"model"=>"sinatra", "stack"=>"ruby19"}, "uris"=>["salesforce-demo.cloudfoundry.com"], "instances"=>1, "runningInstances"=>nil,
    #"resources"=>{"memory"=>128, "disk"=>2048, "fds"=>256}, "state"=>"STARTED", "services"=>["redis-8dedb"], "version"=>"f7fd7a0922cb26c6bb2d795737dfd66f49877944-1",
    #"env"=>["salesforce_key=bbb", "salesforce_secret=oooo",
    #"linkedin_key=bbb", "linkedin_secret=tttt", "salesforce_instance_url=na3"], "meta"=>{"debug"=>nil, "version"=>1014, "created"=>1317854795}},
    #{"name"=>"SuperSalads", "staging"=>{"model"=>"sinatra", "stack"=>"ruby18"}, "uris"=>["supersalads.cloudfoundry.com"], "instances"=>1, "runningInstances"=>nil,
    #"resources"=>{"memory"=>128, "disk"=>2048, "fds"=>256}, "state"=>"STARTED", "services"=>[], "version"=>"e35bec3dace813a750500ab2e5dcbfbcd4ed8ecf-3",
    #"env"=>["FACEBOOK_APP_ID=ooop", "FACEBOOK_SECRET=ewewew"], "meta"=>{"debug"=>nil, "version"=>8, "created"=>1317854796}},
    #{"name"=>"collaboration", "staging"=>{"model"=>"rails3", "stack"=>"ruby19"}, "uris"=>["collaboration.cloudfoundry.com"], "instances"=>1, "runningInstances"=>nil,
    #"resources"=>{"memory"=>256, "disk"=>2048, "fds"=>256}, "state"=>"STARTED", "services"=>["mongodb-1d07b", "mysql-ad96e"],
    #"version"=>"6a7c2edb8b502a9bfb7b5f94abc781d8da3539b9-1", "env"=>["facebook_app_id=sdsd", "facebook_app_secret=wwwww",
    #"cloudfoundry_auth_server=https://dsyerauth.cloudfoundry.com/", "cloudfoundry_client_id=oauth_cf_callback", "cloudfoundry_client_secret=dsdsdsds",
    #"cloudfoundry_resource_server=https://dsyerapi.cloudfoundry.com/"], "meta"=>{"debug"=>nil, "version"=>369, "created"=>1317854796}}, {"name"=>"developers",
    #"staging"=>{"model"=>"sinatra", "stack"=>"ruby18"}, "uris"=>["developers.cloudfoundry.com"], "instances"=>1, "runningInstances"=>nil, "resources"=>{"memory"=>128,
    #"disk"=>2048, "fds"=>256}, "state"=>"STARTED", "services"=>[], "version"=>"4f70937586e6ea8b454d5823eddc1c203b23d6ec-3", "env"=>["facebook_app_id=147862838623179",
    #"internal_link_apps=http://collaboration.cloudfoundry.com", "internal_link_faq=http://faq.cloudfoundry.com", "external_link_blog=http://blog.cloudfoundry.com",
    #"external_link_support=http://support.cloudfoundry.com"], "meta"=>{"debug"=>nil, "version"=>177, "created"=>1317854796}}]
    def apps
      begin
        return @access_token.get("#{ENV['cloudfoundry_resource_server']}apps") if @access_token
      rescue OAuth2::Error => ex
        puts "Got error getting apps #{ex.inspect}"
      end
      []
    end
  end

end

# <oauth:client clientId="oauth_cf_callback" resource-ids="api"
# authorizedGrantTypes="authorization_code,refresh_token" scope="read_vcap,write_vcap" authorities="ROLE_GUEST"/>
module OmniAuth
  module Strategies
    class Cloudfoundry < OmniAuth::Strategies::OAuth2
      def initialize(app, client_id=nil, client_secret=nil, options={}, &block)
        client_options = CloudFoundry::Api::OAUTH_OPTIONS

        super(app, :cloudfoundry, client_id, client_secret, client_options, options, &block)
      end

      def auth_hash
        x = OmniAuth::Utils.deep_merge(
          super, {
            'uid' => user_hash['user_id'],
            'user_info' => user_info,
            'extra' => {
                'user_hash' => user_hash
            },
          }
        )
      end

      # Eventually will support OpenID Connect but for now we only get email
      # http://openid.net/specs/openid-connect-basic-1_0.html#anchor11
      def user_info
        user_hash = self.user_hash
        {
          #'nickname' => user_hash['nickname'],
          #'name' => user_hash['name'],
          #'first_name' => user_hash['given_name'],
          #'last_name' => user_hash['family_name'],
          'email' => user_hash['user']
          #'location' => user_hash['address']['formatted'],
          #'image' => user_hash['picture'],
          #'phone' => user_hash['phone_number'],
          #'urls' => {
          #  'website' => user_hash['website'],
          #  'profile' => user_hash['profile']
          #},
        }
      end

      def user_hash
        begin
          resp = @access_token.get("#{ENV['cloudfoundry_resource_server']}info")
          return @user_hash ||= MultiJson.decode(resp.body)
        rescue ::OAuth2::Error => e
          raise "Error reading user info from Cloud Foundry  #{e.response.inspect}"
        end
      end
    end
  end
end
