class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

    #Facebook {"provider"=>"facebook", "uid"=>"608201527",
    #"credentials"=>{"token"=>"147862838623179|1de66c285580f2db308d7c78.1-608201527|a7wAL8ZdROt7nc7xuveTGF3hSq4"},
    #"user_info"=>{"nickname"=>"mciberch", "email"=>"monica.keller@gmail.com", "first_name"=>"Monica", "last_name"=>"Wilkinson", "name"=>"Monica Wilkinson",
    #"image"=>"http://graph.facebook.com/608201527/picture?type=square", "urls"=>{"Facebook"=>"http://www.facebook.com/mciberch", "Website"=>nil}},
    #"extra"=>{"user_hash"=>{"id"=>"608201527", "name"=>"Monica Wilkinson", "first_name"=>"Monica", "last_name"=>"Wilkinson", "link"=>"http://www.facebook.com/mciberch",
    #"username"=>"mciberch", "hometown"=>{"id"=>"111927722166897", "name"=>"Miraflores, Lima"}, "location"=>{"id"=>"114952118516947", "name"=>"San Francisco, California"},
    #"work"=>[{"employer"=>{"id"=>"6975960973", "name"=>"VMware"}, "location"=>{"id"=>"114952118516947", "name"=>"San Francisco, California"}, "position"=>{"id"=>"166250323386748",
    #"name"=>"Developer Relations"}, "start_date"=>"2011-03"}, {"employer"=>{"id"=>"117552131632137", "name"=>"Socialcast"}, "location"=>{"id"=>"114952118516947",
    #"name"=>"San Francisco, California"}, "position"=>{"id"=>"140805275954087", "name"=>"Director of Engineering"}, "start_date"=>"2010-08", "end_date"=>"0000-00",
    #"projects"=>[{"id"=>"202447213102787", "name"=>"REACH", "description"=>"Microdata and Open Graph Protocol", "start_date"=>"2011-08"}, {"id"=>"206467319365540",
    #"name"=>"Topics: Hashtag Evolution", "description"=>"http://blog.socialcast.com/evolving-hashtags-making-tags-user-friendly/", "start_date"=>"2010-11", "end_date"=>"2011-03"},
    #{"id"=>"202228549796466", "name"=>"Rich Link Previews in Stream", "description"=>"Open Graph Protocol", "start_date"=>"2010-11", "end_date"=>"2011-02"}]},
    #{"employer"=>{"id"=>"20531316728", "name"=>"Facebook"}, "location"=>{"id"=>"104022926303756", "name"=>"Palo Alto, California"}, "position"=>{"id"=>"144501312279361",
    #"name"=>"Open Source and Web Standards Program Manager"}, "start_date"=>"2010-02", "end_date"=>"2010-08", "projects"=>[{"id"=>"115697131833606", "name"=>"Real Time Updates",
    #"with"=>[{"id"=>"17200549", "name"=>"Yuliy Pisetsky"}, {"id"=>"543103413", "name"=>"TR Vishwanath"}, {"id"=>"711562108", "name"=>"Wei Zhu"}], "start_date"=>"2010-04",
    #"end_date"=>"2010-08"}, {"id"=>"196763383682297", "name"=>"HTML5 Education", "start_date"=>"2010-03", "end_date"=>"2010-08"}]}, {"employer"=>{"id"=>"7366200613", "name"=>"Myspace"},
    #"location"=>{"id"=>"112456468765632", "name"=>"Beverly Hills, California"}, "position"=>{"id"=>"187438718368", "name"=>"grouparchitect"}, "start_date"=>"2007-07",
    #"end_date"=>"2010-02", "projects"=>[{"id"=>"149735935086875", "name"=>"Activity Streams Platform", "with"=>[{"id"=>"613438416", "name"=>"Chris Bissell"}, {"id"=>"686585986",
    #"name"=>"Neal Hardesty"}, {"id"=>"651335260", "name"=>"Oleg Pylnev"}, {"id"=>"1389551348", "name"=>"Shant Kehiaian"}, {"id"=>"722012284", "name"=>"Vishal Shah"},
    #{"id"=>"508628082", "name"=>"Dave Buck"}, {"id"=>"620731757", "name"=>"Erik Nelson"}], "start_date"=>"2007-07", "end_date"=>"2010-02"}]}, {"employer"=>{"id"=>"108013749227135",
    #"name"=>"SumTotal Systems"}, "location"=>{"id"=>"108450559178997", "name"=>"Columbus, Ohio"}, "position"=>{"id"=>"120873084626704", "name"=>"Architect"}, "start_date"=>"2002-02",
    #"end_date"=>"2007-06"}], "sports"=>[{"id"=>"105650876136555", "name"=>"Tennis", "with"=>[{"id"=>"748895436", "name"=>"Kace Ejercito"}, {"id"=>"1173156333",
    #"name"=>"Silvia Montero Monahan"}, {"id"=>"100001835342538", "name"=>"Yeewah Young"}, {"id"=>"1324135571", "name"=>"Jana Conley"}, {"id"=>"820018064", "name"=>"Jan Leger"},
    #{"id"=>"781293669", "name"=>"Heidi Lyons"}, {"id"=>"780859294", "name"=>"Debbie Deb"}, {"id"=>"777929637", "name"=>"Christa Beckner"}, {"id"=>"618481762", "name"=>"Matt Wilkinson"},
    #{"id"=>"599858786", "name"=>"Deb Cullen"}, {"id"=>"516210646", "name"=>"Jordana Assaf Templin"}, {"id"=>"500091600", "name"=>"Ana Ramos"}, {"id"=>"1310091",
    #"name"=>"Vineeta Bathia Gajwani"}], "description"=>"USTA 4.0"}], "favorite_athletes"=>[{"id"=>"112827448730656", "name"=>"Justine Henin"}, {"id"=>"64822581025",
    #"name"=>"Rafael Nadal"}, {"id"=>"64760994940", "name"=>"Roger Federer"}, {"id"=>"111054225589401", "name"=>"Kim Clisters"}, {"id"=>"65920772679", "name"=>"Maria Sharapova"}],
    #"gender"=>"female", "email"=>"monica.keller@gmail.com", "timezone"=>-7, "locale"=>"en_US", "languages"=>[{"id"=>"110343528993409", "name"=>"Spanish"}, {"id"=>"108106272550772",
    #"name"=>"French"}, {"id"=>"106059522759137", "name"=>"English"}], "verified"=>true, "updated_time"=>"2011-10-03T21:37:19+0000"}}}
    session['devise.facebook'] = env["omniauth.auth"].delete 'credentials'

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Facebook"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = 'No Account found on App Gallery. Please Sign Up to import Apps'
      begin
        env["omniauth.auth"].delete 'extra'
        session["devise.omniauth_info"] = env["omniauth.auth"]
        redirect_to new_user_registration_url
      rescue Exception => ex
        puts ex
      end
    end
  end

  def cloudfoundry
    # You need to implement the method below in your model
    @user = User.find_for_cloudfoundry_oauth(env["omniauth.auth"], current_user)
    #{"provider"=>"cloudfoundry", "uid"=>nil, "credentials"=>{"token"=>"f6b6eae3-e9bc-4cd9-ae73-24d411033f49", "refresh_token"=>"ea0ce292-f665-44b9-a8c8-dd3a08ece075"},
    #"user_info"=>{"email"=>"mwilkinson@vmware.com"}, "extra"=>{"user_hash"=>{"name"=>"vcap", "build"=>2222, "support"=>"http://support.cloudfoundry.com", "version"=>"0.999",
    #"description"=>"VMware's Cloud Application Platform", "allow_debug"=>false, "user"=>"mwilkinson@vmware.com", "limits"=>{"memory"=>2048, "app_uris"=>4, "services"=>16, "apps"=>20},
    #"usage"=>{"memory"=>512, "apps"=>3, "services"=>3}, "frameworks"=>{"java_web"=>{"name"=>"java_web", "runtimes"=>[{"name"=>"java", "version"=>1.6, "description"=>"Java 6"}],
    #"appservers"=>[{"name"=>"tomcat", "description"=>"Tomcat"}], "detection"=>[{"*.war"=>true}]}, "sinatra"=>{"name"=>"sinatra", "runtimes"=>[{"name"=>"ruby18", "version"=>"1.8.7",
    #"description"=>"Ruby 1.8"}, {"name"=>"ruby19", "version"=>"1.9.2p180", "description"=>"Ruby 1.9"}], "appservers"=>[{"name"=>"thin", "description"=>"Thin"}],
    #"detection"=>[{"*.rb"=>"require 'sinatra'|require \"sinatra\""}, {"config/environment.rb"=>false}]}, "rails3"=>{"name"=>"rails3", "runtimes"=>[{"name"=>"ruby18", "version"=>"1.8.7",
    #"description"=>"Ruby 1.8"}, {"name"=>"ruby19", "version"=>"1.9.2p180", "description"=>"Ruby 1.9"}], "appservers"=>[{"name"=>"thin", "description"=>"Thin"}],
    #"detection"=>[{"config/application.rb"=>true}, {"config/environment.rb"=>true}]}, "lift"=>{"name"=>"lift", "runtimes"=>[{"name"=>"java", "version"=>1.6, "description"=>"Java 6"}],
    #"appservers"=>[{"name"=>"tomcat", "description"=>"Tomcat"}], "detection"=>[{"*.war"=>true}]}, "node"=>{"name"=>"node", "runtimes"=>[{"name"=>"node", "version"=>"0.4.5",
    #"description"=>"Node.js"}], "appservers"=>[], "detection"=>[{"*.js"=>"."}]}, "grails"=>{"name"=>"grails", "runtimes"=>[{"name"=>"java", "version"=>1.6, "description"=>"Java 6"}],
    #"appservers"=>[{"name"=>"tomcat", "description"=>"Tomcat"}], "detection"=>[{"*.war"=>true}]}, "spring"=>{"name"=>"spring", "runtimes"=>[{"name"=>"java", "version"=>1.6,
    #"description"=>"Java 6"}], "appservers"=>[{"name"=>"tomcat", "description"=>"Tomcat"}], "detection"=>[{"*.war"=>true}]}}, "org"=>"mwilkinson@vmware.com",
    #"prompt"=>{"email"=>["text", "CloudFoundry ID (email)"], "password"=>["password", "CloudFoundry Password"]}}}}
    session['devise.cloudfoundry'] = env["omniauth.auth"].delete 'credentials'

    logger.info "ok #{session['devise.cloudfoundry'].inspect}" if session.has_key?'devise.cloudfoundry'

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Cloudfoundry"
      sign_in_and_redirect @user, :event => :authentication
    else
      flash[:notice] = 'No Account found on App Gallery. Please Sign Up to import Apps'
      env["omniauth.auth"].delete 'extra'
      session["devise.omniauth_info"] = env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

end