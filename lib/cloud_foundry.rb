require 'omniauth/oauth'
require 'multi_json'

# <oauth:client clientId="oauth_cf_callback" resource-ids="api"
# authorizedGrantTypes="authorization_code,refresh_token" scope="read_vcap,write_vcap" authorities="ROLE_GUEST"/>
module OmniAuth
  module Strategies
    class Cloudfoundry < OmniAuth::Strategies::OAuth2
      def initialize(app, client_id=nil, client_secret=nil, options={}, &block)
        client_options = {
            :site => ENV['cloudfoundry_auth_server'],
            :authorize_url =>'/oauth/user/authorize?resource_id=app&scope=read_vcap,write_vcap',
            :token_url => '/oauth/authorize?scope=read_vcap,write_vcap',
            :ssl=>{:verify=>false}
        }

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

