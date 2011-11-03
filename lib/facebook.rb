require 'rest_client'

module Facebook
  class Api

    attr_accessor :access_token

    def initialize access_token
      @access_token = access_token
    end

    #curl -F 'access_token=AAACGevZC4u8sBACE77ZASJBBFKuiuVEkqkRDKdX5h3h8B56PslL4NDiP01IoydLp1wptIxD7RxW77cGM3OHWC4IfwbMuQZD' \
    #     -F 'app=http://samples.ogp.me/178630275546435' \
    #        'https://graph.facebook.com/me/developer_activity:visit'

    def visit type, obj_id
      resp = nil
      begin
        resp = RestClient.post "https://graph.facebook.com/me/developer_activity:visit", type => obj_id, :access_token => @access_token
      rescue Exception => ex
        puts "Exception #{ex.inspect} for app #{obj_id}"
      end
    end

  end
end