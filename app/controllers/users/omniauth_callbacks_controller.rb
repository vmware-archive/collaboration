class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    # You need to implement the method below in your model
    @user = User.find_for_facebook_oauth(env["omniauth.auth"], current_user)

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