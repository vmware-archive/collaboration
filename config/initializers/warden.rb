require 'base64'
require 'openssl'

Warden::Strategies.add(:facebook_cookie) do
  def valid?
    cookies["fbsr_#{ENV['facebook_app_id']}"]
  end

  def authenticate!
    u = user_from_cookie(get_facebook_cookie)
    u.nil? ? fail!("Could not log in with Facebook") : success!(u)
  end

  def base64_url_decode(str)
   str += '=' * (4 - str.length.modulo(4))
   Base64.decode64(str.tr('-_','+/'))
  end

  def get_facebook_cookie
    # Read cookie, and stop if there is none
    fb_cookie = cookies["fbsr_#{ENV['facebook_app_id']}"]
    secret = ENV['facebook_app_secret']

    # The cookie is a string of key=value separated with &, which we split into a hash
    encoded_sig, payload = fb_cookie.split('.')

    sig = base64_url_decode(encoded_sig)

    data = JSON.parse(base64_url_decode(payload))

    if (data['algorithm'].upcase != 'HMAC-SHA256')
      raise('Unknown algorithm. Expected HMAC-SHA256')
    end

    # check sig
    expected_sig = OpenSSL::HMAC.digest('sha256', secret, payload)
    if (sig != expected_sig)
      raise("Bad Signed JSON signature! #{sig} != #{expected_sig}")
    end

    return data

  end

  def user_from_cookie(cookie_info)
      return unless cookie_info

      code = cookie_info['code']


      user = nil
      uat = UserAccessToken.find_by_provider_user_id(cookie_info['user_id'])
      if (uat)
        user = User.find uat.user_id
      end
      user ||= User.new

      # TODO: Get Access Token

      #user.access_token = cookie_info['access_token']
      #ut = UserAccessToken.add_tokens email, provider, env["omniauth.auth"]['credentials']
      #
      ## If the access_token has changed, then this is either a new user
      ## or a user that just logged in, so we reload the users data
      #if user.access_token_changed?
      #  fb_info = user_from_facebook(cookie_info)
      #  return unless fb_info
      #  user.update_attributes(fb_info.slice(*User.column_names))
      #end

      user
    end


end