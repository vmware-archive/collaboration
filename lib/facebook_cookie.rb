require 'base64'
require 'openssl'

class FacebookCookie
  def self.base64_url_decode(str)
    str += '=' * (4 - str.length.modulo(4))
    Base64.decode64(str.tr('-_','+/'))
  end
  
  def self.get_fb_code cookies
    FacebookCookie.code(FacebookCookie.get_facebook_cookie(cookies))    
  end

   def self.get_facebook_cookie cookies    
     if (cookies["fbsr_#{ENV['facebook_app_id']}"])
       # Read cookie, and stop if there is none
       fb_cookie = cookies["fbsr_#{ENV['facebook_app_id']}"]
       secret = ENV['facebook_app_secret']
  
       # The cookie is a string of key=value separated with &, which we split into a hash
       encoded_sig, payload = fb_cookie.split('.')
  
       sig = FacebookCookie.base64_url_decode(encoded_sig)
  
       data = JSON.parse(FacebookCookie.base64_url_decode(payload))
  
       if (data['algorithm'].upcase != 'HMAC-SHA256')
         raise('Unknown algorithm. Expected HMAC-SHA256')
       end
  
       # check sig
       expected_sig = OpenSSL::HMAC.digest('sha256', secret, payload)
       if (sig != expected_sig)
         raise("Bad Signed JSON signature! #{sig} != #{expected_sig}")
       end
  
       puts "Facebook Data #{data}"
       return data
     end
     nil
   end

   def self.code(cookie_info)
       return unless cookie_info

       return cookie_info['code']
       #user = nil
       #uat = User.get_user_from_auth_by_id(:facebook, cookie_info['user_id'])
       #if (uat)
       #  user = User.find uat.user_id
       #  puts "************ Found user #{user}"
       #end
       #
       #user
     end

  
end