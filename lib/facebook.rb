require 'rest_client'

module Facebook
  class Api

    attr_accessor :access_token

    def initialize access_token
      @access_token = access_token
    end

    def visit url
      link = "https://graph.facebook.com/me/developer_activity:visit?access_token=#{access_token}"
      puts "LINK = #{link}"
      RestClient.post link, :params => "app=#{url}"
    end

  end
end